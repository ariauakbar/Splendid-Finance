//
//  GoalViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GoalViewController : UITableViewController {

    NSArray *goals;
    NSManagedObjectContext *managedObjectContext;
    UILabel *noGoalsLabel;
    BOOL firstRun;
    NSInteger monthsNeeded;

}

@property (nonatomic, retain) NSArray *goals;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UILabel *noGoalsLabel;
@property (nonatomic, getter = isFirstRun) BOOL firstRun;
@property (nonatomic, assign) NSInteger monthsNeeded;

@end
