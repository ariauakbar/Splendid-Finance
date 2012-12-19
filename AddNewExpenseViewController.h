//
//  AddNewExpenseViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 9/22/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Expense;

@protocol AddNewExpenseProtocol <NSObject>

- (void)AddNewExpenseViewController:(UIViewController *)viewController didSaveExpense:(Expense *)expense;

@end



@interface AddNewExpenseViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate> {

	UITextField *expenseField;
	NSNumberFormatter *numberFormatter; 
	id<AddNewExpenseProtocol> delegate;
    UIToolbar *toolbar;
    Expense *expense;
    NSMutableString *mutabString;
    id localCurrencySymbol;
    id localGroupingSeparator;
    NSNumberFormatter *currencyFormatter;
    NSNumberFormatter *basicFormatter;
    NSCharacterSet *nonNumberSet;
    //UIToolbar *aToolbar;
}

@property (nonatomic, retain, readonly) UITextField *expenseField;
@property (nonatomic, retain) NSNumberFormatter *numberFormatter;
@property (nonatomic, retain) id<AddNewExpenseProtocol> delegate;
@property (nonatomic, retain) Expense *expense;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) NSMutableString *mutabString;
@property (nonatomic, retain) id localCurrencySymbol;
@property (nonatomic, retain) id localGroupingSeparator;
@property (nonatomic, retain) NSNumberFormatter *currencyFormatter;
@property (nonatomic, retain) NSNumberFormatter *basicFormatter;
@property (nonatomic, retain) NSCharacterSet *nonNumberSet;

- (void)saveExpense;

@end
