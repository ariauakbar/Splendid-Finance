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
#import "SplendidUtils.h"
#import "GCPINViewController.h"

#define kPassCodeKey @"passCodeKey"

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
- (void)updateIncomeLabel;
- (void)updateWeekLabel;
- (NSDictionary *) getDatebyRange:(DateRangeType) dateRangeType;
- (void) performUpdateActionWithSelector:(SEL)selector withDelay:(NSTimeInterval) delay;

@end                                                                                                                                                                                                                                                                                                                                                                                                                                             


@implementation DashboardViewController

@synthesize todayExpenseLabel;
@synthesize managedObjectContext;
@synthesize fetchedResultsController;
@synthesize balanceLabel;
@synthesize globalExpense;
@synthesize weekLabel;

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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *passcode = [userDefaults valueForKey:kPassCodeKey];
    
    if(passcode != nil)
    {
        GCPINViewController *PIN = [[GCPINViewController alloc]
                                initWithNibName:nil
                                bundle:nil
                                mode:GCPINViewControllerModeVerify];
        PIN.messageText = @"Enter your passcode";
        PIN.errorText = @"Incorrect passcode";
        PIN.title = @"Enter Passcode";
        PIN.verifyBlock = ^(NSString *code) {
            NSLog(@"checking code: %@", code);
            return [code isEqualToString:passcode];
        };
        [PIN presentFromViewController:self animated:NO];
        [PIN release];
        
       
  
        
 
	}
    
    /*
     UITabBar *tabBar = self.tabBarController.tabBar;
          UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"tabBar-home.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabBar-home.png"]];
     */
    
    //self.title = @"Dashboard";
    //self.tabBarItem.image = [UIImage imageNamed:@"cal_glyph.png"];
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
    
    UIBarButtonItem *incomeBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+Income" style:UIBarButtonItemStylePlain target:self action:@selector(showIncomeViewController)];
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
    currentLabelText.textColor = [UIColor colorWithRed:138.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1.0];
    currentLabelText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    currentLabelText.shadowColor = [UIColor whiteColor];
    currentLabelText.shadowOffset = CGSizeMake(0.0, 1.0);
    
   [self.view addSubview:currentLabelText];
    [currentLabelText release];
    
    UILabel *todayLabelText = [[UILabel alloc] init];
    todayLabelText.frame = CGRectMake(40.0, 58.0, 70.0, 20.0);
    todayLabelText.text = @"Today";
    todayLabelText.backgroundColor = [UIColor clearColor];
    todayLabelText.textColor = [UIColor colorWithRed:138.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1.0];
    todayLabelText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    todayLabelText.shadowColor = [UIColor whiteColor];
    todayLabelText.shadowOffset = CGSizeMake(0.0, 1.0);
    
    [self.view addSubview:todayLabelText];
    [todayLabelText release];
    
    UILabel *weekLabelText = [[UILabel alloc] init];
    weekLabelText.frame = CGRectMake(40.0, 99.0, 110.0, 20.0);
    weekLabelText.text = @"This Week";
    weekLabelText.backgroundColor = [UIColor clearColor];
    weekLabelText.textColor = [UIColor colorWithRed:138.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1.0];
    //weekLabelText.textColor = [UIColor colorWithRed:138.0f/255.0f green:150.0f/255.0f blue:157.0f/255.0f alpha:1.0];
    weekLabelText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    weekLabelText.shadowColor = [UIColor whiteColor];
    weekLabelText.shadowOffset = CGSizeMake(0.0, 1.0);
    
    [self.view addSubview:weekLabelText];
    [weekLabelText release];
   

	
	
	// ****** Expense Button ***** 
    // http://stackoverflow.com/questions/7628004/how-does-uiedgeinsetsmake-works
	
	UIButton *expenseButton = [UIButton buttonWithType:UIButtonTypeCustom];
	expenseButton.frame = CGRectMake(CGRectGetMinX(self.view.frame) + 25.0, 250.0, 273.0, 43.0);
	[expenseButton setTitle:@"+ Add Expense" forState:UIControlStateNormal];
    expenseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    // expenseButton.backgroundColor = [UIColor clearColor];
    [expenseButton setTitleColor:[UIColor colorWithRed:100.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateNormal ];
    [expenseButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [expenseButton setTitleColor:[UIColor colorWithRed:100.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0] forState:UIControlStateHighlighted];
    [expenseButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    expenseButton.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    expenseButton.titleLabel.shadowColor = [UIColor whiteColor];
    expenseButton.titleLabel.textColor = [UIColor darkGrayColor];
	//[self.view addSubview:expenseButton]; 
    UIImage *expenseImage = [UIImage imageNamed:@"add_expense_button_8.png"];
    UIImage *expenseImagePressed = [UIImage imageNamed:@"add_expense_button_pressed_8.png"];
    //UIImage *strechableButtonImageExpense = [expenseImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 10.0, 0.0, 35.0)];
    //UIImage *strechableButtonImageExpensePressed = [expenseImagePressed resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 10.0, 20.0, 10.0)];
    //expenseButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [expenseButton setBackgroundImage:expenseImage forState:UIControlStateNormal];
    [expenseButton setBackgroundImage:expenseImagePressed forState:UIControlStateHighlighted];
    //[expenseButton setBackgroundImage:strechableButtonImageExpense forState:UIControlStateHighlighted];
	[expenseButton addTarget:self action:@selector(addExpense) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:expenseButton];
	
	UILabel *expenseLabel = self.todayExpenseLabel;
	UILabel *aBalanceLabel = self.balanceLabel;
    UILabel *aWeekLabel = self.weekLabel;
    
    [self.view addSubview:aWeekLabel];
    [self.view addSubview:aBalanceLabel];
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
    [self updateIncomeLabel];
    [self updateWeekLabel];
}


- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self performUpdateActionWithSelector:@selector(updateTodayLabel) withDelay:1.0];
    //[self updateTodayLabel];
    //[self updateIncomeLabel];
    //[self updateWeekLabel];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
   // self.navigationItem.prompt = nil;
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
	
	SettingViewController *viewController = [[SettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    viewController.managedObjectContext = self.managedObjectContext;
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	[self.navigationController presentModalViewController:aNavigationController animated:YES];
	
	[aNavigationController release];
	[viewController release];
	
}

- (void)showIncomeViewController {
	
    Income *income = [NSEntityDescription insertNewObjectForEntityForName:@"Income" inManagedObjectContext:self.managedObjectContext];
    
	IncomeViewController *viewController = [[IncomeViewController alloc] init];
    viewController.income = income;
    viewController.delegate = self;
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	[self.navigationController presentModalViewController:aNavigationController animated:YES];
	
	[aNavigationController release];
	[viewController release];
	
}

#pragma mark -
#pragma CoreData Connection

// It's actually just a test to retrive data from persistent store. ^_^
// Core data fetch abstraction. DRY = Don't repeat yourself.
- (NSString *) stringForFetchedEntity:(NSString *)entity expressionFunction:(NSString *)expFunc keyPath:(NSString *)keyPath expressionName:(NSString *)expName resultDatatype:(ResultDataType)dataType
{
    //NSLog(@"one");
    NSPredicate *predicate = nil;
    NSString *resultString = nil;
    NSError *error = nil;
    NSDictionary *dateFilter = nil;
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entity inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fecthRequest = [[[NSFetchRequest alloc] init] autorelease];
    [fecthRequest setEntity:entityDesc];
    // [fecth setBatchSizeL:1]
    //NSLog(@"two");
    NSExpression *expression = [NSExpression expressionForFunction:expFunc arguments:[NSArray arrayWithObject:[NSExpression expressionForKeyPath:keyPath]]];
    
    if (dataType == ResultDataTypeTodayExpense)
    {
        
        dateFilter = [self getDatebyRange:DateRangeTypeToday];
        predicate = [NSPredicate predicateWithFormat:@"date >= %@ && date < %@", [dateFilter objectForKey:@"fromDate"], [dateFilter objectForKey:@"toDate"]];
        NSLog(@"two-b");
    }
    else if (dataType == ResultDataTypeWeekExpense)
    {
        //dateFilter = [self getDatebyRange:DateRangeTypeOneWeek];
        
        dateFilter = [self getDatebyRange:DateRangeTypeOneWeek];
        predicate = [NSPredicate predicateWithFormat:@"date > %@", [dateFilter objectForKey:@"beginningOfWeek"]];
        
    }
    //NSLog(@"three");
    NSExpressionDescription *expressionDescription = [[[NSExpressionDescription alloc] init] autorelease];
    [expressionDescription setName:expName];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType:NSDecimalAttributeType];
    
    //NSLog(@"four");
    NSArray *properties = [NSArray arrayWithObject:expressionDescription];
    if (predicate){
        [fecthRequest setPredicate:predicate];
        NSLog(@"predicate");
    }
    [fecthRequest setPropertiesToFetch:properties];
    [fecthRequest setResultType:NSDictionaryResultType];
    NSArray *fetchedResult = [self.managedObjectContext executeFetchRequest:fecthRequest error:&error];
    
    //NSLog(@"fetchedResult: %@", fetchedResult);
    
    if (fetchedResult) {
        
        resultString = [[fetchedResult objectAtIndex:0] objectForKey:expName];
    }
    
    //NSLog(@"five");
    
    return [NSString stringWithFormat:@"%@", resultString];
}

- (NSDictionary *) getDatebyRange:(DateRangeType) dateRangeType {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *dateComponents;
    NSDictionary *dateDict = nil;
    
    
    if (dateRangeType == DateRangeTypeToday) {
        
        // compare range of day. today and tomorrow. ex: 12 jan 2012 at 00:00 to 13 jan 2012 at 23.59
        
        dateComponents = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:now];
        NSDateComponents *tommorow = [[NSDateComponents alloc] init];
        tommorow.day = 1;
        
        NSDate *fromDate = [cal dateFromComponents:dateComponents];
        NSDate *toDate = [cal dateByAddingComponents:tommorow toDate:fromDate options:0];
        [tommorow release];
        
        dateDict = [NSDictionary dictionaryWithObjectsAndKeys:fromDate, @"fromDate", toDate, @"toDate", nil];
        
    }
    else if (dateRangeType == DateRangeTypeOneWeek) 
    {
        // seek for the first day for every weekend. 
        
        NSDateComponents *weekDayComponents = [cal components:NSWeekdayCalendarUnit fromDate:now];
        NSDateComponents *componentsToSubstract = [[NSDateComponents alloc] init];
        // getting the first day of current week
        [componentsToSubstract setDay:0 - ([weekDayComponents weekday] - 2)];
        
        NSDate *week = [cal dateByAddingComponents:componentsToSubstract toDate:[NSDate date] options:0];
        // WeekDay will have the same date, time, second as we trigger the method, so we should normalize the components.
        NSDateComponents *pureWeekComponents = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:week];
        NSDate *beginningOfWeek = [cal dateFromComponents:pureWeekComponents];
        
        NSDateComponents *pureTodayComponents = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
        NSDate *today = [cal dateFromComponents:pureTodayComponents];
        
        dateDict = [NSDictionary dictionaryWithObjectsAndKeys:today, @"today", beginningOfWeek, @"beginningOfWeek", nil];
        
        [componentsToSubstract release];
        
    }
    
    // return as dictionary
    return dateDict;
}

- (void) updateIncomeLabel {
 
    
    NSString *income = [self stringForFetchedEntity:@"Income" expressionFunction:@"sum:" keyPath:@"incomeAmount" expressionName:@"incomeTotal" resultDatatype:ResultDataTypeBalance];
    NSString *expense = [self stringForFetchedEntity:@"Expense" expressionFunction:@"sum:" keyPath:@"expenseAmount" expressionName:@"expenseTotal" resultDatatype:ResultDataTypeNormal];
    
    double incomeDouble = [income doubleValue];
    double expenseDouble = [expense doubleValue];
    // balance calculation
    NSInteger balance = [[NSNumber numberWithDouble:incomeDouble] integerValue] - [[NSNumber numberWithDouble:expenseDouble] integerValue];
    NSString *balanceWithIDcurrency = [SplendidUtils currencyIDFormatWithString:[NSString stringWithFormat:@"%d", balance]];
    balanceLabel.text = balanceWithIDcurrency;
}


- (void)updateTodayLabel {
  
    NSString *expenseWithIDcurrency = [SplendidUtils currencyIDFormatWithString:[self stringForFetchedEntity:@"Expense" expressionFunction:@"sum:" keyPath:@"expenseAmount" expressionName:@"totalToday" resultDatatype:ResultDataTypeTodayExpense]];
    NSString *todayExpense = expenseWithIDcurrency;
    todayExpenseLabel.text = todayExpense;
    [self updateIncomeLabel];
    [self updateWeekLabel];
     
}

- (void) updateWeekLabel {
    
    NSString *weekExpenseWithIDcurrency = [SplendidUtils currencyIDFormatWithString: [self stringForFetchedEntity:@"Expense" expressionFunction:@"sum:" keyPath:@"expenseAmount" expressionName:@"totalWeek" resultDatatype:ResultDataTypeWeekExpense]];
    NSString * weekExpense = weekExpenseWithIDcurrency;
    weekLabel.text = weekExpense;
    
}


- (void)addExpense {
    
	AddNewExpenseViewController *viewController = [[AddNewExpenseViewController alloc] init];
    // listen for delegate
    viewController.delegate = self;
    // create new Expense object
    Expense *newExpense = [NSEntityDescription insertNewObjectForEntityForName: @"Expense" inManagedObjectContext: self.managedObjectContext];
    // pass Expense instance to it
    viewController.expense = newExpense;
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
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
       //[self performSelector:@selector(updateTodayLabel) withObject:nil afterDelay:1.0];
        [self performUpdateActionWithSelector:@selector(updateTodayLabel) withDelay:1.0];

    }
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark IncomeViewControllerDelegate

- (void) incomeViewController:(UIViewController *)viewController didSaveIncome:(Income *)income {
    
    NSLog(@"DidSaveIncome");
    if (income) {
        
        //[self performSelector:@selector(updateIncomeLabel) withObject:nil afterDelay:1.0];
        SEL selector = @selector(updateIncomeLabel);
        [self performUpdateActionWithSelector:selector withDelay:1.0];
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
}

// updatehelper;
- (void) performUpdateActionWithSelector:(SEL)selector withDelay:(NSTimeInterval) delay {
    
    [self performSelector:selector withObject:nil afterDelay:delay];
}

// ================= DUMMY FUNCTION ========================
// =         Implemented only for testing                  =
// ================= DUMMY FUNCTION ========================

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
	
	CGRect frame = CGRectMake(160.0, 42.0, 139.0, 50.0);
	todayExpenseLabel  = [[UILabel alloc] init];
	todayExpenseLabel.frame = frame;
	todayExpenseLabel.backgroundColor = [UIColor clearColor];
    todayExpenseLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0];
	todayExpenseLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    todayExpenseLabel.shadowColor = [UIColor whiteColor];
    todayExpenseLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    todayExpenseLabel.adjustsFontSizeToFitWidth = YES;
	//[todayExpenseLabel setText:@"HAHAHAHAHAHAHA"];
	//[self updateExpenseTransaction];
	
	return todayExpenseLabel;
}

- (UILabel *)balanceLabel {
    
    CGRect balanceFrame = CGRectMake(160.0, 3.0, 139.0, 50.0);
	balanceLabel  = [[UILabel alloc] init];
	balanceLabel.frame = balanceFrame;
	balanceLabel.backgroundColor = [UIColor clearColor];
    balanceLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0];
	balanceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    balanceLabel.shadowColor = [UIColor whiteColor];
    balanceLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    balanceLabel.adjustsFontSizeToFitWidth = YES;
    //balanceLabel.text = @"Rp3.000.000";
    
    return balanceLabel;
    
}

- (UILabel *) weekLabel {
    
    CGRect weekFrame = CGRectMake(160.0, 84.0, 139.0, 50.0);
	weekLabel  = [[UILabel alloc] init];
	weekLabel.frame = weekFrame;
	weekLabel.backgroundColor = [UIColor clearColor];
    weekLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:101.0f/255.0f blue:101.0f/255.0f alpha:1.0];
	weekLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    weekLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    weekLabel.shadowColor = [UIColor whiteColor];
    weekLabel.adjustsFontSizeToFitWidth = YES;
    
    
    return weekLabel;
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
