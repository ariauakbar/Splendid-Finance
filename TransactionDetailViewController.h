//
//  TransactionDetailViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 12/4/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "EditTransactionViewController.h"

@class Expense;

@interface TransactionDetailViewController : UITableViewController <EditTransactionProtocol>
{
    @private
    Expense *expense;
    UIImageView *pict_container;
    UIImage *food_pict;
    
}

@property (nonatomic, retain) Expense *expense;
@property (nonatomic, retain) UIImageView *pict_container;
@property (nonatomic, retain) UIImage *food_pict;

@end
