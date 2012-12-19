//
//  GoalViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import "GoalViewController.h"
#import "AddGoalViewController.h"
#import "Goal.h"
#import "DashboardViewController.h"
#import "SplendidUtils.h"
#import "Income.h"
#import "Expense.h"
#import "GoalDetailTableViewController.h"


@interface AddGoalViewController (PrivateMethod)
- (void) addGoal;
@end

@implementation GoalViewController

@synthesize goals;
@synthesize managedObjectContext;
@synthesize noGoalsLabel;
@synthesize firstRun;
@synthesize monthsNeeded;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.tableView.backgroundColor = [UIColor clearColor];	self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50.0;
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.bounds;
	
	[self.navigationController.view addSubview:bodyImageView];
    [self.navigationController.view sendSubviewToBack:bodyImageView];
    [bodyImageView release];
	
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.shadowColor = [UIColor colorWithRed:186.0f/255.0f green:204.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
	titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
	[titleLabel setText:@"Goals"];
	titleLabel.textColor = [UIColor colorWithRed:69.0f/255.0f green:74.0f/255.0f blue:77.0f/255.0f alpha:1.0f];
	titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.alpha = 0.5;
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
	
	self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *addGoal = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGoal)];
    self.navigationItem.rightBarButtonItem = addGoal;
    [addGoal release];
	
	[titleLabel release];
    
    self.goals = [NSArray array];
    
    noGoalsLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 80.0, 252.0, 150.0)];

	
	//self.title = @"Splendid";
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Goal"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    }
    
    self.goals = fetchedObjects;
    NSLog(@"transaction: %d", goals.count);
    
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    if (fetchedObjects.count == 0 && firstRun == NO){
        
        if ([self.view superview] == noGoalsLabel) {
            
            NSLog(@"ss");
        }
        //noImageLabel.center = self.view.center;
        noGoalsLabel.textAlignment = UITextAlignmentLeft;
        noGoalsLabel.shadowColor = [UIColor whiteColor];
        noGoalsLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        noGoalsLabel.numberOfLines = 5;
        [noGoalsLabel setText:@"Goal helps you to measure and track your financial goal. It will ask you to save your money according to your setting every month."];
        noGoalsLabel.textColor = [UIColor colorWithRed:69.0f/255.0f green:74.0f/255.0f blue:77.0f/255.0f alpha:0.7f];
        noGoalsLabel.backgroundColor = [UIColor clearColor];
        //noImageLabel.alpha = 0.5;
        noGoalsLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
       // noGoalsLabel.hidden = YES;
        [self.view addSubview:noGoalsLabel];
        [noGoalsLabel release];
    }
    else {
        
        noGoalsLabel.hidden = YES;
        
    }
    
    [self.tableView reloadData];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger rows = self.goals.count == 0 ? 0 : self.goals.count; 
    
    return rows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
     NSManagedObject *object = [goals objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.indentationWidth = 20.0;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
        cell.textLabel.shadowColor = [UIColor whiteColor];
        cell.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        
        cell.detailTextLabel.shadowColor = [UIColor whiteColor];
        cell.detailTextLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
        label.textColor = [UIColor grayColor];
        label.shadowColor = [UIColor whiteColor];
        label.textAlignment = UITextAlignmentRight;
        label.shadowOffset = CGSizeMake(0.0, 1.0);
        label.frame = CGRectMake(175.0, 7.0, 120.0, 20.0);
        [label setText:[SplendidUtils currencyIDFormatWithString:  [[object valueForKey:@"price"] description]]];
        label.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:label];
        
    }
    
   
    cell.textLabel.text = [object valueForKey:@"what"];
    monthsNeeded = [[object valueForKey:@"price"] integerValue] / [[object valueForKey:@"asideAmount"] integerValue];
    //cell.detailTextLabel.text = [SplendidUtils currencyIDFormatWithString:  [[object valueForKey:@"price"] description]];
    NSString *asideAmount = [SplendidUtils currencyIDFormatWithString:[object valueForKey:@"asideAmount"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ for %d Months", asideAmount, abs(monthsNeeded)];
    
    
  
    
    // Configure the cell...
    UIImage *backgroundCell = [[UIImage imageNamed:@"cell_bg_5.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
    // UIImage *lbackgroundCell = [[UIImage imageNamed:@"cell_bg_5.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
    
    //cell.contentView.backgroundColor = [UIColor clearColor];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundCell] autorelease];
    cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cell.backgroundColor = [UIColor clearColor];
    cell.frame = cell.bounds;

    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    Goal *goal = [goals objectAtIndex:indexPath.row];
    
    GoalDetailTableViewController *goalDetailView = [[GoalDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    goalDetailView.goal = goal;
    goalDetailView.monthsLeft = monthsNeeded;
    [self.navigationController pushViewController:goalDetailView animated:YES];
    [goalDetailView release];
   // [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark -
#pragma mark ViewTransition

- (void) addGoal {
    
    Goal *goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:self.managedObjectContext];
    Income *income = [NSEntityDescription insertNewObjectForEntityForName:@"Income" inManagedObjectContext:self.managedObjectContext];
    
    AddGoalViewController *viewController = [[AddGoalViewController alloc] initWithStyle:UITableViewStyleGrouped];
    //viewController.managedObjectContext = self.managedObjectContext;
    viewController.goal = goal;
    viewController.income = income;
  
    UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.navigationController presentModalViewController:aNavController animated:YES];
    [viewController release];
    [aNavController release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

