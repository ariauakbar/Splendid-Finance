//
//  RecurringViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplendidAppDelegate.h"


@interface RecurringViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

    NSArray *recurrings;
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    UILabel *noRecurrLabel;
    
}

@property (nonatomic, retain) NSArray *recurrings;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) UILabel *noRecurrLabel;

@end
