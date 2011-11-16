//
//  AddNewExpenseViewController.m
//  Splendid
//
//  Created by  Ariau Akbar on 9/22/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import "AddNewExpenseViewController.h"
#import "Expense.h"

@interface AddNewExpenseViewController (PrivateMethod)
- (void)showMenu;
@end

@implementation AddNewExpenseViewController

@synthesize expenseField;
@synthesize delegate;
@synthesize numberFormatter;
@synthesize expense;
@synthesize toolbar;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveExpense)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
	
	UITextField *textField = self.expenseField;
    [textField becomeFirstResponder];
    
    UIToolbar *aToolbar = self.toolbar;
   
	//textField.text = [textField.text stringByAppendingString:@"Rp."];
	
	[self.view addSubview:textField];
    [self.view addSubview:aToolbar];
	
	//[textField release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark UIComponents

- (UITextField *)expenseField {
	
	if (expenseField == nil) {
		
		expenseField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
		expenseField.keyboardType = UIKeyboardTypeNumberPad;
		expenseField.borderStyle = UITextBorderStyleNone;
		expenseField.placeholder = @"0.00";
        //expenseField.backgroundColor = [UIColor lightGrayColor];
		//expenseField.clearButtonMode = UITextFieldViewModeWhileEditing;
		//expenseField.font = [UIFont systemFontOfSize:30.0];
		expenseField.font = [UIFont fontWithName:@"Helvetica" size:46.0];
		expenseField.textColor = [UIColor blackColor];
		expenseField.delegate = self;
		expenseField.textAlignment = UITextAlignmentRight;
		expenseField.clearsOnBeginEditing = YES;
        
		//expenseField.text = [expenseField setText:[[expenseField text] stringByAppendingString:@"Rp."]];
		
		numberFormatter = [[NSNumberFormatter alloc] init];
		[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
		[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		//[numberFormatter allowsFloats];
		//[numberFormatter setGeneratesDecimalNumbers:YES];
		//[numberFormatter setMaximumFractionDigits:2];
		//[numberFormatter setMinimumFractionDigits:2];
		[numberFormatter alwaysShowsDecimalSeparator];
		[numberFormatter setCurrencyCode:@"IDR"];
        [numberFormatter setPositiveFormat:@"¤#,##0.00"];
		//[numberFormatter setDecimalSeparator:@"."];
		NSNumber *number = [[NSNumber alloc] init];
		
		[expenseField setText:[numberFormatter stringFromNumber:number]];
        [number release];
        [numberFormatter release];
		
	}
		 
	
	return expenseField;
}

- (UIToolbar *)toolbar {
    
    toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0.0, 156.0, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    [[UIToolbar appearance] setTintColor:[UIColor colorWithRed:102.0f/255.0f green:109.0f/255.0f blue:122.0f/255.0f alpha:1.0f]];
    //[[UIToolbar appearance] setTintColor:[UIColor grayColor]];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(showMenu)];
    UIBarButtonItem *blankspace_middle_left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *blankspace_middle_center = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *blankspace_middle_right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *category = [[UIBarButtonItem alloc] initWithTitle:@"Category" style:UIBarButtonItemStylePlain target:self action:nil];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:menu, blankspace_middle_left, blankspace_middle_center, blankspace_middle_right, category, nil];
    toolbar.items = itemsArray;
    [menu release];
    [blankspace_middle_left release];
    [blankspace_middle_center release];
    [blankspace_middle_right release];
    [category release];
    
    return toolbar;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
	NSLog(@"begin editing");
	//expenseField.text = [expenseField.text stringByAppendingString:@"Rp"];
	
	//if ([textField.text length] == 4) {
		
		NSLog(@"aaa");
//	textField.placeholder = nil;
	//}
	
	
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
	
	//if ([expenseField.text length] == 7) {
		
		NSLog(@"true");
		//expenseField.text = [expenseField.text stringByPaddingToLength:[expenseField.text length] + 1 withString:@"," startingAtIndex:3];
	//}
}


/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	NSString *mainString = textField.text;
	
	if ([textField.text length] == 5) {
		
		//expenseField.text = [expenseField.text stringByPaddingToLength:3 withString:@"," startingAtIndex:3];
		NSLog(@"7");
		NSRange range = {3 , 0};
		NSString *tempString = [expenseField.text stringByReplacingCharactersInRange:range withString:@"."];
		expenseField.text = tempString;
	}
	else if ([textField.text length] == 7) {
		
		NSLog(@"8");
		
		NSRange nextCommaRange = {5 , 0};
		NSRange PrevCommaRange = {3 , 1};
		NSString *tempString = [mainString stringByReplacingCharactersInRange:nextCommaRange withString:@","];
		NSString *modifiedString = [tempString stringByReplacingCharactersInRange:PrevCommaRange withString:@""];
		expenseField.text = modifiedString;
		//expenseField.enabled = NO;
	}
 
	
	return YES;
}
 */


/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {     
    NSString *text = [textField text];  // we'll retrieve the old string from the textField to work with.
    NSString *decimalSeperator = @",";  // the appropriate decimalSeperator for the current localisation can be found with help of the
	// NSNumberFormatter and NSLocale classes.
	
	text = [text ]
	
    // we'll define a characterSet to filter all invalid chars. 
    // the entered string will be trimmed down to the valid chars only.
	
	
    NSCharacterSet *characterSet = nil;
    NSString *numberChars = @"0123456789";
	characterSet = [NSCharacterSet characterSetWithCharactersInString:numberChars];
    NSCharacterSet *invertedCharSet = [characterSet invertedSet];   
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:invertedCharSet];
	 */
	//NSLog(@"String =  %@", string);
    //text = [text stringByReplacingCharactersInRange:range withString:string];
	
    // whenever a decimalSeperator is entered, we'll just update the textField.
    // whenever other chars are entered, we'll calculate the new number and update the textField accordingly.
	
	/*
    if ([string isEqualToString:decimalSeperator] == YES) {
        [textField setText:text];
    } else { */
      //  NSNumber *number = [numberFormatter numberFromString:text];
        //if (number == nil)
		//{
		//	number = [NSNumber numberWithInt:0];
		//	NSLog(@"nil");
		//}
        //text = [numberFormatter stringFromNumber:number];
       // [textField setText:text];       
    //}
    //return NO; // we return NO because we have manually edited the textField contents.
//}

/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {   
	
	
	NSString *text  = [expenseField text];
	
	NSCharacterSet *characterSet = nil;
	NSString *numberChars = @"0123456789";
	characterSet = [NSCharacterSet characterSetWithCharactersInString:[numberChars stringByAppendingString:@"."]];
	NSCharacterSet *invertedCharSet = [characterSet invertedSet];
	NSString *trimmedString = [string stringByTrimmingCharactersInSet:invertedCharSet];
	NSLog(@"trimmed = %@", trimmedString);
	text = [text stringByReplacingCharactersInRange:range withString:trimmedString];
	
	expenseField.text = text;
	
	
	return NO;
	
}
*/


- (void)showMenu {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Additional Info" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Add Photo from Camera" otherButtonTitles:@"Add Photo from Gallery", @"Location", @"Notes", nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    [actionSheet release];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	NSString *myString = expenseField.text;
	myString = [myString stringByReplacingOccurrencesOfString:@"." withString:@""];
	expenseField.text = [@"" stringByAppendingFormat:@"%0.2f", [myString floatValue]/100];
	
	return YES;
}


- (void)cancel {
	
    NSError *error = nil;
    
    [expense.managedObjectContext deleteObject:expense];
    
    if (![expense.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
    
	[self dismissModalViewControllerAnimated:YES];
//	[self.delegate AddNewExpenseViewController:self didSaveExpense:[NSDecimalNumber decimalNumberWithString:[self.expenseField text]]];
	
}

- (void)saveExpense {
    
    NSError *error = nil;
    NSLog(@"Saving Expense");
	//[self.delegate AddNewExpenseViewController:self didSaveExpense:[NSDecimalNumber decimalNumberWithString:[self.expenseField text]]];
    
    NSLog(@"expenseField -- %@ -- ", [[self.expenseField text] stringByReplacingOccurrencesOfString:@"." withString:@""]);
    // omit the "."
    NSString *amountToSave = [[self.expenseField text] stringByReplacingOccurrencesOfString:@"." withString:@""];
    // save to memory
    expense.expenseAmount = [NSDecimalNumber decimalNumberWithString:amountToSave];
    
  //  NSDecimalNumber *decimalNumber = [[[NSDecimalNumber alloc] initWithInt:1000] autorelease];
    // save to disk (Sqlite3)
    if (![expense.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
    
   // calling delegate
    [self.delegate AddNewExpenseViewController:self didSaveExpense:self.expense];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
