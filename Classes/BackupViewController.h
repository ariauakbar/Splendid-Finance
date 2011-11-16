//
//  BackupViewController.h
//  Splendid
//
//  Created by Nidia Badzlin Adlina on 8/4/11.
//  Copyright 2011 Bina Nusantara. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BackupViewController : UITableViewController {
  	
    NSArray *sectionZeroRowZero;
    NSArray *sectionZeroRowOne;

}

@property (nonatomic, retain) NSArray *sectionZeroRowZero;
@property (nonatomic, retain) NSArray *sectionZeroRowOne;


@end