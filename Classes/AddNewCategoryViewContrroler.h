//
//  AddNewCategoryViewContrroler.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/25/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewCategoryViewContrroler : UITableViewController <UITextFieldDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    UITextField *catTextField;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UITextField *catTextField;

@end
