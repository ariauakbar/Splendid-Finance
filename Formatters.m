//
//  Formatters.m
//  NegotiatorApp
//
//  Created by Michael Atwood on 12/1/11.
//  Copyright (c) 2011 Michael Atwood. All rights reserved.
//

#import "Formatters.h"
#define kIndonesiaLocale @"id_ID"

@implementation Formatters

// MARK: -
// MARK: Formatters
+(NSNumberFormatter*) currencyFormatter{
    
    NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:kIndonesiaLocale] autorelease];
    
	NSNumberFormatter* currencyFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[currencyFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[currencyFormatter setLocale:locale];

	
	return currencyFormatter;
}

+(NSNumberFormatter*) currencyFormatterWithNoFraction{
    
      NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:kIndonesiaLocale] autorelease];
    
	NSNumberFormatter* currencyFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[currencyFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[currencyFormatter setLocale:locale];
    [currencyFormatter setMaximumFractionDigits:0];
	
	return currencyFormatter;
}

+(NSNumberFormatter*) percentFormatter{
	NSNumberFormatter* percentFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[percentFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[percentFormatter setNumberStyle:NSNumberFormatterPercentStyle];
	[percentFormatter setLocale:[NSLocale currentLocale]];
	[percentFormatter setMinimumFractionDigits:2];
    
	return percentFormatter;
}

+(NSNumberFormatter*) basicFormatter{
    NSNumberFormatter* basicFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [basicFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    
    return basicFormatter;
}

@end
