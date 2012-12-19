//
//  RecordsViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplendidAppDelegate.h"


@interface RecordsViewController : UITableViewController {

    NSArray *months;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSArray *months;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
