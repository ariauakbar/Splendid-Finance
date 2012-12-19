//
//  Income.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/17/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import "Income.h"


@implementation Income

@dynamic date;
@dynamic incomeAmount;
@dynamic user;
@dynamic category;
@synthesize totalIncome;

- (NSString *) totalIncome {
    
    
    NSError *error = nil;
    NSArray *results = [NSArray array];
    NSString *resultString = nil;
    
    // define which entity we'll deal with
    NSEntityDescription *expense = [NSEntityDescription entityForName:@"Income" inManagedObjectContext:self.managedObjectContext];
    // initialize fetch request *get ready to do some request*
    NSFetchRequest *fetch = [[[NSFetchRequest alloc] init] autorelease];
    // pass the entity about to be fetched.
    [fetch setEntity:expense];
    [fetch setFetchBatchSize:1];
    
    // implements aggregate function :sum
    NSExpression *expression = [NSExpression expressionForFunction:@"sum:" arguments:[NSArray arrayWithObject:[NSExpression expressionForKeyPath:@"incomeAmount"]]];
    
    
    NSExpressionDescription *expressionDescription = [[[NSExpressionDescription alloc] init] autorelease];
    [expressionDescription setName:@"totalIncome"];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType: NSDecimalAttributeType];
    
    NSArray *properties = [NSArray arrayWithObject:expressionDescription];
    [fetch setPropertiesToFetch:properties];
    [fetch setResultType:NSDictionaryResultType];
    
    // start request the data
    results = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    
    if (results) {
        
        resultString = [[results objectAtIndex:0] objectForKey:@"totalIncome"];
    }

    return resultString;
}

@end
