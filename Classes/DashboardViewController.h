//
//  DashboardViewController.h
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewExpenseViewController.h"
#import "SplendidAppDelegate.h"
#import "IncomeViewController.h"

@class Expense;
@class Income;

typedef enum {
    
    ResultDataTypeBalance,
    ResultDataTypeTodayExpense,
    ResultDataTypeWeekExpense,
    ResultDataTypeNormal
    
} ResultDataType;

typedef enum {

    DateRangeTypeToday,
    DateRangeTypeOneWeek

} DateRangeType;

@interface DashboardViewController : UIViewController <AddNewExpenseProtocol, NSFetchedResultsControllerDelegate,IncomeViewControllerDelegate> {
    UILabel *balanceLabel;
	UILabel *todayExpenseLabel;
    UILabel *weekLabel;
@private
    NSNumber *globalExpense;
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fecthedResultsController;
    
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) UILabel *todayExpenseLabel;
@property (nonatomic, retain) UILabel *balanceLabel;
@property (nonatomic, retain) UILabel *weekLabel;
@property (nonatomic, retain) NSNumber *globalExpense;
// @entity = entity to be fetched 
// @expFunc = function to be used
// @keyPath = entity's attribute to be fetched
// @expName = name tag for result (choose whatever you want)
// @dataType = type of data to returned
- (NSString *) stringForFetchedEntity:(NSString *)entity expressionFunction:(NSString *)expFunc keyPath:(NSString *)keyPath expressionName:(NSString *)expName resultDatatype:(ResultDataType)dataType;
@end
