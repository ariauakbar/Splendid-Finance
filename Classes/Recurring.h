//
//  Recurring.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/10/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Recurring : NSManagedObject

@property (nonatomic, retain) NSNumber * day;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDecimalNumber * recurringAmount;
@property (nonatomic, retain) NSDate * date;

@end
