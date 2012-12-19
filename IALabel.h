//
//  IALabel.h
//  CoachAndrew
//
//  Created by Mohamad Ariau Akbar on 10/2/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IALabel : UILabel {

	BOOL *centered;
}

@property (nonatomic, setter = setCentered:) BOOL *centered;

// return Content Not Available String
- (NSString *)notAvailableTitle; 
// replace current text with animation from top to the bottom. Only implemented on NavBar
- (void)replaceCurrentTextWithAnimationTo:(NSString *)desiredText; 

@end
