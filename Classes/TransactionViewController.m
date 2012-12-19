//
//  TransactionViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 7/26/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import "TransactionViewController.h"
#import "TransactionDetailViewController.h"
#import "AddNewExpenseViewController.h"
#import "Expense.h"
#import "SplendidUtils.h"


@implementation TransactionViewController

@synthesize transactions;
@synthesize managedObjectContext;
@synthesize fetchedResultsController;
@synthesize catIcon;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad");
    //self.tableView.bounces = NO;
     self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];	
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50.0;
    
    //self.tableView.bounces = NO;
    //self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 216.0, 0.0); 
    //self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
   // self.title = @"List";
    UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.bounds;
	
	[self.navigationController.view addSubview:bodyImageView];
    [self.navigationController.view sendSubviewToBack:bodyImageView];
    [bodyImageView release];
	
  
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor] forState:UIControlStateNormal];
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.shadowColor = [UIColor colorWithRed:186.0f/255.0f green:204.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
	titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
	[titleLabel setText:@"Transactions"];
	titleLabel.textColor = [UIColor colorWithRed:69.0f/255.0f green:74.0f/255.0f blue:77.0f/255.0f alpha:1.0f];
	titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.alpha = 0.5;
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
	
	self.navigationItem.titleView = titleLabel;
	//self.navigationItem.backBarButtonItem.title = @"List";
    
	//self.navigationItem.titleView = titleLabel;
	
	[titleLabel release];
    
    
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
    
    
  //  self.transactions = [NSArray arrayWithObjects:@"Rp.2000,00", @"Rp.35000,00", @"Rp.56000", @"Rp.67000", @"Rp.35000", nil];
	
	//self.title = @"Splendid";
   	self.catIcon = [NSArray arrayWithObjects:@"food_3.png", @"commute.png", @"home_6.png", nil];
    
    

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[self updateTransactions];
   // [self.tableView reloadData];
    //[self.tableView beginUpdates];
    NSLog(@"ViewWillAppear");
  
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
    
    Expense *expense = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *expenseText = [[expense valueForKey:@"expenseAmount"] description];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"id_ID"];
    NSNumberFormatter *numF = [[[NSNumberFormatter alloc] init] autorelease];
    [numF setLocale:locale];
    [locale release];
    [numF setNumberStyle:NSNumberFormatterCurrencyStyle];
    double stringDouble = [expenseText doubleValue];
    cell.textLabel.text = [numF stringFromNumber:[NSNumber numberWithDouble:stringDouble]];
    cell.imageView.image = [UIImage imageNamed:[SplendidUtils getImageNameForCategory:[expense.category valueForKey:@"name"]]];
    //NSLog(@"%@", );
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        //cell.indentationLevel = 16;
        cell.indentationWidth = 20.0;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0];
        cell.textLabel.shadowColor = [UIColor whiteColor];
        cell.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        
        //NSIndexPath *defaultIndex = []
        /*
        NSLog(@"Path: -- %d and count: %d", indexPath.row, self.catIcon.count);
        if (indexPath.row >= self.catIcon.count) {
            cell.imageView.image = [UIImage imageNamed:[self.catIcon objectAtIndex:0]];        }
        else {
            NSLog(@"Current Path: %d", indexPath.row);
            cell.imageView.image = [UIImage imageNamed:[self.catIcon objectAtIndex:indexPath.row]];
        }
         */
        
        
        if (indexPath.row == 3) {
            
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(250.0, 4.0, 60, 40)];
            [dateLabel setText:@"income"];
            dateLabel.textColor = [UIColor grayColor];
            dateLabel.shadowColor = [UIColor whiteColor];
            dateLabel.shadowOffset = CGSizeMake(0.0, 1.0);
            dateLabel.backgroundColor = [UIColor clearColor];
            dateLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:13.0];
            
            [cell.contentView addSubview:dateLabel];
        }
        
        [self configureCell:cell atIndexPath:indexPath];
           
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    UIImage *backgroundCell = [[UIImage imageNamed:@"cell_bg_5.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)];
    cell.backgroundColor = [UIColor clearColor];
    // if (indexPath.row % 2 == 0) {
    cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundCell] autorelease];
    cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //cell.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0];
    cell.backgroundColor = [UIColor clearColor];
    cell.frame = cell.bounds;

    
    
    
    /* }
     else {
     
     cell.backgroundView = [[UIImageView alloc] initWithImage:lbackgroundCell];
     cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
     //cell.backgroundColor = [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0];
     cell.backgroundColor = [UIColor clearColor];
     cell.frame = cell.bounds;
     
     }
     */
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.backgroundColor = [UIColor clearColor];
}


- (void)updateTransactions {
    
    NSEntityDescription *expense = [NSEntityDescription entityForName:@"Expense" inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *fetch = [[[NSFetchRequest alloc] init] autorelease];
    [fetch setEntity:expense];
    [fetch setResultType:NSDictionaryResultType];
    NSError *error = nil;
    transactions = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    
    if (transactions == nil) {
        
        NSLog(@"No data retrived");
    }
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
    
    Expense *expense = (Expense *)[fetchedResultsController objectAtIndexPath:indexPath];
    
    /*
    AddNewExpenseViewController *newExpense = [[AddNewExpenseViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newExpense];
    newExpense.expense = expense;
    [newExpense release];
    [self presentModalViewController:navController animated:YES];
    [navController release];
     */
    
    TransactionDetailViewController *transDetail = [[TransactionDetailViewController alloc] init];
    transDetail.expense = expense;
    [self.navigationController pushViewController:transDetail animated:YES];
    [transDetail release];
    
    
    
    /*
    TransactionDetailViewController *transDetailController = [[TransactionDetailViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:transDetailController];
    [transDetailController release];
    [self presentModalViewController:navController animated:YES];
    [navController release];
     */
}

#pragma mark -
#pragma mark NSFetchedRequestsController


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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expense" inManagedObjectContext:self.managedObjectContext];
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
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        NSError *error = nil;
        
        Expense *expense = (Expense *)[fetchedResultsController objectAtIndexPath:indexPath];
        [expense.managedObjectContext deleteObject:expense];
        
        if (![expense.managedObjectContext save:&error]) {
            
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
    NSLog(@"didReceiveMemoryWarning");
    
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

