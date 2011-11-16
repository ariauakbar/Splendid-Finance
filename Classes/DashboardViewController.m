//
//  DashboardViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import "DashboardViewController.h"
#import "SettingViewController.h"
#import "IncomeViewController.h"
#import "AddNewExpenseViewController.h"
#import "SplendidAppDelegate.h"
#import "Expense.h"

@implementation UINavigationBar (CustomImage)

-(void)drawRect:(CGRect)rect {
	
	UIImage *image = [UIImage imageNamed:@"navbar-.png"];
	[image drawInRect:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
}

@end

@interface DashboardViewController (PrivateMethod)
- (void)showSettingViewController;
- (void)showIncomeViewController;
- (void)updateExpenseTransaction;
- (void)insertNewExpense:(NSDecimalNumber *)expense;
- (void)addExpense;
- (void)addNewExpense;
- (void)updateTodayLabel;
@end


@implementation DashboardViewController


@synthesize todayExpenseLabel;
@synthesize managedObjectContext;
@synthesize fetchedResultsController;

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    [super dealloc];
    [managedObjectContext release];
    [fetchedResultsController release];
   // [self.todayExpenseLabel release];
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    
    self.title = @"Dashboard";
    self.tabBarItem.image = [UIImage imageNamed:@"home1.png"];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextShadowColor] forState:UIControlStateSelected];
	//self.view.backgroundColor = [UIColor whiteColor];
	// ****** Title Label View ******
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.shadowColor = [UIColor colorWithRed:186.0f/255.0f green:204.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
	titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
	[titleLabel setText:@"Splendid"];
	titleLabel.textColor = [UIColor colorWithRed:69.0f/255.0f green:74.0f/255.0f blue:77.0f/255.0f alpha:1.0f];
	titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.alpha = 0.5;
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
	
	self.navigationItem.titleView = titleLabel;
	
	[titleLabel release];
    
	// ***** Navigation Item ******
    UIBarButtonItem *settingBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Setting" style:UIBarButtonItemStylePlain target:self action:@selector(showSettingViewController)];
	self.navigationItem.rightBarButtonItem = settingBarButtonItem;
	[settingBarButtonItem release];
    
    UIBarButtonItem *incomeBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Income" style:UIBarButtonItemStylePlain target:self action:@selector(showIncomeViewController)];
	self.navigationItem.leftBarButtonItem = incomeBarButtonItem;
	[incomeBarButtonItem release];
	
	// ***** Background Image ******
	UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.bounds;
	
	[self.view insertSubview:bodyImageView aboveSubview:self.view];
    
    UIImage *display = [UIImage imageNamed:@"display_container_2.png"];
    UIImageView *display_container = [[UIImageView alloc] initWithImage:display];
    display_container.frame = CGRectMake(20.0, -1.0, display.size.width, display.size.height);
    
    [self.view addSubview:display_container];
    [display_container release];
    
    UIImage *label_container = [UIImage imageNamed:@"label_container.png"];
    UIImageView *label_container_view = [[UIImageView alloc] initWithImage:label_container];
    label_container_view.frame = CGRectMake(0.0, 47.0, label_container.size.width + 10, label_container.size.height + 5);
    
   // [self.view insertSubview:label_container_view aboveSubview:bodyImageView];
    [label_container_view release];
    
	[bodyImageView release];
	self.view.backgroundColor = [UIColor clearColor];
	/*
	UIImage *displayImage = [UIImage imageNamed:@"body_today.png"];
	UIImageView *displayImageView = [[UIImageView alloc] initWithImage:displayImage];
	displayImageView.center = CGPointMake(160.0, 135.0);
	[bodyImageView insertSubview:displayImageView aboveSubview:bodyImageView];
	
	[displayImageView release];
     */
    
    /* ==== Current Balance === */
    UILabel *currentLabelText = [[UILabel alloc] init];
    currentLabelText.frame = CGRectMake(40.0, 18.0, 170.0, 20.0);
    currentLabelText.text = @"Balance";
    currentLabelText.backgroundColor = [UIColor clearColor];
    currentLabelText.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
    currentLabelText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    currentLabelText.shadowColor = [UIColor whiteColor];
    currentLabelText.shadowOffset = CGSizeMake(0.0, 1.0);
    
   [self.view addSubview:currentLabelText];
    [currentLabelText release];
    
    UILabel *todayLabelText = [[UILabel alloc] init];
    todayLabelText.frame = CGRectMake(40.0, 58.0, 70.0, 20.0);
    todayLabelText.text = @"Today";
    todayLabelText.backgroundColor = [UIColor clearColor];
    todayLabelText.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
    todayLabelText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    todayLabelText.shadowColor = [UIColor whiteColor];
    todayLabelText.shadowOffset = CGSizeMake(0.0, 1.0);
    
    [self.view addSubview:todayLabelText];
    [todayLabelText release];
    
    UILabel *weekLabelText = [[UILabel alloc] init];
    weekLabelText.frame = CGRectMake(40.0, 99.0, 110.0, 20.0);
    weekLabelText.text = @"This Week";
    weekLabelText.backgroundColor = [UIColor clearColor];
    weekLabelText.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
    //weekLabelText.textColor = [UIColor colorWithRed:138.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1.0];
    weekLabelText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    weekLabelText.shadowColor = [UIColor whiteColor];
    weekLabelText.shadowOffset = CGSizeMake(0.0, 1.0);
    
    [self.view addSubview:weekLabelText];
    [weekLabelText release];
    
    CGRect balanceFrame = CGRectMake(160.0, 3.0, 150.0, 50.0);
	UILabel *balanceLabel  = [[UILabel alloc] init];
	balanceLabel.frame = balanceFrame;
	balanceLabel.backgroundColor = [UIColor clearColor];
    balanceLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0];
	balanceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    balanceLabel.shadowColor = [UIColor whiteColor];
    balanceLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    balanceLabel.text = @"Rp. 3.000.000";
    
    [self.view addSubview:balanceLabel];
    [balanceLabel release];
    
    CGRect weekFrame = CGRectMake(160.0, 84.0, 150.0, 50.0);
	UILabel *weekLabel  = [[UILabel alloc] init];
	weekLabel.frame = weekFrame;
	weekLabel.backgroundColor = [UIColor clearColor];
    weekLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0];
	weekLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    weekLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    weekLabel.shadowColor = [UIColor whiteColor];
    weekLabel.text = @"Rp. 150.000";
    
    [self.view addSubview:weekLabel];
    [weekLabel release];
	
	
	// ****** Expense Button ***** 
    // http://stackoverflow.com/questions/7628004/how-does-uiedgeinsetsmake-works
	
	UIButton *expenseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	expenseButton.frame = CGRectMake(CGRectGetMinX(self.view.frame) + 25.0, 250.0, 273.0, 43.0);
	[expenseButton setTitle:@"+ Add Expense" forState:UIControlStateNormal];
    expenseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    // expenseButton.backgroundColor = [UIColor clearColor];
    [expenseButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
    [expenseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    expenseButton.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    expenseButton.titleLabel.shadowColor = [UIColor whiteColor];
	//[self.view addSubview:expenseButton];
    UIImage *expenseImage = [UIImage imageNamed:@"xb_normal.png"];
    //UIImage *expenseImagePressed = [UIImage imageNamed:@"add_expense_button_highlighted_5.png"];
    //UIImage *strechableButtonImageExpense = [expenseImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 10.0, 0.0, 35.0)];
    //UIImage *strechableButtonImageExpensePressed = [expenseImagePressed resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 10.0, 20.0, 10.0)];
    //expenseButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [expenseButton setBackgroundImage:expenseImage forState:UIControlStateNormal];
    //[expenseButton setBackgroundImage:expenseImagePressed forState:UIControlStateHighlighted];
    //[expenseButton setBackgroundImage:strechableButtonImageExpense forState:UIControlStateHighlighted];
	[expenseButton addTarget:self action:@selector(addExpense) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:expenseButton];
	
	UILabel *expenseLabel = self.todayExpenseLabel;
	
	 [self.view addSubview:expenseLabel];
    
    /*
    UIImage *dashboardLine = [UIImage imageNamed:@"dashboard_line.png"];
    UIImageView *dashboardLineView = [[UIImageView alloc] initWithImage:dashboardLine];
    dashboardLineView.frame = CGRectMake(9.0, 130.0, dashboardLine.size.width, dashboardLine.size.height);
    
    [self.view addSubview:dashboardLineView];
    */
    // =========== Testing ========
    NSInteger data = [[self.fetchedResultsController sections] count];
    
    NSLog(@"total sections -- %d --", data);
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    NSLog(@"-- total data %d -- ", [sectionInfo numberOfObjects]);
    // ==============================
    
    [self updateTodayLabel];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
#pragma mark -
#pragma mark ViewTransition

- (void)showSettingViewController {
	
	SettingViewController *viewController = [[SettingViewController alloc] init];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	aNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self.navigationController presentModalViewController:aNavigationController animated:YES];
	
	[aNavigationController release];
	[viewController release];
	
}

- (void)showIncomeViewController {
	
	IncomeViewController *viewController = [[IncomeViewController alloc] init];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	aNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self.navigationController presentModalViewController:aNavigationController animated:YES];
	
	[aNavigationController release];
	[viewController release];
	
}

#pragma mark -
#pragma CoreData Connection

// It's actually just a test to retrive data from persistent store. ^_^

- (void)updateTodayLabel {
    
    NSError *error = nil;
    NSArray *results = [NSArray array];
    
    // define which entity we'll deal with
    NSEntityDescription *expense = [NSEntityDescription entityForName:@"Expense" inManagedObjectContext:self.managedObjectContext];
    // initialize fetch request *get ready to do some request*
    NSFetchRequest *fetch = [[[NSFetchRequest alloc] init] autorelease];
    // pass the entity about to be fetched.
    [fetch setEntity:expense];
    [fetch setFetchBatchSize:1];
    // implements aggregate function :sum
    NSExpression *expression = [NSExpression expressionForFunction:@"sum:" arguments:[NSArray arrayWithObject:[NSExpression expressionForKeyPath:@"expenseAmount"]]];
    
    NSExpressionDescription *expressionDesription = [[[NSExpressionDescription alloc] init] autorelease];
    [expressionDesription setName:@"totalToday"];
    [expressionDesription setExpression:expression];
    [expressionDesription setExpressionResultType: NSDecimalAttributeType];
    
    NSArray *properties = [NSArray arrayWithObject:expressionDesription];
    [fetch setPropertiesToFetch:properties];
    [fetch setResultType:NSDictionaryResultType];
    
    // start request the data
    results = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    //NSDictionary *results = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    NSLog(@"total data retrived -- %d -- ", results.count);
    NSLog(@"data retrived: %@", results);
    
    //
  //  Expense *expenseObject = [results lastObject];
  //  NSLog(@"Expense: %@ -- ", expenseObject.expenseAmount);
    //todayExpenseLabel.text = [[[results objectAtIndex:0] objectForKey:@"totalToday"] description];
    
    NSString *resultString = [NSString string];
    // getting data from NSDictionary type of result
    //  data retrived: (
    //      {
    //      totalToday = 3555;
    //      }
    //  )
    resultString = [[[results objectAtIndex:0] objectForKey:@"totalToday"] description];
    NSString *stringAppend = [NSString string];
    // blink animation to show updated expenses
    if (resultString) {  
        [UIView animateWithDuration: 0.4 animations: ^{
        
            todayExpenseLabel.alpha = 1.0;
            todayExpenseLabel.alpha = 0.2;
            todayExpenseLabel.text = [stringAppend stringByAppendingFormat:@"Rp. %@", resultString];
            todayExpenseLabel.alpha = 1.0; 
        
        } completion: ^(BOOL finished){
    
       
       // todayExpenseLabel.backgroundColor = [UIColor clearColor];

    
        }];
    }
    else 
    {
        todayExpenseLabel.text = @"No data";
    }
        
     
}


- (void)addExpense {
    
	AddNewExpenseViewController *viewController = [[AddNewExpenseViewController alloc] init];
    // listen for delegate
    viewController.delegate = self;
    // create new Expense object
    Expense *newExpense = [NSEntityDescription insertNewObjectForEntityForName: @"Expense" inManagedObjectContext: self.managedObjectContext];
    // pass Expense instance to it
    viewController.expense = newExpense;
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController: viewController];
	[self.navigationController presentModalViewController: aNavigationController animated: YES];
	
	[aNavigationController release];
	[viewController release];
	
}

/*
- (void)updateExpenseTransaction {
	
	NSLog(@"Expense Updated");
	NSManagedObject *manageObject = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathWithIndex:2]];
	self.todayExpenseLabel.text = [[manageObject valueForKey:@"expense"] description];
	[self.todayExpenseLabel setNeedsDisplay];
	
}
*/

#pragma mark -
#pragma mark AddNewExpenseDelegate

- (void)AddNewExpenseViewController:(AddNewExpenseViewController *)viewController didSaveExpense:(Expense *)expense {
	
	NSLog(@"DidSaveExpense");
    if (expense) {
        
        // fetch new data
       [self performSelector:@selector(updateTodayLabel) withObject:nil afterDelay:1.0];

    }
	[self dismissModalViewControllerAnimated:YES];
}
// ================= DUMMY FUNCTION ========================
// Implemented only for testing
- (void)addNewExpense {
    
    
    NSDecimalNumber *amount = [[NSDecimalNumber alloc] initWithInteger:8800];
    
    Expense *newExpense = [NSEntityDescription insertNewObjectForEntityForName:@"Expense" inManagedObjectContext:self.managedObjectContext];
    
    newExpense.date = [NSDate date];
    newExpense.expenseAmount = amount;
    [amount release];
    
    NSError *error = nil;
    NSLog(@"Added");
    if (![newExpense.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        NSLog(@"Error");
		abort();
    }
    else
    {
        NSLog(@"Succeded");
       [self updateTodayLabel];
       // [self performSelector:@selector(updateTodayLabel) withObject:nil afterDelay:3.0];
    }
}
// =============== DUMMY FUNCTION =============================

#pragma -
#pragma FetchResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expense" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController;
}   

#pragma mark -
#pragma mark UI Components

- (UILabel *)todayExpenseLabel {
	
	CGRect frame = CGRectMake(160.0, 42.0, 100.0, 50.0);
	todayExpenseLabel  = [[UILabel alloc] init];
	todayExpenseLabel.frame = frame;
	todayExpenseLabel.backgroundColor = [UIColor clearColor];
    todayExpenseLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0];
	todayExpenseLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    todayExpenseLabel.shadowColor = [UIColor whiteColor];
    todayExpenseLabel.shadowOffset = CGSizeMake(0.0, 1.0);
	//[todayExpenseLabel setText:@"HAHAHAHAHAHAHA"];
	//[self updateExpenseTransaction];
	
	return todayExpenseLabel;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //self.todayExpenseLabel = nil;
}



@end
