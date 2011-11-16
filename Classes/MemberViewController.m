//
//  GreetingsViewController.m
//  Splendid
//
//  Created by Nidia Badzlin Adlina on 8/9/11.
//  Copyright 2011 Bina Nusantara. All rights reserved.
//

#import "MemberViewController.h"
#import "BackupHistoryTableViewController.h"
#import "UploadViewController.h"

@interface MemberViewController (PrivateMethod)
- (void)backToDashboard;
- (void)showUploadViewController;
@end

@implementation MemberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    
    UIImage *bodyImage = [UIImage imageNamed:@"body_3.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.bounds;
	
	[self.view insertSubview:bodyImageView aboveSubview:self.view];
	
	self.view.backgroundColor = [UIColor clearColor];

	[bodyImageView release];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.shadowColor = [UIColor blackColor];
	titleLabel.shadowOffset = CGSizeMake(0, -1);
	[titleLabel setText:@"Backup"];
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:23];
    
    self.navigationItem.titleView = titleLabel;
    
    UILabel *helloLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 80, 50)];
	helloLabel.textAlignment = UITextAlignmentLeft;
	helloLabel.shadowColor = [UIColor whiteColor];
    helloLabel.shadowOffset = CGSizeMake(0, -1);
	[helloLabel setText:@"Hello, "];
    helloLabel.textColor = [UIColor whiteColor];
	helloLabel.backgroundColor = [UIColor clearColor];
	helloLabel.font = [UIFont fontWithName:@"Arial" size:18];
    [self.view addSubview:helloLabel];
    [self.view bringSubviewToFront:helloLabel];
    [helloLabel release];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 20, 80, 50)];
	emailLabel.textAlignment = UITextAlignmentLeft;
	emailLabel.shadowColor = [UIColor whiteColor];
    emailLabel.shadowOffset = CGSizeMake(0, -1);
	[emailLabel setText:@"email, "];
    emailLabel.textColor = [UIColor whiteColor];
	emailLabel.backgroundColor = [UIColor clearColor];
	emailLabel.font = [UIFont fontWithName:@"Arial" size:18];
    [self.view addSubview:emailLabel];
    [self.view bringSubviewToFront:emailLabel];
    [emailLabel release];
    
    
    UIButton *backupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backupButton.frame = CGRectMake(10, 80, 300, 45);
    [backupButton setTitle:@"Backup" forState:UIControlStateNormal];
    [backupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backupButton addTarget:self action:@selector(showUploadViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backupButton];
    [self.view bringSubviewToFront:backupButton];
    
    
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backToDashboard)];
	self.navigationItem.leftBarButtonItem = backBtn;
	[backBtn release];
    
    
    BackupHistoryTableViewController *backupHistoryTVC = [[BackupHistoryTableViewController alloc] initWithStyle:UITableViewStylePlain];
	backupHistoryTVC.hidesBottomBarWhenPushed = YES;
	backupHistoryTVC.tableView.frame = CGRectMake(0, 180, 320, 300);
	backupHistoryTVC.tableView.backgroundColor = [UIColor clearColor];
	backupHistoryTVC.tableView.showsVerticalScrollIndicator = NO;
	
	[self.navigationController.view addSubview:backupHistoryTVC.tableView];
    [backupHistoryTVC release];
    
    [titleLabel release];
    
    
}

#pragma mark -
#pragma mark ViewTransition

- (void)backToDashboard {
	
	[self dismissModalViewControllerAnimated:YES];
}
- (void)showUploadViewController {
	
	UploadViewController *viewController = [[UploadViewController alloc] init];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	aNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self.navigationController presentModalViewController:aNavigationController animated:YES];
	
	[aNavigationController release];
	[viewController release];
	
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
