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
#import "PassCodeSettingViewController.h"
#import "GCPINViewController.h"
#import "ManageCategoryViewController.h"

#define kPassCodeKey @"passCodeKey"

@interface SettingViewController (PrivateMethod)
- (void) backToDashboard;
- (void) switchDidValueChanged:(id) sender;
- (void) invokeMailComposer;
- (void) displayComposerSheet;
@end

@implementation SettingViewController

@synthesize sectionZero;
@synthesize sectionOne;
@synthesize passcodeSwitch;
@synthesize managedObjectContext;



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

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    NSUserDefaults *userDefault  = [NSUserDefaults standardUserDefaults];
    NSString *passCode = [userDefault valueForKey:kPassCodeKey];
    
    if (passCode != nil) {
        
        [passcodeSwitch setOn:YES animated:YES];
    }
    else 
    {
        [passcodeSwitch setOn:NO animated:YES];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 50.0;
    UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.frame;
	
	[self.navigationController.view addSubview:bodyImageView];
    [self.navigationController.view sendSubviewToBack:bodyImageView];
    [bodyImageView release];
    
    //***Title Label***
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.shadowColor = [UIColor colorWithRed:186.0f/255.0f green:204.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
	titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
	[titleLabel setText:@"Setting"];
	titleLabel.textColor = [UIColor colorWithRed:69.0f/255.0f green:74.0f/255.0f blue:77.0f/255.0f alpha:1.0f];
	titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.alpha = 0.5;
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
	
	self.navigationItem.titleView = titleLabel;
	
	[titleLabel release];

   
     //***Table View***
    //sectionZero = [NSArray arrayWithObjects:@"Back up", @"Set Password", nil];
    sectionZero = [[NSArray alloc] initWithObjects:@"Export to Email", @"Password", nil];
	//sectionOne = [NSArray arrayWithObject:@"Export"];

    
    //***Back Button***
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backToDashboard)];
	self.navigationItem.rightBarButtonItem = backBtn;
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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
    NSInteger row;
	
	if (section == 0) {
        
        row = 2;
    }
    else {
        
        row = 1;
    }
	
    return row ;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        if (indexPath.row % 2 == 1) {
            cell.backgroundColor = [UIColor clearColor];
        }
    
        if (indexPath.section == 0) {
            
            cell.textLabel.text = [self.sectionZero objectAtIndex:indexPath.row];
            cell.textLabel.textColor  = [UIColor darkGrayColor];
            //cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0];
           // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            
            if (indexPath.row == 1) {
                
                UISwitch *aSwitch = self.passcodeSwitch;
                [cell.contentView addSubview:aSwitch];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.textAlignment = UITextAlignmentLeft;
            }
            
            
        } 
        else {
            
            cell.textLabel.text = @"Manage Categories";
            cell.textLabel.textColor  = [UIColor darkGrayColor];
            //cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
    
    }    
    
    
    // Configure the cell...
	
    

    
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            
        
        }
        else if (indexPath.row == 0)
        {
            
            // mail
            [self invokeMailComposer];
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            ManageCategoryViewController *manageCategory = [[ManageCategoryViewController alloc] init];
            manageCategory.managedObjectContext = self.managedObjectContext;
            [self.navigationController pushViewController:manageCategory animated:YES];
        
            //[manageCategory release];
            NSLog(@"selected");
        }
    }
}

- (UISwitch *) passcodeSwitch 
{
    passcodeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(210.0, 13.0, 200.0, 100.0)];
    [passcodeSwitch addTarget:self action:@selector(switchDidValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSUserDefaults *userDefault  = [NSUserDefaults standardUserDefaults];
    NSString *passCode = [userDefault valueForKey:kPassCodeKey];
    
    if (passCode != nil) {
        
        [passcodeSwitch setOn:YES animated:YES];
    }
    else 
    {
        [passcodeSwitch setOn:NO animated:YES];
    }
    
    
    return passcodeSwitch;
}

- (void) switchDidValueChanged:(UISwitch *) aSender {
    
    NSUserDefaults *userDefault  = [NSUserDefaults standardUserDefaults];
    NSString *passCode = [userDefault valueForKey:kPassCodeKey];
    BOOL ON = aSender.on;
        
    if (!ON) {
        NSLog(@"not ON");
        
        GCPINViewController *PIN = [[GCPINViewController alloc]
                                    initWithNibName:nil
                                    bundle:nil
                                    mode:GCPINViewControllerModeVerify];
        PIN.messageText = @"Enter the Old Password";
        PIN.errorText = @"The passcodes do not match";
        PIN.title = @"Set Passcode";
        
        
        PIN.verifyBlock = ^(NSString *code) {
            NSLog(@"setting code: %@", code);
            
            if ([code isEqualToString:passCode]) {
                
                [userDefault removeObjectForKey:kPassCodeKey];
                [passcodeSwitch setOn:NO animated:YES];
                return YES;
            }
            else
            {
                return NO;
            }
            
            NSLog(@"fired");
        };
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:PIN];
        [PIN release];
        [self.navigationController presentModalViewController:navController animated:YES];
        [navController release];
        
    }    
    else {
        
        if ([userDefault valueForKey:kPassCodeKey] == nil) 
        {
            GCPINViewController *PIN = [[GCPINViewController alloc]
                                        initWithNibName:nil
                                        bundle:nil
                                        mode:GCPINViewControllerModeCreate];
            PIN.messageText = @"Enter a passcode";
            PIN.errorText = @"The passcodes do not match";
            PIN.title = @"Set Passcode";
            
            PIN.verifyBlock = ^(NSString *code) {
                NSLog(@"setting code: %@", code);
                
                [userDefault setValue:code forKey:kPassCodeKey];
                [userDefault synchronize];
                 [passcodeSwitch setOn:YES animated:YES];
                return YES;
            };
            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:PIN];
            [PIN release];
            [self.navigationController presentModalViewController:navController animated:YES];
            [navController release];
        }
    }
}

- (void) invokeMailComposer {
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			//[self launchMailAppOnDevice];
		}
	}
}

- (void) displayComposerSheet {
    
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    
    [mailComposer setSubject:@"Data from January 2011"];
    NSString *emailBody = @"25-Jan-2012";
    [mailComposer setMessageBody:emailBody isHTML:NO];
    
    [self presentModalViewController:mailComposer animated:YES];
    [mailComposer release];

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	
	[self dismissModalViewControllerAnimated:YES];
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
