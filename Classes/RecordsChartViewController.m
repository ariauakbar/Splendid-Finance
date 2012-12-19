//
//  RecordsChartViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/19/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import "RecordsChartViewController.h"
#import "BNPieChart.h"
#import "Expense.h"
#import "PCPieChart.h"

@implementation RecordsChartViewController

@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"January 2012";
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
   
    
    [self calculatePieChart];
}

- (void) calculatePieChart {
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:10];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ExpenseCategory"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    }
    
    for(NSManagedObject *category in fetchedObjects){
     //   if([category valueForKey:@"name"])
       // {
        NSInteger totalExpense = 0;
        
            NSSet *expenses = [category valueForKey:@"expenses"];
            NSLog(@"expenses %@ count: %d",[category valueForKey:@"name"], expenses.count);
        
        NSManagedObject *expense;
        NSEnumerator *it = [expenses objectEnumerator];
        // iterate every expenses for each category and get the expenseAmount
        while ((expense = [it nextObject] ) != NULL) {
        
            totalExpense += [[expense valueForKey:@"expenseAmount"] integerValue];
        
        }
        NSLog(@"totalExpense: %d", totalExpense);
        NSNumber *count = [NSNumber numberWithInt:totalExpense];
            //dict = [NSDictionary dictionaryWithObject:(id)expenses.count forKey:[category valueForKey:@"name"]];
        [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:count, @"count", [category valueForKey:@"name"], @"catname", nil]];
        
      
            
        //}
    }
    NSLog(@"transaction: %d", fetchedObjects.count);
    NSLog(@"dict: %@", array);
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
   // BNPieChart *pieChart = [[BNPieChart alloc] init];
    //pieChart.frame = CGRectMake(10.0, 0.0, 300.0, 300.0);
    
    int height = [self.view bounds].size.width/3*2.; // 220;
    int width = [self.view bounds].size.width; //320;
    PCPieChart *pieChart = [[PCPieChart alloc] initWithFrame:CGRectMake(([self.view bounds].size.width-width)/2,([self.view bounds].size.height-height)/3.5,width,height+200)];
    [pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [pieChart setDiameter:width/2];
    [pieChart setSameColorLabel:YES];
    
    [self.view addSubview:pieChart];
    NSMutableArray *components = [NSMutableArray array]; 
    pieChart.titleFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    
    for (int i = 0; i < array.count; i++) {
        
       // NSLog(@"array %@", [[array objectAtIndex:i] objectForKey:@"Food"]);
        NSNumber *count = [[array objectAtIndex:i] objectForKey:@"count"];
        NSString *catname = [[array objectAtIndex:i] objectForKey:@"catname"];
        if(count.integerValue >= 1)
        {
            //[pieChart addSlicePortion:(count.floatValue/[self totalTransaction]) withName:catname];
            PCPieComponent *component = [PCPieComponent pieComponentWithTitle:catname value:count.floatValue/[self totalTransaction]];
            [components addObject:component];
            
            if (i==0)
			{
				[component setColour:PCColorYellow];
			}
			else if (i==1)
			{
				[component setColour:PCColorGreen];
			}
			else if (i==2)
			{
				[component setColour:PCColorOrange];
			}
			else if (i==3)
			{
				[component setColour:PCColorRed];
			}
			else if (i==4)
			{
				[component setColour:PCColorBlue];
			}
            else if (i==5)
            {
                [component setColour:PCColorBrown];
            }
            else if (i==6)
            {
                [component setColour:PCColorPurple];
            }
            else if (i==7)
            {
                [component setColour:PCColorWhite];
            }
        }
        [pieChart setComponents:components];
    }
    
    //[self.view addSubview:pieChart];

    
}

- (NSInteger) totalTransaction {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expense"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expenseAmount"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    // implements aggregate function :sum
    NSExpression *expression = [NSExpression expressionForFunction:@"sum:" arguments:[NSArray arrayWithObject:[NSExpression expressionForKeyPath:@"expenseAmount"]]];
    
    
    NSExpressionDescription *expressionDescription = [[[NSExpressionDescription alloc] init] autorelease];
    [expressionDescription setName:@"totalToday"];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType: NSDecimalAttributeType];
    
    NSArray *properties = [NSArray arrayWithObject:expressionDescription];
    [fetchRequest setPropertiesToFetch:properties];
    [fetchRequest setResultType:NSDictionaryResultType];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    }
    
    NSString *totalExpense  = [[[fetchedObjects objectAtIndex:0] objectForKey:@"totalToday"] description];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    return [totalExpense integerValue];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)cancel {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
