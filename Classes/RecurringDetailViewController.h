//
//  RecurringDetailViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/24/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recurring;

@interface RecurringDetailViewController : UITableViewController
{
    Recurring *recurring;
}

@property (nonatomic, retain) Recurring *recurring;
@end
