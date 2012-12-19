//
//  LocationViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 12/22/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ExpenseLocationHelper.h"
#import "IALabel.h"

@class Expense;

@interface LocationViewController : UITableViewController <CLLocationManagerDelegate, ExpenseLocationHelperDelegate>
{
    
    Expense *expense;
    
    @private
    UISearchBar *searchBar;
    UISearchDisplayController *searchController;
    NSArray *locations;
    CLLocationManager *locationManager;
    CLLocation *currentLocation_;
    UIActivityIndicatorView *spinner;
    IALabel *titleLabel;
    ExpenseLocationHelper *locHelper;
}

@property (nonatomic, retain) Expense *expense;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UISearchDisplayController *searchController;
@property (nonatomic, retain) NSArray *locations;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *currentLocation_;
@property (nonatomic, retain) IALabel *titleLabel;
@property (nonatomic, retain) ExpenseLocationHelper *locHelper;

@end
