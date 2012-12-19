//
//  SplendidUtils.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 11/17/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SplendidUtils : NSObject {
    
    
    
}

// convert plain string currency to IDR currency format
+ (NSString *)currencyIDFormatWithString:(NSString *)string;
// convert NSDate to simple date format --> 10 July 1990
+ (NSString *)simpleDateFormat:(NSDate *)date;
// resize the size of image + recreate the image to lowest quality as JPEG image
+ (NSData *)resizeImageToJPEG:(UIImage *)image;

+ (NSDictionary *) saveImageToFileSystem: (UIImage *)image withName: (NSString *) name;

+ (NSString *) getImageNameForCategory:(NSString *) category;

+ (BOOL) checkCategoryForName:(NSString *)category;

@end
