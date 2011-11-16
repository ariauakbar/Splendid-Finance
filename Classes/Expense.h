//
//  Expense.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 10/27/11.
//  Copyright (c) 2011 Techbars.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Expense : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * expenseAmount;
@property (nonatomic, retain) NSDate * date;

@end
