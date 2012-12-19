//
//  RecurringEventScheduler.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/1/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    EventIntervalDaily,
    EventIntervalWeekly,
    EventIntervalMontly,
    
} EventInterval;


@interface RecurringEventScheduler : NSObject
{
    NSTimer *timer;
}

@property (nonatomic, retain) NSTimer *timer;

- (NSTimeInterval) eventIntervalFormat:(EventInterval) eventInterval;

@end
