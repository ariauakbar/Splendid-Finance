//
//  LocationViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 12/22/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import "LocationViewController.h"
#import "Expense.h"
#import "ExpenseLocationHelper.h"
#import "ExpenseLocationHelper.h"
#import "IALabel.h"

@implementation LocationViewController

@synthesize expense;
@synthesize searchBar;
@synthesize searchController;
@synthesize locations;
@synthesize locationManager;
@synthesize currentLocation_;
@synthesize titleLabel;
@synthesize locHelper;

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

    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.rowHeight = 50.0;
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = YES;
    
    locHelper = [[ExpenseLocationHelper alloc] init];
    locHelper.delegate = self;
    
    //titleLabel = [[[IALabel alloc] init] autorelease];
    //self.navigationItem.titleView = titleLabel;
    //[titleLabel replaceCurrentTextWithAnimationTo:@"Loading.."];
    self.title = @"Loading...";
    
    UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.frame;
	
	[self.navigationController.view addSubview:bodyImageView];
    [self.navigationController.view sendSubviewToBack:bodyImageView];
    [bodyImageView release];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self.navigationController];
    
    [self.view addSubview:searchController.searchBar];
    searchBar.backgroundColor = [UIColor clearColor];
    [searchBar release];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.frame = CGRectMake(0.0, 0.0, 20, 20);
    [spinner startAnimating];
    spinner.hidesWhenStopped = YES;
    UIBarButtonItem *spinnerView = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    self.navigationItem.leftBarButtonItem = spinnerView;
    [spinnerView release];
    [spinner release];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissModalViewControllerAnimated:)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    [cancelButton release];
    
    //locations = [[NSArray alloc] initWithObjects:@"none",@"Korean Food - Mall Kelapa Gading", @"Burger King - Mal Kelapa Gading", @"Bakmi GM - MKG", @"Warteg Heroy - Salam 3", @"Warung Yono - Salam 3", @"Warung Kito - Syahdan", @"Pom bensin", @"Blitzmegaplex - MOI", nil];
    
    [self.locationManager startUpdatingLocation];
    NSLog(@"current location: %f and %f", [self.locationManager location].coordinate.latitude, [self.locationManager location].coordinate.longitude);

}

// lazy created CLLocationManager

- (CLLocationManager *)locationManager  {
    
    if (locationManager != nil) {
        
        return locationManager;
    }
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    return locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    //NSLog(@"latitude: %f", newLocation.coordinate.latitude);
    //NSLog(@"longitude: %f", newLocation.coordinate.longitude);
    self.currentLocation_ = newLocation;
    NSLog(@"Location Receieved");
    //ExpenseLocationHelper *locationHelper = [[[ExpenseLocationHelper alloc] init] autorelease];
    [locHelper getNearbyLocationsFromCurrentLocation:self.currentLocation_];
    [self.locationManager stopUpdatingLocation];
    //[locationHelper release];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"error");
}

#pragma mark - 
#pragma ExpenseLocationHelper Delegate

- (void) didFinishFindNearbyLocation:(NSArray *)venues {
    
    [spinner stopAnimating];
    NSLog(@"venues: %@", venues);
    locations = [venues copy];
    //0[self.titleLabel replaceCurrentTextWithAnimationTo:@"Location"];
    self.title = @"Location";
    [self.tableView reloadData];
    //NSLog(@"called!");
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.locationManager = nil;
    self.currentLocation_ = nil;
}

- (void) dealloc {
    
    [super dealloc];
    [self.locationManager release];
    [self.titleLabel release];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = locations == nil ? 0 : locations.count;
    // Return the number of rows in the section.
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.indentationWidth = 20.0;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
        cell.textLabel.shadowColor = [UIColor whiteColor];
        cell.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        
        cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10.0];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.shadowColor = [UIColor whiteColor];
        cell.detailTextLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        
    }
    
    
    cell.imageView.image = [UIImage imageNamed:@"location_3.png"];
    
    UIImage *backgroundCell = [[UIImage imageNamed:@"cell_bg_5.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
    // UIImage *lbackgroundCell = [[UIImage imageNamed:@"cell_bg_5.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
    
    //cell.contentView.backgroundColor = [UIColor clearColor];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundCell] autorelease];
    cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cell.backgroundColor = [UIColor clearColor];
    cell.frame = cell.bounds;
    
    // Configure the cell...
    if (locations) 
    {
        
        NSInteger content_desc = [[[locations objectAtIndex:indexPath.row] objectForKey:@"categories"] count];
        
        cell.textLabel.text = [[locations objectAtIndex:indexPath.row] objectForKey:@"name"];
        
        if (content_desc > 0) 
        {
            
            cell.detailTextLabel.text = [[[[locations objectAtIndex:indexPath.row] objectForKey:@"categories"] objectAtIndex:0] objectForKey:@"name"];

        }
        else
        {
            cell.detailTextLabel.text = @"Unknown";
        }
                
        //NSLog(@"categories: -- %@ -- ", [[[[locations objectAtIndex:indexPath.row] objectForKey:@"categories"] objectAtIndex:0] objectForKey:@"name"]);
    }

    
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
    NSManagedObject *currentLocation = self.expense.location;
    
    if (currentLocation != nil) {
        // deselect the current checkmarked cell
        NSInteger index = [locations indexOfObject:currentLocation]; // get the index of current choosed category
        NSIndexPath *selectionIndexPath = [NSIndexPath indexPathForRow:index inSection:0]; // set the IndexPath
        UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath]; // specify the cell
        checkedCell.accessoryType = UITableViewCellAccessoryNone; // set the cell to uncheck the selected cell
    }
    
    // store selected category to expense object
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.expense.managedObjectContext];
    NSManagedObject *location = [NSEntityDescription insertNewObjectForEntityForName:entity.name inManagedObjectContext:self.expense.managedObjectContext];
    NSString *selectedLocation = [[locations objectAtIndex:indexPath.row] objectForKey:@"name"];
    [location setValue:selectedLocation forKey:@"name"];
    
    if (expense.location){
        expense.location = nil;
        expense.location = location;
    }
    else 
    {
        expense.location = location;
    }
        
    // checkmark the selected row
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark]; 
  
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
