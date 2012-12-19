//
//  ExpenseCategoryViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 12/15/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Expense;

@interface ExpenseCategoryViewController : UITableViewController
{
    Expense *expense;
    NSArray *expenseCategories;
    
}

@property (nonatomic, retain) Expense *expense;
@property (nonatomic, retain) NSArray *expenseCategories;

@end
