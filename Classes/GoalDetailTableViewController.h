//
//  GoalDetailTableViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/23/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Goal;

@interface GoalDetailTableViewController : UITableViewController
{
    
    Goal *goal;
    NSInteger monthsLeft;
}

@property (nonatomic, retain) Goal *goal;
@property (nonatomic, assign) NSInteger monthsLeft;

@end
