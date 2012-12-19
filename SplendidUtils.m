//
//  SplendidUtils.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 11/17/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import "SplendidUtils.h"

#define kIndonesiaLocale @"id_ID"
#define kFood @"Food"
#define kTrans @"Transportation"
#define kCloAcc @"Clothing & Accessories"
#define kHealMed @"Health & Medical"
#define kRecre @"Recreation"
#define kTaxes @"Taxes"
#define kOthers @"Others"
#define kHouseHold @"Housing & Household"
#define kSalary @"Salary"
#define kBonus @"Bonus"

@implementation SplendidUtils

+ (NSString *)currencyIDFormatWithString:(NSString *)string {
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:kIndonesiaLocale];
    
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:locale];
    [locale release];
    
    double stringDouble = [string doubleValue];
    NSString *formattedString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:stringDouble]];
    
    return [NSString stringWithFormat:@"%@", formattedString];
}

+ (NSString *)simpleDateFormat:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMM yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    
    return [NSString stringWithFormat:@"%@", formattedDate];
}

+ (NSData *)resizeImageToJPEG:(UIImage *)image {
    
    return UIImageJPEGRepresentation(image, 0.2);
}

+ (NSDictionary *) saveImageToFileSystem:(UIImage *)image withName:(NSString *)name {
    
    NSData *imageData = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fullPath;
    BOOL result;
    
    if (image && name) {
        
            imageData = UIImageJPEGRepresentation(image, 0.5);
            fullPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpeg", name]];
            
            if(![fm createFileAtPath:fullPath contents:imageData attributes:nil])
            {
                result = NO;
               #if TEST
                NSLog(@"Failed save data to file");
               #endif
            }
            else
            {
                result = YES;
                //#if DEBUG
                NSLog(@"Success save data to file");
               // #endif
            }
    }
    
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:fullPath, @"path", [NSNumber numberWithBool:result], @"result", nil];
    
    return info;
}

+ (NSString *) getImageNameForCategory:(NSString *)category {
    
    //NSString *imageName = nil;
    
    if ([category isEqualToString:kFood]) {
        
        return @"plate.png";
    }
    else if ([category isEqualToString:kTrans])
    {
        return @"trans_cat_4.png";
    }
    else if ([category isEqualToString:kRecre])
    {
     
        return @"recre_cat.png";    
    }
    else if ([category isEqualToString:kHealMed])
    {
        return @"medi_cat_1.png";
    }
    else if ([category isEqualToString:kCloAcc])
    {
        return @"cloth_cat_1.png";
    }
    else if ([category isEqualToString:kHouseHold])
    {
        return @"home_cat_3.png";
    }
    else if ([category isEqualToString:kOthers])
    {
        // icon needed
        return @"others_cat.png";
    }
    else if ([category isEqualToString:kTaxes])
    {
        return @"tax_cat.png";
    }
    else if ([category isEqualToString:kSalary])
    {
        return @"salary_cat.png";
    }
    else if ([category isEqualToString:kBonus])
    {
        return @"bonus_cat.png";
    }
    else {
        
        return @"others_cat.png";
    }

}

+ (BOOL) checkCategoryForName:(NSString *)category {
    
    //NSString *imageName = nil;
    
    if ([category isEqualToString:kFood]) {
        
        return NO;
    }
    else if ([category isEqualToString:kTrans])
    {
        return NO;
    }
    else if ([category isEqualToString:kRecre])
    {
        
        return NO;    
    }
    else if ([category isEqualToString:kHealMed])
    {
        return NO;
    }
    else if ([category isEqualToString:kCloAcc])
    {
        return NO;
    }
    else if ([category isEqualToString:kHouseHold])
    {
        return NO;
    }
    else if ([category isEqualToString:kOthers])
    {
        // icon needed
        return NO;
    }
    else if ([category isEqualToString:kTaxes])
    {
        return NO;
    }
    else if ([category isEqualToString:kSalary])
    {
        return NO;
    }
    else if ([category isEqualToString:kBonus])
    {
        return NO;
    }
    else {
        NSLog(@"YES");
        return YES;
    }
    
}






@end
