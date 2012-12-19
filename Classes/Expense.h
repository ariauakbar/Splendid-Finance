//
//  Expense.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/4/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Expense : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDecimalNumber * expenseAmount;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSManagedObject *category;
@property (nonatomic, retain) NSManagedObject *image;
@property (nonatomic, retain) NSManagedObject *location;
@property (nonatomic, retain) NSString *totalExpense;

@end
