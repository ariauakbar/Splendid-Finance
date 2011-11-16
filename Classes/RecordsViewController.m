//
//  RecordsViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import "RecordsViewController.h"



@implementation RecordsViewController

@synthesize  months;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50.0;
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.bounds;
	
	[self.navigationController.view addSubview:bodyImageView];
    [self.navigationController.view sendSubviewToBack:bodyImageView];
    [bodyImageView release];
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.shadowColor = [UIColor colorWithRed:186.0f/255.0f green:204.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
	titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
	[titleLabel setText:@"Records"];
	titleLabel.textColor = [UIColor colorWithRed:69.0f/255.0f green:74.0f/255.0f blue:77.0f/255.0f alpha:1.0f];
	titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.alpha = 0.5;
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
	
	self.navigationItem.titleView = titleLabel;
	
	[titleLabel release];
    
    self.months = [NSArray arrayWithObjects:@"August 2011", @"July 2011", @"June 2011", @"September 2010", @"October 2010", @"November 2010", @"October 2010", @"August 2010", @"July 2010", @"June 2010", nil];
    
	
	//self.title = @"Splendid";
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0.0f, -70.0, self.tableView.frame.size.width, 50.0f);
    headerView.backgroundColor = [UIColor clearColor];
    [self.tableView addSubview:headerView];
    
    UILabel *recordGuide = [[UILabel alloc] init];
    recordGuide.frame = CGRectMake(20.0f, 0.0, headerView.frame.size.width - 40, 40.f);
    [recordGuide setText:@"“Records will save your transactions every each month its occured.”"];
    recordGuide.textAlignment = UITextAlignmentCenter;
    recordGuide.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    recordGuide.numberOfLines = 2;
    recordGuide.backgroundColor = [UIColor clearColor];
    recordGuide.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
    recordGuide.shadowColor = [UIColor whiteColor];
    recordGuide.shadowOffset = CGSizeMake(0.0, 1.0);
    [headerView addSubview:recordGuide];
    [recordGuide release];
    
    //self.tableView.tableHeaderView.frame = CGRectMake(0.0, -100, headerView.frame.size.width, headerView.frame.size.height);
    //self.tableView.frame = CGRectMake(0.0, -100, self.view.frame.size.width, self.view.frame.size.height);
    //self.tableView.tableHeaderView = headerView;
    [headerView release];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.months.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        // Configure the cell...
        cell.textLabel.text = [self.months objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
        cell.textLabel.shadowColor = [UIColor whiteColor];
        cell.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        cell.imageView.image = [UIImage imageNamed:@"cal_3.png"];
    }
    
    UIImage *backgroundCell = [[UIImage imageNamed:@"cell_bg_5.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
   // UIImage *lbackgroundCell = [[UIImage imageNamed:@"cell_bg_5.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
    
    //cell.contentView.backgroundColor = [UIColor clearColor];
    
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [[UIImageView alloc] initWithImage:backgroundCell];
        cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cell.backgroundColor = [UIColor clearColor];
        cell.frame = cell.bounds;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.backgroundColor = [UIColor clearColor];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

