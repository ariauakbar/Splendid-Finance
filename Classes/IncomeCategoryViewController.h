//
//  IncomeCategoryViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/17/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Income;
@interface IncomeCategoryViewController : UITableViewController
{
    
    Income *income;
    NSArray *incomeCategories;
}

@property (nonatomic, retain) Income *income;
@property (nonatomic, retain) NSArray *incomeCategories;

@end
