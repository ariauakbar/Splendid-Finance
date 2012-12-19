//
//  IALabel.m
//  CoachAndrew
//
//  Created by Mohamad Ariau Akbar on 10/2/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import "IALabel.h"


@implementation IALabel

@synthesize centered;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
		
    }
    return self;
}

- (id)init {
	
	if (self = [super init]) {
		
		self.backgroundColor = [UIColor clearColor];
		self.textColor = [UIColor whiteColor];
		self.font = [UIFont fontWithName:@"Georgia" size:20.0];
		//[self setText:@"iCoachAndrew"];
		
		self.frame = CGRectMake(0, 0, 200, 44);
		self.shadowOffset = CGSizeMake(0, 1);
		self.shadowColor = [UIColor darkGrayColor];
		
		//if (centered) {
			self.textAlignment = UITextAlignmentCenter;
		//}
	}
	
	return self;
}

- (NSString *)notAvailableTitle {
	
	//self.text = @"Content not Available";
    
    return @"Content not Available";
}

- (void)replaceCurrentTextWithAnimationTo:(NSString *)desiredText {
    
    [UIView animateWithDuration:0.3
                     animations:^{
    
                         CGRect lowerFrame = self.frame;
                         // set the lower target position
                         lowerFrame.origin = CGPointMake(lowerFrame.origin.x, lowerFrame.origin.y + 14);
                         // move the frame to lower position
                         self.frame = lowerFrame;
                         // make the view transparent
                         self.alpha = 0.0;
                         
    }
    completion:^(BOOL finished)
    {
        
        CGRect upperFrame = self.frame;
        // set the frame to upper position.
        upperFrame.origin = CGPointMake(upperFrame.origin.x, upperFrame.origin.y - 50);
        // the frame will start from the top of navigationBar.;
        self.frame = upperFrame;
        // set the text.
        self.text = desiredText;
        
        // This animation will move the current frame (top) to original position.
        // Remember! every property implemented in Animation block above must be redeclared.
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect originalFrame = self.frame;
            self.alpha = 1.0; // redeclared
            originalFrame.origin = CGPointMake(originalFrame.origin.x, originalFrame.origin.y + 37);
            self.frame = originalFrame;
            
        }];

    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
