//
//  EditTransactionViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/23/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Expense;

@protocol EditTransactionProtocol <NSObject>
- (void) didEditExpense;
@end

@interface EditTransactionViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate,
UIActionSheetDelegate, UIImagePickerControllerDelegate>
{
    UITextField *expenseField;
	NSNumberFormatter *numberFormatter; 
	id<EditTransactionProtocol> delegate;
    UIToolbar *toolbar;
    Expense *expense;
    NSMutableString *mutabString;
    id localCurrencySymbol;
    id localGroupingSeparator;
    NSNumberFormatter *currencyFormatter;
    NSNumberFormatter *basicFormatter;
    NSCharacterSet *nonNumberSet;
}

@property (nonatomic, retain, readonly) UITextField *expenseField;
@property (nonatomic, retain) NSNumberFormatter *numberFormatter;
@property (nonatomic, retain) id<EditTransactionProtocol> delegate;
@property (nonatomic, retain) Expense *expense;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) NSMutableString *mutabString;
@property (nonatomic, retain) id localCurrencySymbol;
@property (nonatomic, retain) id localGroupingSeparator;
@property (nonatomic, retain) NSNumberFormatter *currencyFormatter;
@property (nonatomic, retain) NSNumberFormatter *basicFormatter;
@property (nonatomic, retain) NSCharacterSet *nonNumberSet;

@end
