//
//  AddRecurringViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 12/31/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import "AddRecurringViewController.h"
#import "SplendidUtils.h"
#import "Recurring.h"
#import "ExpenseCategoryViewController.h"
#import "NoteViewController.h"
#import "Formatters.h"

@implementation AddRecurringViewController

@synthesize expenseField;
@synthesize toolbar;
@synthesize datePickerView;
@synthesize eventKit;
@synthesize calendar;
@synthesize eventStore;
@synthesize aPickerView;
@synthesize recurring;
@synthesize days;
@synthesize localCurrencySymbol;
@synthesize localGroupingSeparator;
@synthesize currencyFormatter;
@synthesize basicFormatter;
@synthesize nonNumberSet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveRecurring)];
	self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.rightBarButtonItem.enabled = NO;
	[saveButton release];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
    
    UITextField *textField = self.expenseField;
    [textField becomeFirstResponder];
    
    UIToolbar *aToolbar = self.toolbar;
    
    //UIDatePicker *aDatePickerView = self.datePickerView;
    UIPickerView *pickerView = self.aPickerView;
    
	[self.view addSubview:pickerView];
	[self.view addSubview:textField];
    [self.view addSubview:aToolbar];
    
    NSLocale* locale = [[NSLocale alloc] initWithLocaleIdentifier:@"id_ID"];
    localCurrencySymbol = [locale localeIdentifier];
    localGroupingSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
    
    currencyFormatter = [[Formatters currencyFormatterWithNoFraction] retain];
    basicFormatter = [[Formatters basicFormatter] retain];
    
    //set up the reject character set
    NSMutableCharacterSet *numberSet = [[NSCharacterSet decimalDigitCharacterSet] mutableCopy];
    [numberSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    nonNumberSet = [[numberSet invertedSet] retain];
    [numberSet release];
    
    days = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 31; i++)
    {
        [days addObject:[NSString stringWithFormat:@"%d", i]];
        NSLog(@"%d", i);
    }
    self.title = @"Recurring";
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

#pragma - 
#pragma controllers

- (void) saveRecurring {
    
    self.recurring.date = [NSDate date];
    NSString *amountToSave = [[self.expenseField text] stringByReplacingOccurrencesOfString:@"." withString:@""];
    self.recurring.recurringAmount = [NSDecimalNumber decimalNumberWithString:[amountToSave stringByReplacingOccurrencesOfString:@"Rp" withString:@""]];
    //self.recurring.notes = nil;
    NSString *choosedDay = [self.days objectAtIndex:[aPickerView selectedRowInComponent:0]];
    self.recurring.day = [NSNumber numberWithInteger:[choosedDay integerValue]];
    
    NSError *error = nil;
    
    if (![self.recurring.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
                     
    //eventKit.recurrenceRules
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void) cancel {
    
    NSError *error = nil;
    
    if(self.recurring) { 
        [recurring.managedObjectContext deleteObject:recurring];
        
        if (![recurring.managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void) showCalendarForRecurringEvent {
    
    [self.expenseField resignFirstResponder];
}

- (void) checkTextFieldContent {
    
    NSLog(@"called");
    
    if ([self.expenseField.text isEqualToString:@""])
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

                                                                                                                  
#pragma mark - 
#pragma mark UIComponent

- (UITextField *)expenseField {
	
	if (expenseField == nil) {
		
		expenseField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
		expenseField.keyboardType = UIKeyboardTypeNumberPad;
		expenseField.borderStyle = UITextBorderStyleNone;
		//expenseField.placeholder = @"0.00";
        //expenseField.backgroundColor = [UIColor lightGrayColor];
		//expenseField.clearButtonMode = UITextFieldViewModeWhileEditing;
		//expenseField.font = [UIFont systemFontOfSize:30.0];
		expenseField.font = [UIFont fontWithName:@"Helvetica" size:46.0];
		expenseField.textColor = [UIColor colorWithRed:107.0f/255.0f green:114.0f/255.0f blue:127.0f/255.0f alpha:1.0f];
		expenseField.delegate = self;
		expenseField.textAlignment = UITextAlignmentRight;
		//expenseField.clearsOnBeginEditing = YES;
        expenseField.adjustsFontSizeToFitWidth = YES;
        //[expenseField setText:@"HAHA"];
        expenseField.placeholder = @"Rp0";
        
        
		//expenseField.text = [expenseField setText:[[expenseField text] stringByAppendingString:@"Rp."]];
		
		//numberFormatter = [[NSNumberFormatter alloc] init];
		//[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
		//[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		//[numberFormatter allowsFloats];
		//[numberFormatter setGeneratesDecimalNumbers:YES];
		//[numberFormatter setMaximumFractionDigits:2];
		//[numberFormatter setMinimumFractionDigits:2];
		//[numberFormatter alwaysShowsDecimalSeparator];
		//[numberFormatter setCurrencyCode:@"IDR"];
        //[numberFormatter setPositiveFormat:@"¤#,##0.00"];
		//[numberFormatter setDecimalSeparator:@"."];
		//NSNumber *number = [[NSNumber alloc] init];
		
		//[expenseField setText:[numberFormatter stringFromNumber:number]];
        //[number release];
        //[numberFormatter release];
		
	}
    
	
	return expenseField;
}

- (UIToolbar *)toolbar {
    
    toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0.0, 156.0, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    toolbar.barStyle = UIBarStyleDefault;
    [[UIToolbar appearance] setTintColor:[UIColor colorWithRed:107.0f/255.0f green:114.0f/255.0f blue:127.0f/255.0f alpha:1.0f]];
    //[[UIToolbar appearance] setTintColor:[UIColor grayColor]];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showMenu)];
    UIBarButtonItem *blankspace_middle_left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *blankspace_middle_center = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *blankspace_middle_right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *category = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showCategory)];
    
    // UIButton *cust_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // cust_button.titleLabel.text = @"set";
    
    //UIBarButtonItem *customButton = [[UIBarButtonItem alloc] initWithCustomView:cust_button];
    
    
    NSArray *itemsArray = [NSArray arrayWithObjects:menu, blankspace_middle_left, blankspace_middle_center, blankspace_middle_right, category, nil];
    toolbar.items = itemsArray;
    [menu release];
    [blankspace_middle_left release];
    [blankspace_middle_center release];
    [blankspace_middle_right release];
    [category release];
    
    return toolbar;
}

- (void)pickerValueChanged:(id) sender {
    
    
    self.title = [SplendidUtils simpleDateFormat:[sender date]];
}

- (UIDatePicker *) datePickerView {
    
    datePickerView = [[UIDatePicker alloc] init];
    datePickerView.frame = CGRectMake(0.0, CGRectGetMaxY(self.toolbar.frame), self.view.frame.size.width, self.view.frame.size.height - (self.toolbar.frame.origin.x + self.toolbar.frame.size.height));
    datePickerView.datePickerMode = UIDatePickerModeDate;
    datePickerView.minimumDate = [NSDate date];
    datePickerView.maximumDate = [NSDate dateWithTimeIntervalSinceNow:(60*60*24*365)];
    [datePickerView addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    
    return datePickerView;
}


- (UIPickerView *)aPickerView {
    
    aPickerView = [[UIPickerView alloc] init];
    aPickerView.frame = CGRectMake(0.0, CGRectGetMaxY(self.toolbar.frame), self.view.frame.size.width, self.view.frame.size.height - (self.toolbar.frame.origin.x + self.toolbar.frame.size.height));
    aPickerView.delegate = self;
    aPickerView.dataSource = self;
    aPickerView.showsSelectionIndicator = YES;
    
    return aPickerView;
}

- (void) showCategory {
    
    ExpenseCategoryViewController *categoryView = [[ExpenseCategoryViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:categoryView];
    [categoryView release];
    
    [self.navigationController presentModalViewController:categoryView animated:YES];
    [navController release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"buttonIndex 0");
            [self.expenseField resignFirstResponder];;
            break;
        case 1:
            NSLog(@"buttonIndex 1");
            [self addNote];
            break;
        default:
            break;
    }
    
}

- (void) showMenu {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Additional Info" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose Day..", @"Add notes..", nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    [actionSheet release];
    
}


- (void)addNote {
    
   // Recurring *recuring = [NSEntityDescription insertNewObjectForEntityForName:@"Recurring" inManagedObjectContext:recurring.managedObjectContext];
    
    NoteViewController *noteVC = [[NoteViewController alloc] init];
    noteVC.recurring = self.recurring;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:noteVC];
    navController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [noteVC release];
    
    [self.navigationController presentModalViewController:navController animated:YES];
    [navController release];
    
}


#pragma mark -
#pragma mark PickerView Delegate & Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView 
{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component 
{
    return 31;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component 
{
    return 80.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSLog(@"comp: %d", component);
    return [NSString stringWithFormat:@"    %@", [days objectAtIndex:row]];
}



@end
