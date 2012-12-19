//
//  Income.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/17/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Income : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDecimalNumber * incomeAmount;
@property (nonatomic, retain) NSManagedObject *user;
@property (nonatomic, retain) NSManagedObject *category;
@property (nonatomic, retain) NSString *totalIncome;

@end
