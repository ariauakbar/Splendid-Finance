//
//  RecurringEventScheduler.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/1/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import "RecurringEventScheduler.h"
#import "Expense.h"

@interface RecurringEventScheduler (PrivateMethod)
- (void) executeRecurringEvent;
@end

@implementation RecurringEventScheduler

@synthesize timer;

- (id) init {
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void) dealloc {
    
    [super dealloc];
    
    [timer release];
}

- (void) createRecurringEventWithDate:(NSDate *)date eventInterval:(EventInterval)eventInterval{
    
        timer = [[NSTimer alloc] initWithFireDate:date interval:[self eventIntervalFormat:eventInterval] target:self selector:@selector(executeRecurringEvent) userInfo:nil repeats:YES];
}

- (NSTimeInterval) eventIntervalFormat:(EventInterval) eventInterval{
    
    switch (eventInterval) {
        case EventIntervalDaily:
            return NSDayCalendarUnit;
            break;
        case EventIntervalWeekly:
            return NSWeekCalendarUnit;
            break;
        case EventIntervalMontly:
            return NSMonthCalendarUnit;
            break;
    }
}

- (void) executeRecurringEvent {
    
    /*
        
     recurring = [recurrings indexofObject:self.timer]
     
    */
}

@end
