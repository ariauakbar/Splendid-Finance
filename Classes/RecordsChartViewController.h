//
//  RecordsChartViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/19/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordsChartViewController : UIViewController
{
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
- (void) calculatePieChart;
- (NSInteger) totalTransaction;
- (void) cancel;
@end
