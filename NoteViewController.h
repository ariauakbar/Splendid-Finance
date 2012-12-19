//
//  NoteViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 11/28/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Expense;
@class Recurring;

@interface NoteViewController : UIViewController <UITextViewDelegate> {
    
    UITextView *textView;
    Expense *expense;
    Recurring *recurring;
}

@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) Expense *expense;
@property (nonatomic, retain) Recurring *recurring;

@end
