//
//  TransactionDetailViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 12/4/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import "TransactionDetailViewController.h"
#import "Expense.h"
#import <QuartzCore/QuartzCore.h>
#import "SplendidUtils.h"
#import "EditTransactionViewController.h"



@implementation TransactionDetailViewController

@synthesize expense;
@synthesize pict_container;
@synthesize food_pict;

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
    NSLog(@"didReceiveMemoryWarning");
    [food_pict release], food_pict = nil;
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"didLoad");
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50.0;
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    
    
    NSDate *expenseDate = [self.expense valueForKey:@"date"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
	//titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.shadowColor = [UIColor colorWithRed:69.0f/255.0f green:74.0f/255.0f blue:77.0f/255.0f alpha:1.0f];
	titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
	[titleLabel setText:[SplendidUtils simpleDateFormat:expenseDate]];
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.alpha = 0.5;
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
   
    self.navigationItem.titleView = titleLabel;
    [titleLabel release];
    //self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 216.0, 0.0); 
    //self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    
    UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.bounds;
	
	[self.navigationController.view addSubview:bodyImageView];
    [self.navigationController.view sendSubviewToBack:bodyImageView];
    [bodyImageView release];
    
    
   // UIImage *food_pict = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"pict_1" ofType:@"jpg"]];

    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0.0f, -50.0, self.tableView.frame.size.width, 50.0f);
    headerView.backgroundColor = [UIColor clearColor];
    [self.tableView addSubview:headerView];
    
    UILabel *categoryGuide = [[UILabel alloc] init];
    categoryGuide.frame = CGRectMake(20.0f, 0.0, headerView.frame.size.width - 40, 40.f);
    [categoryGuide setText:[self.expense.category valueForKey:@"name"]];
    NSLog(@"category: %@", [self.expense.category valueForKey:@"name"]);
    categoryGuide.textAlignment = UITextAlignmentCenter;
    categoryGuide.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22.0];
    categoryGuide.numberOfLines = 2;
    categoryGuide.backgroundColor = [UIColor clearColor];
    categoryGuide.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
    categoryGuide.shadowColor = [UIColor whiteColor];
    categoryGuide.shadowOffset = CGSizeMake(0.0, 1.0);
    [headerView addSubview:categoryGuide];
    [categoryGuide release];
    [headerView release];
    
    
    if ([self.expense.image valueForKey:@"imagePath"] != nil) {
        NSLog(@"imagePath: %@", [self.expense.image valueForKey:@"imagePath"]);
       dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{
            food_pict = [UIImage imageWithContentsOfFile:[self.expense.image valueForKey:@"imagePath"]];
           
             
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                pict_container = [[UIImageView alloc] initWithImage:food_pict];
                pict_container.frame = CGRectMake(0.0, 150.0, self.view.bounds.size.width, 300);
                
                pict_container.contentMode = UIViewContentModeScaleToFill;
                pict_container.layer.shadowColor = [UIColor blackColor].CGColor;
                pict_container.layer.shadowOffset = CGSizeMake(0.0, 2.0f);
                pict_container.layer.shadowOpacity = 0.7f;
                [self.view addSubview:pict_container];
                
            });
        });
        //[self.view sendSubviewToBack:pict_container];
        
        //[self.navigationController.view sendSubviewToBack:pict_container];
    } else {
        
        UILabel *noImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 220.0, 200.0, 44.0)];
        //noImageLabel.center = self.view.center;
        //titleLabel.textAlignment = UITextAlignmentCenter;
        noImageLabel.shadowColor = [UIColor whiteColor];
        noImageLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        [noImageLabel setText:@"This expense has no image"];
        noImageLabel.textColor = [UIColor lightGrayColor];
        noImageLabel.backgroundColor = [UIColor clearColor];
        //noImageLabel.alpha = 0.5;
        noImageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        
        [self.view addSubview:noImageLabel];
        [noImageLabel release];
        
    }

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(showEditViewController)];
    self.navigationItem.rightBarButtonItem = editButtonItem;
    [editButtonItem release];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self.pict_container release];
    self.pict_container = nil;
    [self.food_pict release];
    self.food_pict = nil;
    
}

- (void) showEditViewController {
    
    EditTransactionViewController *editVC = [[EditTransactionViewController alloc] init];
    editVC.expense = self.expense;
    editVC.delegate = self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:editVC];
    [editVC release];
    
    [self.navigationController presentModalViewController:navController animated:YES];
    [navController release];
}

- (void)AddNewExpenseViewController:(UIViewController *)viewController didSaveExpense:(Expense *)expense {
    
    NSLog(@"expense: %@", self.expense.expenseAmount.description);
    
    //[self.tableView reloadData];
    
    [self dismissModalViewControllerAnimated:YES];
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
     // self.pict_container = nil;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Reloaded");
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        UIImage *backgroundCell = [[UIImage imageNamed:@"cell_bg_5.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
        cell.backgroundColor = [UIColor clearColor];
        // if (indexPath.row % 2 == 0) {
        cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundCell] autorelease];
        cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //cell.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0];
        cell.backgroundColor = [UIColor clearColor];
        cell.frame = cell.bounds;
        self.tableView.rowHeight = 50;
    }
    
    cell.indentationWidth = 20.0;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
    cell.textLabel.shadowColor = [UIColor whiteColor];
    cell.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    
    if (indexPath.row == 0) {
        // row for expense amount
        cell.imageView.image = [UIImage imageNamed:@"money_mini_3.png"];
        cell.textLabel.text = [SplendidUtils currencyIDFormatWithString:expense.expenseAmount.description];
    }
    else if (indexPath.row == 1) {
        // row for notes
        cell.imageView.image = [UIImage imageNamed:@"notes_mini_3.png"];
        
        if ([expense valueForKey:@"notes"] != nil) {
            
            cell.textLabel.text = [expense valueForKey:@"notes"];
            
        } else {
            // if there's no notes
            cell.textLabel.text = @"none";
        }
        
        self.tableView.rowHeight = 75;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
        cell.textLabel.numberOfLines = 3;
    }
    else if(indexPath.row == 2) {
        // row for location
        cell.imageView.image = [UIImage imageNamed:@"location_3.png"];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
        
        if ([expense.location valueForKey:@"name"] != nil)
        {
            
            cell.textLabel.text = [expense.location valueForKey:@"name"];
            
        }
        else 
        {
            cell.textLabel.text = @"none";
        }
        
    }
    else {
        
        //cell.backgroundView ;
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
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
#pragma EditTransactionProtocol

- (void) didEditExpense {
    
    [self.tableView reloadData];
    
}



- (void) dealloc {
    
    [super dealloc];
    [pict_container release];
}

@end
