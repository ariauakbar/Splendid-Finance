//
//  AddGoalViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/2/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Goal;
@class Income;


@interface AddGoalViewController : UITableViewController <UITextFieldDelegate>
{
    UITextField *whatTextField;
    UITextField *priceTextField;
    UISlider *asideSlider;
    UILabel *asideStateLabel;
    NSInteger currentBudget;
    UITextField *activeField;
    UITextField *saveTextField;
    NSInteger portion;
    Goal *goal;
    Income *income;
    NSManagedObjectContext *managedObjectContext;
    id localCurrencySymbol;
    id localGroupingSeparator;
    NSNumberFormatter *currencyFormatter;
    NSNumberFormatter *basicFormatter;
    NSCharacterSet *nonNumberSet;

}

@property (nonatomic, retain) UITextField *whatTextField;
@property (nonatomic, retain) UITextField *priceTextField;
@property (nonatomic, retain) UISlider *asideSlider;
@property (nonatomic, retain) UILabel *asideStateLabel;
@property (nonatomic, assign) NSInteger currentBudget;
@property (nonatomic, assign) NSInteger portion;
@property (nonatomic, retain) UITextField *activeField;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Goal *goal;
@property (nonatomic, retain) Income *income;
@property (nonatomic, retain)  UITextField *saveTextField;
@property (nonatomic, retain) id localCurrencySymbol;
@property (nonatomic, retain) id localGroupingSeparator;
@property (nonatomic, retain) NSNumberFormatter *currencyFormatter;
@property (nonatomic, retain) NSNumberFormatter *basicFormatter;
@property (nonatomic, retain) NSCharacterSet *nonNumberSet;

@end
