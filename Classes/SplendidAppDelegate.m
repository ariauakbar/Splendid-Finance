//
//  SplendidAppDelegate.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import "SplendidAppDelegate.h"
#import "SplendidViewController.h"
#import "DashboardViewController.h"
#import "RecordsViewController.h"
#import "TransactionViewController.h"
#import "RecurringViewController.h"
#import "GoalViewController.h"
#import "GCPINViewController.h"

#define isCategoryInserted @"categoryInserted"
#define kPassCodeKey @"passCodeKey"

@implementation SplendidAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize executed;
@synthesize tabBarController;

#pragma mark -
#pragma mark Application lifecycle

// Singleton Object
/*
+ (SplendidAppDelegate *)sharedInstance {
    
    
    static SplendidAppDelegate *instance;
    if (!instance)
        instance = [[SplendidAppDelegate alloc] init];
    return instance;
}
 */

- (void)awakeFromNib {
	
	//viewController = [[SplendidViewController alloc] init];
	//viewController.managedObjectContext = self.managedObjectContext;
 
	NSLog(@"AwakeFormNib");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
//<<<<<<< master
//=======

   // DashboardViewController *dashboard = [[[DashboardViewController alloc] init] autorelease];
    //dashboard.managedObjectContext = self.managedObjectContext;
   
    
    tabBarController = [[UITabBarController alloc] init];
  //  tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, self.tabBarController.tabBar.frame.origin.y + 10, self.tabBarController.tabBar.frame.size.width , self.tabBarController.tabBar.frame.size.height);
    //[tabBarController.tabBar setTintColor:[UIColor colorWithRed:168.0f/255.0f green:182.0f/255.0f blue:191.0f/255.0f alpha:1.0f]];
    //[tabBarController.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
    
    // setup the view
   // DashboardViewController *dashboard = [[DashboardViewController alloc] init]; 
    
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar-.png"] forBarMetrics:UIBarMetricsDefault];
                                               
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:168.0f/255.0f green:182.0f/255.0f blue:191.0f/255.0f alpha:1.0f]];
    
    DashboardViewController *vc1 = [[DashboardViewController alloc] init];
    //rootViewController.managedObjectContext = self.managedObjectContext;
     
    vc1.managedObjectContext = self.managedObjectContext;
    UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    nv1.tabBarItem.image = [UIImage imageNamed:@"dash.png"];

    
    [vc1 release];
    
   RecordsViewController *vc2 = [[RecordsViewController alloc] init];
    vc2.managedObjectContext = self.managedObjectContext;
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    vc2.title = @"Records";
    nv2.tabBarItem.image = [UIImage imageNamed:@"cal_rec.png"];
    [vc2 release];
    
    TransactionViewController *vc3 = [[TransactionViewController alloc] init];
    UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    vc3.managedObjectContext = self.managedObjectContext;
    vc3.title = @"Transactions";
    nv3.tabBarItem.image = [UIImage imageNamed:@"trans_glyph2.png"];
    [vc3 release];
    
    RecurringViewController *vc4 = [[RecurringViewController alloc] init];
    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    vc4.title = @"Recurring";
    vc4.managedObjectContext = self.managedObjectContext;
    nv4.tabBarItem.image = [UIImage imageNamed:@"recurr_2.png"];
    [vc4 release];
    
    GoalViewController *vc5 = [[GoalViewController alloc] init];
    vc5.managedObjectContext = self.managedObjectContext;
    UINavigationController *nv5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    vc5.title = @"Goals";
    nv5.tabBarItem.image = [UIImage imageNamed:@"goal_glyph3.png"];
    [vc5 release];
    
    NSMutableArray *views = [[NSMutableArray alloc] initWithCapacity:5];
    [views addObject:nv1];
    [views addObject:nv2];
    [views addObject:nv3];
    [views addObject:nv4];
    [views addObject:nv5];
    
#if DEBUG
    NSLog(@"TEST");
#endif

    tabBarController.viewControllers = views;
    
    [nv1 release];
    [nv2 release];
    [nv3 release];
    [nv4 release];
    [nv5 release];
    [views release];

    
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    // Override point for customization after application launch.
	window.backgroundColor = [UIColor grayColor];
    // Add the view controller's view to the window and display.
   // [self.window addSubview:viewController.view];
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
	
	//DashboardViewController *dashboardViewController = [[DashboardViewController alloc] init];
	//dashboardViewController.managedObjectContext = self.managedObjectContext;
    
    // check whether category already been stored or not. if not, store immidiately
   
    if (![[NSUserDefaults standardUserDefaults] valueForKey:isCategoryInserted]) {
        
        //[self addCategoryToDataStore];
        //NSLog(@" store executed");
    }
    
    //[self addCategoryToDataStore];
    
    /*
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:@"ExpenseCategory" inManagedObjectContext:self.managedObjectContext]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [fetch setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *categories = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    
    for (NSManagedObject *object in categories) {
        
        NSLog(@" -- category: %@", [[object valueForKey:@"name"] description]);
    }
     */
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    //NSLog(@"EnterForeground");
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *passcode = [userDefaults valueForKey:kPassCodeKey];
    
    if(passcode != nil)
    {
        NSLog(@"become Active");
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
        [PIN presentFromViewController:self.tabBarController animated:NO];
        [PIN release];
	}
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    

    
 
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
    
    [self saveContext];
}

- (void)saveContext {
    
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

#pragma -
#pragma CoreData Stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it will create one and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"Splendid_Model" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Splendid_Model.sqlite"];
    
    BOOL firstRun = NO;	
    if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path] isDirectory:NULL]) {
		firstRun = YES;		
	}
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    if (firstRun) {

        [self addCategoryToDataStore];
        NSLog(@" store executed");
    
    }
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)addCategoryToDataStore {
    
    // Category. Will be stored to DataStore just once.
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ExpenseCategory" inManagedObjectContext:self.managedObjectContext];
    NSManagedObject *food = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
    [food setValue:@"Food" forKey:@"name"];
    [food setValue:[NSDate date] forKey:@"date"];
    NSManagedObject *clothacc = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
    [clothacc setValue:@"Clothing & Accessories" forKey:@"name"];
    [clothacc setValue:[NSDate date] forKey:@"date"];
    NSManagedObject *trans = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
    [trans setValue:@"Transportation" forKey:@"name"];
    [trans setValue:[NSDate date] forKey:@"date"];
    NSManagedObject *recreat = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
    [recreat setValue:@"Recreation" forKey:@"name"];
    [recreat setValue:[NSDate date] forKey:@"date"];
    NSManagedObject *heamedic = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
    [heamedic setValue:@"Health & Medical" forKey:@"name"];
    [heamedic setValue:[NSDate date] forKey:@"date"];
    NSManagedObject *house = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
    [house setValue:@"Housing & Household" forKey:@"name"];
    [house setValue:[NSDate date] forKey:@"date"];
    NSManagedObject *taxes = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
    [taxes setValue:@"Taxes" forKey:@"name"];
    [taxes setValue:[NSDate date] forKey:@"date"];
    NSManagedObject *others = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
    [others setValue:@"Others" forKey:@"name"];
    [others setValue:[NSDate date] forKey:@"date"];
    
    NSEntityDescription *incomeEntity = [NSEntityDescription entityForName:@"IncomeCategory" inManagedObjectContext:self.managedObjectContext];
    NSManagedObject *salary = [NSEntityDescription insertNewObjectForEntityForName:[incomeEntity name] inManagedObjectContext:self.managedObjectContext];
    [salary setValue:@"Salary" forKey:@"name"];
    NSManagedObject *bonus = [NSEntityDescription insertNewObjectForEntityForName:[incomeEntity name] inManagedObjectContext:self.managedObjectContext];
    [bonus setValue:@"Bonus" forKey:@"name"];
    
    
    
    NSError *error = nil;
    
    if (![self.managedObjectContext save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    // set that Category list is already stored. 
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isCategoryInserted];
}


- (void)dealloc {
	

    //[viewController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}


@end
