//
//  SplendidAppDelegate.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

//@class DashboardViewController;

@class SplendidViewController;

@interface SplendidAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SplendidViewController *viewController;
    UITabBarController *tabBarController;
    
    @private
    
    NSManagedObjectModel *managedObjectModel_;
    NSManagedObjectContext *managedObjectContext_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
  
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SplendidViewController *viewController;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end

