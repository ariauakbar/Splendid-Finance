//
//  SettingViewController.m
//  Splendid
//
//  Created by Nidia Badzlin Adlina on 8/2/11.
//  Copyright 2011 Bina Nusantara. All rights reserved.
//

#import "SettingViewController.h"
#import "BackupViewController.h"
#import "ExportViewController.h"

@interface SettingViewController (PrivateMethod)
- (void)backToDashboard;
- (void)showExportViewController;

@end

@implementation SettingViewController

@synthesize sectionZeroRowZero;


/*
- (id)initWithStyle:(UITableViewStyle)style
{
    if(self == [super initWithStyle:UITableViewStyleGrouped])
    {
        
    }
    return self;
}
 
 */

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
    self.tableView.separatorColor = [ UIColor clearColor ];
    
    //self.tableView.backgroundColor = [UIColor clearColor];
  //  self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"body_3.png"]];
   /// self.tableView.opaque = NO;
    
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.shadowColor = [UIColor blackColor];
	titleLabel.shadowOffset = CGSizeMake(0, -1);
	[titleLabel setText:@"Setting"];
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:23];
    
    self.navigationItem.titleView = titleLabel;
	
	[titleLabel release];

    
    sectionZeroRowZero = [NSArray arrayWithObjects:@"Back up", nil];

    
    UIButton *ExportButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ExportButton.frame = CGRectMake(10, 100, 300, 45);
    [ExportButton setTitle:@"Export" forState:UIControlStateNormal];
    [ExportButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ExportButton addTarget:self action:@selector(showExportViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:ExportButton];
    [self.tableView bringSubviewToFront:ExportButton];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backToDashboard)];
	self.navigationItem.leftBarButtonItem = backBtn;
	[backBtn release];
}

#pragma mark -
#pragma mark ViewTransition

- (void)backToDashboard {
	
	[self dismissModalViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }    
    
	cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.text = @"Backup";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	UIViewController *viewController = nil;
	
	viewController = [[[BackupViewController alloc] init] autorelease];
	
	UINavigationController *NavController = [[UINavigationController alloc] initWithRootViewController:viewController];
	NavController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self.navigationController presentModalViewController:NavController animated:YES];
	
	[NavController release];
}


- (void)showExportViewController {
	
	ExportViewController *viewController = [[ExportViewController alloc] init];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	aNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self.navigationController presentModalViewController:aNavigationController animated:YES];
	
	[aNavigationController release];
	[viewController release];
	
}

- (void)showBackupViewController {
	
	BackupViewController  *viewController = [[BackupViewController  alloc] init];
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
