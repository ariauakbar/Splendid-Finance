//
//  PassCodeSettingViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/23/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import "PassCodeSettingViewController.h"
#import "GCPINViewController.h"



#define kPassCodeKey @"passCodeKey"


@implementation PassCodeSettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Passcode Setting";
    
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50.0;
    //self.tableView.bounces = NO;
    // self.tableView.backgroundColor = [UIColor clearColor];
    //self.view.backgroundColor = [UIColor clearColor];
    //NSLog(@"Income: %@", income.totalIncome);
    //self.currentBudget = [income.totalIncome integerValue] - [expense.totalExpense integerValue] ;
    UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.frame;
	
	[self.navigationController.view addSubview:bodyImageView];
    [self.navigationController.view sendSubviewToBack:bodyImageView];
    [bodyImageView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    NSInteger rows = 0;
    
    if (section == 0) {
        
        rows = 2;
    }
    else
    {
        rows = 1;
    }

    // Return the number of rows in the section.
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
     
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        
        if (indexPath.row % 2 == 1) {
            cell.backgroundColor = [UIColor clearColor];
        }
        
        
        
        if (indexPath.section == 0) {
            
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.shadowColor = [UIColor whiteColor];
            cell.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            if (indexPath.row == 0)
            {
                cell.textLabel.text = @"Turn Passcode Off";
            }
            else if (indexPath.row == 1)
            {
                cell.textLabel.text = @"Change Passcode";
            }
        }
        else if (indexPath.section == 1)
        {
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.shadowColor = [UIColor whiteColor];
            cell.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.textLabel.text = @"Switching Code";
        }
    }
    
    
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSUserDefaults *userDefault  = [NSUserDefaults standardUserDefaults];
    NSString *passCode = [userDefault valueForKey:kPassCodeKey];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1)
        {
            if ([userDefault valueForKey:kPassCodeKey] == nil) {
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
                    return YES;
                };
                
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:PIN];
                [PIN release];
                [self.navigationController presentModalViewController:navController animated:YES];
                [navController release];
                
            }
            else
            {
              /*  GCPINViewController *PIN = [[GCPINViewController alloc]
                                            initWithNibName:nil
                                            bundle:nil
                                            mode:GCPINViewControllerModeVerify];
                PIN.messageText = @"Enter the Old Password";
                PIN.errorText = @"The passcodes do not match";
                PIN.title = @"Set Passcode";
                
                
                PIN.verifyBlock = ^(NSString *code) {
                    NSLog(@"setting code: %@", code);
                    
                    return [code isEqualToString:passCode];
                    NSLog(@"fired");
                };
                
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:PIN];
                [PIN release];
                [self.navigationController presentModalViewController:navController animated:YES];
                [navController release];
               */
            }
        }
    }
}





@end
