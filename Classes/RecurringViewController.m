//
//  RecurringViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import "RecurringViewController.h"
#import "AddRecurringViewController.h"
#import "Recurring.h"
#import "RecurringDetailViewController.h"
#import "SplendidUtils.h"

@interface RecurringViewController (PrivateMethod)
- (void) addRecurring;
- (void) showInformationWhenDataEmpty;
@end

@implementation RecurringViewController

@synthesize recurrings;
@synthesize managedObjectContext;
@synthesize fetchedResultsController;
@synthesize noRecurrLabel;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];	self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50.0;
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.bounds;
	
	[self.navigationController.view addSubview:bodyImageView];
    [self.navigationController.view sendSubviewToBack:bodyImageView];
    [bodyImageView release];
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.shadowColor = [UIColor colorWithRed:186.0f/255.0f green:204.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
	titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
	[titleLabel setText:@"Recurring"];
	titleLabel.textColor = [UIColor colorWithRed:69.0f/255.0f green:74.0f/255.0f blue:77.0f/255.0f alpha:1.0f];
	titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.alpha = 0.5;
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
	
	self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *addRecurr = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRecurring)];
    self.navigationItem.rightBarButtonItem = addRecurr;
    [addRecurr release];
    
    
    noRecurrLabel = [[[UILabel alloc] initWithFrame:CGRectMake(40.0, 80.0, 252.0, 150.0)] autorelease];
    noRecurrLabel.textAlignment = UITextAlignmentLeft;
    noRecurrLabel.shadowColor = [UIColor whiteColor];
    noRecurrLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    [noRecurrLabel setText:@"Recurring is your monthly fixed expenses. Your income will be deducted automatically every month."];
    noRecurrLabel.textColor = [UIColor colorWithRed:69.0f/255.0f green:74.0f/255.0f blue:77.0f/255.0f alpha:0.7f];
    noRecurrLabel.backgroundColor = [UIColor clearColor];
    noRecurrLabel.numberOfLines = 5;
    //noImageLabel.alpha = 0.5;
    noRecurrLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    
    [self.view addSubview:noRecurrLabel];
    
    [self showInformationWhenDataEmpty];
    
	[titleLabel release];
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    NSInteger recurCount = [sectionInfo numberOfObjects];
    
    if (recurCount == 0) {
        /*
        NSLog(@"recurr: %d", recurCount);
        UILabel *noRecurrLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 80.0, 252.0, 150.0)];
        //noImageLabel.center = self.view.center;
        noRecurrLabel.textAlignment = UITextAlignmentLeft;
        noRecurrLabel.shadowColor = [UIColor whiteColor];
        noRecurrLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        [noRecurrLabel setText:@"Recurring is your monthly fixed expenses. Your income will be deducted automatically every month."];
        noRecurrLabel.textColor = [UIColor colorWithRed:69.0f/255.0f green:74.0f/255.0f blue:77.0f/255.0f alpha:0.7f];
        noRecurrLabel.backgroundColor = [UIColor clearColor];
        noRecurrLabel.numberOfLines = 5;
        //noImageLabel.alpha = 0.5;
        noRecurrLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        
        //[self.view addSubview:noRecurrLabel];
        [noRecurrLabel release];
         */
    }
	
	//self.title = @"Splendid";
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Goal"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                                                   ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    
    }
    
    self.recurrings = fetchedObjects;
    
    
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
}

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
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath { 

    
    Recurring *recurring = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSInteger choosedDay = recurring.day.integerValue;
    NSLog(@"day: %d", choosedDay);
    NSString *dateSuffix = choosedDay == 1 ? @"st" : choosedDay == 2 ? @"nd" : choosedDay == 3 ? @"rd" : @"th";
    cell.textLabel.text = [SplendidUtils currencyIDFormatWithString:recurring.recurringAmount.description];
    cell.imageView.image = [UIImage imageNamed:@"home_cat_3.png"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"on %d%@ every month", choosedDay, dateSuffix];
    //NSLog(@"%@", );
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.indentationWidth = 20.0;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
        cell.textLabel.shadowColor = [UIColor whiteColor];
        cell.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        
    }
    
    /*
    Recurring *recurring = [self.recurrings objectAtIndex:indexPath.row];
    NSInteger choosedDay = 2;
    NSString *dateFormat = choosedDay == 1 ? @"st" : choosedDay == 2 ? @"nd" : choosedDay == 3 ? @"rd" : @"st";
    cell.textLabel.text = [SplendidUtils currencyIDFormatWithString:recurring.recurringAmount.description];
    cell.textLabel.text = @"Rp150.000";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"on 24th every month"];
    cell.imageView.image = [UIImage imageNamed:@"home_cat_3.png"];
     */
   // cell.detailTextLabel.text = [NSString stringWithFormat:@"on %d%@ every month", choosedDay, dateFormat];
    // Configure the cell...
    
    UIImage *backgroundCell = [[UIImage imageNamed:@"cell_bg_5.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
    cell.backgroundColor = [UIColor clearColor];
    // if (indexPath.row % 2 == 0) {
    cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundCell] autorelease];
    cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //cell.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0];
    cell.backgroundColor = [UIColor clearColor];
    cell.frame = cell.bounds;
    
    [self configureCell:cell atIndexPath:indexPath];
    
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
#pragma mark Add Recurring

- (void) addRecurring {
    
    
    Recurring *recurring = [NSEntityDescription insertNewObjectForEntityForName:@"Recurring" inManagedObjectContext:self.managedObjectContext];
    
    AddRecurringViewController *addRecurr = [[AddRecurringViewController alloc] init];
    addRecurr.recurring = recurring;
    UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:addRecurr];
    [addRecurr release];
    
    [self.navigationController presentModalViewController:aNavController animated:YES];
    [aNavController release];
    
}


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
    
    Recurring *recurring = [fetchedResultsController objectAtIndexPath:indexPath];
    
    RecurringDetailViewController *recurringDetail = [[RecurringDetailViewController alloc] init];
    recurringDetail.recurring = recurring;
    [self.navigationController pushViewController:recurringDetail animated:YES];
    [recurringDetail release];
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recurring" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    //[fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController;
}  

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
           
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
            [self showInformationWhenDataEmpty];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
             [self showInformationWhenDataEmpty];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller is about to start sending change notifications, so prepare the table view for updates.
	[self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller has sent all current change notifications, so tell the table view to process all updates.
	[self.tableView endUpdates];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void) showInformationWhenDataEmpty {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    NSInteger recurCount = [sectionInfo numberOfObjects];
    
    if (recurCount == 0) {
        NSLog(@"recurr: %d", recurCount);
       
        //noImageLabel.center = self.view.center;
        noRecurrLabel.hidden = NO;
       
        
    }
    else {
        
        noRecurrLabel.hidden = YES;
    }
	
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        NSError *error = nil;
        
        Recurring *recurring = (Recurring *)[fetchedResultsController objectAtIndexPath:indexPath];
        [recurring.managedObjectContext deleteObject:recurring];
        
        if (![recurring.managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }    
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

