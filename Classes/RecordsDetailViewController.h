//
//  RecordsDetailViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/17/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplendidAppDelegate.h"

@interface RecordsDetailViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSArray *transactions;
    NSFetchedResultsController *fetchedResultsController;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *transactions;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)showChartView;

@end
