//
//  ExpenseLocationHelper.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/5/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol ExpenseLocationHelperDelegate <NSObject>
- (void) didFinishFindNearbyLocation:(NSArray *)venues;
@end

@interface ExpenseLocationHelper : NSObject
{
    id <ExpenseLocationHelperDelegate> delegate;
   // NSURLConnection *connection;
    //NSData *responseData;
    //NSURLRequest *urlRequest;
}

@property (nonatomic, retain) id <ExpenseLocationHelperDelegate> delegate;
//@property (nonatomic, retain) NSURLRequest *urlRequest;
//@property (nonatomic, retain) NSURLConnection *connection;
//@property (nonatomic, retain) NSData *responseData;

- (void) getNearbyLocationsFromCurrentLocation:(CLLocation *) currentLocation;
- (void) findNearbyLocationsLatitude:(double)latitude longitude:(double)longitude limit:(NSInteger)limit searchTerm:(NSString *) searchterm;
+ (ExpenseLocationHelper *) sharedInstance;

@end
