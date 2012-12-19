//
//  ManageCategoryViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/25/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplendidAppDelegate.h"

@interface ManageCategoryViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *fethedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
