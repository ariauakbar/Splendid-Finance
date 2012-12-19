//
//  Goal.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/18/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Goal : NSManagedObject

@property (nonatomic, retain) NSString * what;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSDecimalNumber * asideAmount;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSManagedObject *user;

@end
