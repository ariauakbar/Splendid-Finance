//
//  BaseViewController.m
//  CoachAndrew
//
//  Created by Mohamad Ariau Akbar on 5/24/11.
//  Copyright 2011 Techbars.com. All rights reserved.
//

#import "DashboardViewController.h"
#import "RecordsViewController.h"
#import "TransactionViewController.h"
#import "GoalViewController.h"
#import "RecurringViewController.h"
#import "BaseViewController.h"


@implementation BaseViewController


- (UIViewController *) viewControllerWithTabTitle:(NSString *)title image:(UIImage *)image withTag:(NSInteger)tag {
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIViewController *viewController = nil;
	
	switch (tag) {
		case 1:
			viewController = [[[DashboardViewController alloc] init] autorelease];
			break;
		case 2:
			viewController = [[[RecordsViewController alloc] init] autorelease];
			break;
		case 3:
			viewController = [[[TransactionViewController alloc] init] autorelease];
			break;
		case 4:
			viewController = [[[GoalViewController alloc] init] autorelease];
			break;
		case 5:
			viewController = [[[RecurringViewController alloc] init] autorelease];
			break;

		default:
			break;
	}

	//viewController.title = @"iCoachAndrew";
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	viewController.tabBarItem = [[[UITabBarItem alloc] initWithTitle:title image:image tag:0] autorelease];
	
	//return aNavigationController;
	return aNavigationController;
}

@end
