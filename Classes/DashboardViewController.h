//
//  DashboardViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewExpenseViewController.h"
#import "SplendidAppDelegate.h"

@class Expense;   

@interface DashboardViewController : UIViewController <AddNewExpenseProtocol, NSFetchedResultsControllerDelegate> {
    
	UILabel *todayExpenseLabel;
@private
    
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fecthedResultsController;
    
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) UILabel *todayExpenseLabel;
@end
