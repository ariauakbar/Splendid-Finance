//
//  SettingViewController.h
//  Splendid
//
//  Created by Nidia Badzlin Adlina on 8/2/11.
//  Copyright 2011 Bina Nusantara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SettingViewController : UITableViewController <MFMailComposeViewControllerDelegate> {
  	
    NSArray *sectionZero;
    NSArray *sectionOne;
 
    UISwitch *passcodeSwitch;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSArray *sectionZero;
@property (nonatomic, retain) NSArray *sectionOne;
@property (nonatomic, retain) UISwitch *passcodeSwitch;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
