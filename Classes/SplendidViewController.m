//
//  SplendidViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import "SplendidViewController.h"

@implementation SplendidViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	/*
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.viewControllers = [NSArray arrayWithObjects:
							[self viewControllerWithTabTitle:@"Dashboard" image:[UIImage imageNamed:@"home1.png"] withTag:1],
							[self viewControllerWithTabTitle:@"Records" image:[UIImage imageNamed:@"play2.png"] withTag:2],
							[self viewControllerWithTabTitle:@"Transaction" image:[UIImage imageNamed:@"read1.png"]withTag:3],
							[self viewControllerWithTabTitle:@"Goal" image:[UIImage imageNamed:@"twitter.png"] withTag:4],
							[self viewControllerWithTabTitle:@"Recurring" image:[UIImage imageNamed:@"search1.png"] withTag:5], nil];
     */
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
