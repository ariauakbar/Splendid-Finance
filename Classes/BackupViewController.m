//
//  BackupViewController.m
//  Splendid
//
//  Created by Nidia Badzlin Adlina on 8/4/11.
//  Copyright 2011 Bina Nusantara. All rights reserved.
//

#import "BackupViewController.h"
#import "MemberViewController.h"

@interface BackupViewController (PrivateMethod)
- (void)backToDashboard;
- (void)showMemberViewController;
@end


@implementation BackupViewController
@synthesize sectionZeroRowZero, sectionZeroRowOne;

- (id)initWithStyle:(UITableViewStyle)style
{
    if(self == [super initWithStyle:UITableViewStyleGrouped])
    {
        
    }
    return self;
}

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor whiteColor];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"body_3.png"]];
    self.tableView.opaque = NO;
    
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.shadowColor = [UIColor blackColor];
	titleLabel.shadowOffset = CGSizeMake(0, -1);
	[titleLabel setText:@"Backup"];
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:23];
    
    self.navigationItem.titleView = titleLabel;
    
    sectionZeroRowZero = [NSArray arrayWithObjects:@"Username", nil];
    sectionZeroRowOne = [NSArray arrayWithObjects:@"Password", nil];
    
    UILabel *orLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 300, 50)];
	orLabel.textAlignment = UITextAlignmentCenter;
	orLabel.shadowColor = [UIColor blackColor];
    orLabel.shadowOffset = CGSizeMake(0, -1);
	[orLabel setText:@"Or"];
    orLabel.textColor = [UIColor whiteColor];
	orLabel.backgroundColor = [UIColor clearColor];
	orLabel.font = [UIFont fontWithName:@"American Typewriter" size:18];
    [self.tableView addSubview:orLabel];
    [self.tableView bringSubviewToFront:orLabel];
    [orLabel release];
    
    // ========== S with Capital =============
    UIButton *SignUpbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    SignUpbutton.frame = CGRectMake(10, 230, 300, 45);
    [SignUpbutton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [SignUpbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [SignUpbutton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    SignUpbutton.titleLabel.font=[UIFont fontWithName:@"American Typewriter" size:18   ];
    [self.tableView addSubview:SignUpbutton];
    [self.tableView bringSubviewToFront:SignUpbutton];
    
    /*UIImage *buttonImage = [UIImage imageNamed:@"button.png"];
    UIImage *strechableButtonImageExpense = [buttonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    [SignUpbutton setBackgroundImage:strechableButtonImageExpense forState:UIControlStateNormal];
    [SignUpbutton setBackgroundImage:strechableButtonImageExpense forState:UIControlStateHighlighted];
    [SignUpbutton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SignUpbutton];*/
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(10, 130, 300, 45);
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(showMemberViewController) forControlEvents:UIControlEventTouchUpInside];
    loginButton.titleLabel.font=[UIFont fontWithName:@"American Typewriter" size:18   ];
    [self.tableView addSubview:loginButton];
    [self.tableView bringSubviewToFront:loginButton];
    
    /*[loginButton setBackgroundImage:strechableButtonImageExpense forState:UIControlStateNormal];
    [loginButton setBackgroundImage:strechableButtonImageExpense forState:UIControlStateHighlighted];
    [loginButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];*/

	
	[titleLabel release];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backToDashboard)];
	self.navigationItem.leftBarButtonItem = backBtn;
	[backBtn release];
}

#pragma mark -
#pragma mark ViewTransition

- (void)backToDashboard {
	
	[self dismissModalViewControllerAnimated:YES];
}

- (void)showMemberViewController {
	
	MemberViewController *viewController = [[MemberViewController alloc] init];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	aNavigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self.navigationController presentModalViewController:aNavigationController animated:YES];
	
	[aNavigationController release];
	[viewController release];
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }    
	if(indexPath.section == 0)
    {
        UITextField *userName = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185,30)];
        userName.adjustsFontSizeToFitWidth=YES;
        userName.textColor=[UIColor blackColor];
        userName.font=[UIFont fontWithName:@"American Typewriter" size:18   ];
        if(indexPath.row == 1)
        {
            userName.placeholder=@"type your password";
            userName.keyboardType=UIKeyboardTypeDefault;
            userName.returnKeyType=UIReturnKeyNext;
        }
        else
        {
            userName.placeholder=@"type your username";
            userName.keyboardType=UIKeyboardTypeDefault;
            userName.returnKeyType=UIReturnKeyDone;
            userName.secureTextEntry=YES;
        }
        userName.backgroundColor=[UIColor whiteColor];
        userName.textAlignment=UITextAlignmentLeft;
        
        [userName setEnabled:YES];
        [cell addSubview:userName];
        [userName release];
    }
    cell.textLabel.text = indexPath.row % 2 ? @"Password" : @"Name";
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.textLabel.font=[UIFont fontWithName:@"American Typewriter" size:18   ];
	
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
