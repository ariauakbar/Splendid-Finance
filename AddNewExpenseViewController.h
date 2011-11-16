//
//  AddNewExpenseViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 9/22/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Expense;

@protocol AddNewExpenseProtocol <NSObject>

- (void)AddNewExpenseViewController:(UIViewController *)viewController didSaveExpense:(Expense *)expense;

@end



@interface AddNewExpenseViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate> {

	UITextField *expenseField;
	NSNumberFormatter *numberFormatter; 
	id<AddNewExpenseProtocol> delegate;
    UIToolbar *toolbar;
    Expense *expense;
}

@property (nonatomic, retain, readonly) UITextField *expenseField;
@property (nonatomic, retain) NSNumberFormatter *numberFormatter;
@property (nonatomic, retain) id<AddNewExpenseProtocol> delegate;
@property (nonatomic, retain) Expense *expense;
@property (nonatomic, retain) UIToolbar *toolbar;

- (void)saveExpense;

@end
