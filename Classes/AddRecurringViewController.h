//
//  AddRecurringViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 12/31/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@class Recurring;

@interface AddRecurringViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>
{
    Recurring *recurring;
    NSMutableArray *days;
@private
    UIToolbar *toolbar;
    UITextField *expenseField;
    UIDatePicker *datePickerView;
    EKEvent *eventKit;
    EKCalendar *calendar;
    EKEventStore *eventStore;
    UIPickerView *aPickerView;
    id localCurrencySymbol;
    id localGroupingSeparator;
    NSNumberFormatter *currencyFormatter;
    NSNumberFormatter *basicFormatter;
    NSCharacterSet *nonNumberSet;

}

@property (nonatomic, retain, readonly) UITextField *expenseField;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UIDatePicker *datePickerView;
@property (nonatomic, retain) EKEvent *eventKit;
@property (nonatomic, retain) EKCalendar *calendar;
@property (nonatomic, retain) EKEventStore *eventStore;
@property (nonatomic, retain) UIPickerView *aPickerView;
@property (nonatomic, retain) Recurring *recurring;
@property (nonatomic, retain) NSMutableArray *days;
@property (nonatomic, retain) id localCurrencySymbol;
@property (nonatomic, retain) id localGroupingSeparator;
@property (nonatomic, retain) NSNumberFormatter *currencyFormatter;
@property (nonatomic, retain) NSNumberFormatter *basicFormatter;
@property (nonatomic, retain) NSCharacterSet *nonNumberSet;

- (void) showCategory;
- (void) showMenu;

- (void)addNote;
- (void)addDay;

@end
