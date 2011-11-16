//
//  BaseViewController.h
//  CoachAndrew
//
//  Created by Mohamad Ariau Akbar on 5/24/11.
//  Copyright 2011 Techbars.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class HomeViewController, WatchViewController, ReadViewController, TwitterViewController, SearchViewController;

@interface BaseViewController : UITabBarController {

    UITableView *tableView;
	
}
- (UIViewController *) viewControllerWithTabTitle:(NSString *)title image:(UIImage *)image withTag:(NSInteger)tag;

@end
