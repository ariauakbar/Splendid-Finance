//
//  TransactionViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplendidAppDelegate.h"



@interface TransactionViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

    NSArray *transactions;
    NSArray *catIcon;
@private 
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
}


@property (nonatomic, retain) NSArray *transactions;
@property (nonatomic, retain) NSArray *catIcon;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)updateTransactions;

@end
