//
//  AddGoalViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 1/2/12.
//  Copyright (c) 2012 JPMobile. All rights reserved.
//

#import "AddGoalViewController.h"
#import "Goal.h"
#import "DashboardViewController.h"
#import "Income.h"
#import "Formatters.h"
#import "SplendidUtils.h"

@interface AddGoalViewController (PrivateMethod)
//- (CGFloat) sliderValueChanged:(id)sender;
- (NSInteger) portionFromCurrentBudget:(NSInteger) portion;
- (void) registerForKeyboardNotifications;
- (void) cancelAddingGoal;
- (void) saveGoal;
@end

@implementation AddGoalViewController

@synthesize whatTextField;
@synthesize priceTextField;
@synthesize asideSlider;
@synthesize asideStateLabel;
@synthesize currentBudget;
@synthesize activeField;
@synthesize portion;
@synthesize managedObjectContext;
@synthesize goal;
@synthesize income;
@synthesize saveTextField;
@synthesize localCurrencySymbol;
@synthesize localGroupingSeparator;
@synthesize currencyFormatter;
@synthesize basicFormatter;
@synthesize nonNumberSet;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50.0;
    //self.tableView.bounces = NO;
   // self.tableView.backgroundColor = [UIColor clearColor];
    //self.view.backgroundColor = [UIColor clearColor];
    NSLog(@"Income: %@", income.totalIncome);
    //self.currentBudget = [income.totalIncome integerValue] - [expense.totalExpense integerValue] ;
    UIImage *bodyImage = [UIImage imageNamed:@"body_background.png"];
	UIImageView *bodyImageView = [[UIImageView alloc] initWithImage:bodyImage];
	bodyImageView.frame = self.view.frame;
	
	[self.navigationController.view addSubview:bodyImageView];
    [self.navigationController.view sendSubviewToBack:bodyImageView];
    [bodyImageView release];
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAddingGoal)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    [cancelButtonItem release];
    
    UIBarButtonItem *saveGoalButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveGoal)];
    self.navigationItem.rightBarButtonItem = saveGoalButtonItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [saveGoalButtonItem release];
    
    NSLocale* locale = [[NSLocale alloc] initWithLocaleIdentifier:@"id_ID"];
    localCurrencySymbol = [locale localeIdentifier];
    localGroupingSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
    
    currencyFormatter = [[Formatters currencyFormatterWithNoFraction] retain];
    basicFormatter = [[Formatters basicFormatter] retain];
    
    NSMutableCharacterSet *numberSet = [[NSCharacterSet decimalDigitCharacterSet] mutableCopy];
    [numberSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    nonNumberSet = [[numberSet invertedSet] retain];
    [numberSet release];
	
    
    [self registerForKeyboardNotifications];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.shadowColor = [UIColor whiteColor];
        cell.textLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if (indexPath.row % 2 == 1) {
            cell.backgroundColor = [UIColor clearColor];
        }
        
        if (indexPath.row == 0) {
            /*
            asideStateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.frame.size.width - 5, cell.frame.size.height)];
            asideStateLabel.backgroundColor = [UIColor clearColor];
            asideStateLabel.textAlignment = UITextAlignmentCenter;
            asideStateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
            asideStateLabel.textColor = [UIColor darkGrayColor];
            asideStateLabel.shadowColor = [UIColor whiteColor];
            asideStateLabel.shadowOffset = CGSizeMake(0.0, 1.0);
            asideStateLabel.text = self.asideStateLabel.text = [NSString stringWithFormat:@"0%% of %d: 0/month", self.currentBudget];
            
            [cell.contentView addSubview:asideStateLabel];
            [asideStateLabel release];
             
             
             */
            
            cell.textLabel.text = @"What";
            whatTextField = [[UITextField alloc] initWithFrame:CGRectMake(120.0, 14.0, 170.0, 100.0)];
            whatTextField.borderStyle = UITextBorderStyleNone;
            whatTextField.placeholder = @"Nike Shoes";
            whatTextField.textColor = [UIColor darkGrayColor];
            whatTextField.delegate = self;
            whatTextField.adjustsFontSizeToFitWidth = YES;
            
            [cell.contentView addSubview:whatTextField];
            [whatTextField release];
            
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"Price";
           
            
            priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(120.0, 14.0, 170.0, 100.0)];
            priceTextField.borderStyle = UITextBorderStyleNone;
            priceTextField.placeholder = @"Rp.900.000";
            priceTextField.keyboardType = UIKeyboardTypeNumberPad;
            priceTextField.textColor = [UIColor darkGrayColor];
            priceTextField.delegate = self;
            priceTextField.adjustsFontSizeToFitWidth = YES;
            
            [cell.contentView addSubview:priceTextField];
            [priceTextField release];
      
            
        }
        else if (indexPath.row == 2){
            cell.textLabel.text = @"Save/month";
            
            saveTextField = [[UITextField alloc] initWithFrame:CGRectMake(120.0, 14.0, 170.0, 100.0)];
            saveTextField.borderStyle = UITextBorderStyleNone;
            saveTextField.placeholder = @"Rp.150.000";
            saveTextField.keyboardType = UIKeyboardTypeNumberPad;
            saveTextField.textColor = [UIColor darkGrayColor];
            saveTextField.delegate = self;
            saveTextField.adjustsFontSizeToFitWidth = YES;
            
            [cell.contentView addSubview:saveTextField];
            [saveTextField release];
            
        }
        
        else
        {
            //cell.textLabel.text = @"Oke";
          /*  cell.textLabel.text = @"Set Aside";
            
            asideSlider = [[UISlider alloc] initWithFrame:CGRectMake(120.0, -24.0, 170.0, 100.0)];
            asideSlider.minimumValue = 0.0;
            asideSlider.maximumValue = 100.0;
            [asideSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
            asideSlider.continuous = YES;
            
            [cell.contentView addSubview:asideSlider];
            [asideSlider release];
           */
            
            cell.textLabel.text = @"Set Your Financial Goal";
            
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

#pragma mark -
#pragma Class Controller

- (void)sliderValueChanged:(id) aSender {
    
    portion = [(UISlider *) aSender value];
    
    NSLog(@"%d", portion);
    
    self.asideStateLabel.text = [NSString stringWithFormat:@"%d%% of %d: %d/month", portion, self.currentBudget, [self portionFromCurrentBudget:portion]];
    
}

- (NSInteger) portionFromCurrentBudget:(NSInteger) portionValue {
    
    if (portionValue > 70) 
    {
        
        self.asideStateLabel.textColor = [UIColor redColor];
    }
    else
    {
        self.asideStateLabel.textColor = [UIColor darkGrayColor];
    }
    
    NSLog(@"portion: %d", portion);
    NSInteger savePerMonth = (portionValue * currentBudget) / 100;
    NSLog(@"saveperMonth: %d", savePerMonth);
    return savePerMonth;
}

- (void) cancelAddingGoal {
    
    NSError *error = nil;
    
    if(goal) { 
        [goal.managedObjectContext deleteObject:goal];
        [income.managedObjectContext deleteObject:income];
        
        if (![goal.managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void) saveGoal {
    
    
    self.goal.what = self.whatTextField.text;
    NSLog(@"price: %@", self.priceTextField.text);
    self.goal.price = [NSDecimalNumber decimalNumberWithString:[[self.priceTextField.text stringByReplacingOccurrencesOfString:@"Rp" withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""]];
    self.goal.asideAmount = [NSDecimalNumber decimalNumberWithString:[[self.saveTextField.text stringByReplacingOccurrencesOfString:@"Rp" withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""]];
    self.goal.date = [NSDate date];
    
    NSError *error = nil;
    
    if (![self.goal.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void) checkTextFieldContent {
    
    NSLog(@"called");
    
    if ([self.whatTextField.text isEqualToString:@""])
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else if ([self.priceTextField.text isEqualToString:@""])
        
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else if ([self.saveTextField.text isEqualToString:@""])
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else 
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    
}



-(BOOL)textField:(UITextField *)textField 
shouldChangeCharactersInRange:(NSRange)range 
replacementString:(NSString *)string{
    BOOL result = NO; //default to reject
    
    [self performSelector:@selector(checkTextFieldContent) withObject:nil afterDelay:0.3];
    
    if (textField == priceTextField || textField == saveTextField) 
    {
    
    NSLog(@"%@ : %@", textField.text, string);
    
    if([string length] == 0){ //backspace
            result = YES;
            NSLog(@"result: YES");
        }
    
    else{
    if([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0){
            result = YES;
            
            NSLog(@"stringTrimmed: %@", [string stringByTrimmingCharactersInSet:nonNumberSet]);
        }
    }
   
    
    
    //here we deal with the UITextField on our own
    if(result){
        //grab a mutable copy of what's currently in the UITextField
        NSMutableString* mstring = [[textField text] mutableCopy];
        NSLog(@"msString: %@", mstring);
        
        //adding a char or deleting?
        if([string length] > 0){
            [mstring insertString:string atIndex:range.location];
            NSLog(@"msString inserted: %@", mstring);
        }
        else {
            //delete case - the length of replacement string is zero for a delete
            [mstring deleteCharactersInRange:range];
        }
        
        //remove any possible symbols so the formatter will work
        NSString* clean_string = [[mstring stringByReplacingOccurrencesOfString:@"." 
                                                                     withString:@""]
                                  stringByReplacingOccurrencesOfString:@"Rp" 
                                  withString:@""];
        NSLog(@"clean string: %@", clean_string);
        
        //clean up mstring since it's no longer needed
        [mstring release];
        
        NSNumber* number = [basicFormatter numberFromString: clean_string];
        
        //now format the number back to the proper currency string
        //and get the grouping separators added in and put it in the UITextField
        [textField setText:[currencyFormatter stringFromNumber:number]];
        }
     
    
    //always return no since we are manually changing the text field
    return NO;
    }
    else {
        
        return YES;
    }
    
}





#pragma mark -
#pragma ContentHandlingFromKeyboard

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSLog(@"keyboardShown");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [self.tableView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSLog(@"keyboardWillBeHidden");
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"didBeginEditing");
    activeField = textField;

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    /*
    NSLog(@"didEndEditing");
    activeField = nil;
    if (!(self.whatTextField.text == @"") && !(self.priceTextField.text == @"") && !(portion == 0)) {
        
        NSLog(@"empty");
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
     */
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
