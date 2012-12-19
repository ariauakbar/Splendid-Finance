//
//  ExpenseLocationHelper.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/5/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import "ExpenseLocationHelper.h"
#import "UIAlertView+Helper.h"

#define kClientId @"F3QYF5TSJF4UD4X4UFXDXJZ4B2JGAE3MVCTQGRJPR3X5RIRX"
#define kClientSecret @"4UKN2SHCEKNFUOB51DU3WB3REZENFNYYLSKGNQZDD3LDQBXT"
#define kBaseURL @"https://api.foursquare.com/v2/venues/search?"

@implementation ExpenseLocationHelper

@synthesize delegate;

static ExpenseLocationHelper *sharedInstance = nil;
static NSString *client_id = kClientId;
static NSString *client_secret = kClientSecret;
static NSString *base_url = kBaseURL;

+ (ExpenseLocationHelper *) sharedInstance {
  
    @synchronized(self) {
        if (!sharedInstance) {
        
            sharedInstance = [[self alloc] init];
            
        }
    }
    
    return sharedInstance;
    
}

- (id) init {
    
    self = [super init];
    
    return self;
}


- (void) getNearbyLocationsFromCurrentLocation:(CLLocation *) currentLocation {
    
    double latitude = currentLocation.coordinate.latitude;
    double longitude = currentLocation.coordinate.longitude;
    NSString *searchTerm = nil;
    
    [self findNearbyLocationsLatitude:latitude longitude:longitude limit:10 searchTerm:searchTerm];
    
}

- (void) findNearbyLocationsLatitude:(double) latitude longitude:(double)longitude limit: (NSInteger) limit searchTerm: (NSString *) searchterm {

    // you should specify global variable (inside method) which will be used inside a block to __block data type;
    __block NSArray* venues = nil;
    
    NSMutableString *venuesURL = [[NSMutableString alloc] initWithFormat:@"%@", kBaseURL];
    [venuesURL appendFormat:@"ll=%f,%f", latitude, longitude];
    [venuesURL appendFormat:@"&client_id=%@&client_secret=%@", client_id, client_secret];
    [venuesURL appendFormat:@"&limit=%d", limit];
    [venuesURL appendFormat:@"&radius=%d", 50];
    [venuesURL appendFormat:@"&llAcc=%d", 100];
    [venuesURL appendFormat:@"&intent=%@", @"checkin"];
    if (searchterm != nil) [venuesURL appendFormat:@"&%@", searchterm];
    
    // starting request
    NSLog(@"url: %@", venuesURL);
    NSURL *url = [NSURL URLWithString:venuesURL];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataDontLoad timeoutInterval:20];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // execute request
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        
        NSHTTPURLResponse *httpResponse;
        NSError *error = nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&httpResponse error:&error];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
        
            if (responseData != nil && httpResponse != NULL && [httpResponse statusCode] >= 200 && [httpResponse statusCode] < 300) 
            {
                NSError *error_ = nil;
                NSString *bodyText = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                #if DEBUG
                NSLog(@"bodyText: %@", bodyText);
                #endif
                // get returned data and convert it to JSON data object
                id parseData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error_];
                #if DEBUG
                NSLog(@"parseData: %@", parseData);
                #endif  
                [bodyText release];
                
                if (parseData != nil) 
                {
                    
                    //  response =>
                    //      groups =>
                    //          items =>
                    //              categories =>
                    //                        categories data =>  
                    //              other element =>
                    //              other element =>
                    //              other element =>
                    
                    NSArray *groups = [[(NSDictionary *) parseData objectForKey:@"response"] objectForKey:@"groups"];
                    #if DEBUG
                    NSLog(@"groups: %@", groups);
                    #endif
                    if (groups != nil && [groups count] > 0) 
                    {
                        NSDictionary *firstGroups = [groups objectAtIndex:0];
                        venues = [firstGroups objectForKey:@"items"];
                        NSLog(@"WillFireDelegate");
                        [self.delegate didFinishFindNearbyLocation:venues];
                            //self.delegate = nil;
                  
                        
                    }
                    else 
                    {
                        NSLog(@"no groups");
                    }
                }
                else 
                {
                    
                    NSLog(@"no data returned");
                }
            }
            else 
            {
                NSLog(@"failed to get data");
                UIAlertViewQuick(@"Failed", @"Failed to get location data", @"OK");
            }

        }); // end of GCD main queue
    
    }); // end of GCD other queue
    
    [venuesURL release];

 
}


- (void) dealloc {
    
    [super dealloc];
    [delegate release];
    
}

@end
