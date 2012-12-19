//
//  IncomeViewController.h
//  Splendid
//
//  Created by Nidia Badzlin Adlina on 8/6/11.
//  Copyright 2011 Bina Nusantara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Income;

@protocol IncomeViewControllerDelegate <NSObject>
- (void) incomeViewController:(UIViewController *)viewController didSaveIncome:(Income *)income;
@end

@interface IncomeViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate> {
    
    UITextField *incomeField;
    NSNumberFormatter *numberFormatter;
    UIToolbar *toolbar;
    Income *income;
    id <IncomeViewControllerDelegate> delegate;
    id localCurrencySymbol;
    id localGroupingSeparator;
    NSNumberFormatter *currencyFormatter;
    NSNumberFormatter *basicFormatter;
    NSCharacterSet *nonNumberSet;
    
}
@property (nonatomic, retain, readonly) UITextField *incomeField;
@property (nonatomic, retain) NSNumberFormatter *numberFormatter;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) Income *income;
@property (nonatomic, retain) id <IncomeViewControllerDelegate> delegate;
@property (nonatomic, retain) id localCurrencySymbol;
@property (nonatomic, retain) id localGroupingSeparator;
@property (nonatomic, retain) NSNumberFormatter *currencyFormatter;
@property (nonatomic, retain) NSNumberFormatter *basicFormatter;
@property (nonatomic, retain) NSCharacterSet *nonNumberSet;

- (void)saveIncome;

@end
