//
//  EditCategoryViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/25/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplendidAppDelegate.h"

@interface EditCategoryViewController : UITableViewController
{
    NSManagedObject *category;
    UITextField *catTextField;
}

@property (nonatomic, retain) NSManagedObject *category;
@property (nonatomic, retain) UITextField *catTextField;

@end
