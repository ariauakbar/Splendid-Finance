//
//  IncomeViewController.m
//  Splendid
//
//  Created by Nidia Badzlin Adlina on 8/6/11.
//  Copyright 2011 Bina Nusantara. All rights reserved.
//

#import "IncomeViewController.h"
#import "ExpenseCategoryViewController.h"
#import "Income.h"
#import "SplendidUtils.h"
#import "IncomeCategoryViewController.h"
#import "Formatters.h"


@interface IncomeViewController (PrivateMethod)
- (void)addIncomeCategory;
- (void)saveIncome;
@end

@implementation IncomeViewController

@synthesize incomeField;
@synthesize numberFormatter;
@synthesize toolbar;
@synthesize income;
@synthesize delegate;
@synthesize localCurrencySymbol;
@synthesize localGroupingSeparator;
@synthesize currencyFormatter;
@synthesize basicFormatter;
@synthesize nonNumberSet;


/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

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
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveIncome)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
    
    self.title = @"Income";
    
    //*** INCOME FIELD ***
    
    UITextField *textField = self.incomeField;
    
    
    [textField becomeFirstResponder];
    
    UIToolbar *incomeToolbar = self.toolbar;
    
    [self.view addSubview:textField];
    [self.view addSubview:incomeToolbar];
    
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
    
    
    NSLog(@"total: %@", income.totalIncome);
}

- (UIToolbar *)toolbar {
    
    toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0.0, 156.0, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    [[UIToolbar appearance] setTintColor:[UIColor colorWithRed:107.0f/255.0f green:114.0f/255.0f blue:127.0f/255.0f alpha:1.0f]];
    //[[UIToolbar appearance] setTintColor:[UIColor grayColor]];

    UIBarButtonItem *blankspace_middle_left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *blankspace_middle_center = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *blankspace_middle_right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *category = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addIncomeCategory)];


    NSArray *itemsArray = [NSArray arrayWithObjects:blankspace_middle_left, blankspace_middle_center, blankspace_middle_right, category, nil];
    toolbar.items = itemsArray;
    [blankspace_middle_left release];
    [blankspace_middle_center release];
    [blankspace_middle_right release];
    [category release];
    
    return toolbar;
}

- (void) saveIncome {
    
    NSString *amountToSave = [[self.incomeField text] stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    self.income.incomeAmount = [NSDecimalNumber decimalNumberWithString:[amountToSave stringByReplacingOccurrencesOfString:@"Rp" withString:@""]];
    self.income.date = [NSDate date];
    
    NSError *error = nil;
    
    if (![self.income.managedObjectContext save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.delegate incomeViewController:self didSaveIncome:self.income];
    
}

- (void) addIncomeCategory {
    
    
    IncomeCategoryViewController *incomeCatVC = [[IncomeCategoryViewController alloc] init];
    incomeCatVC.income = self.income;
    
    UINavigationController *nvController = [[UINavigationController alloc] initWithRootViewController:incomeCatVC];
    [incomeCatVC release];
    
    [self.navigationController presentModalViewController:nvController animated:YES];
    [nvController release];
}


- (UITextField *) incomeField {
    
    if(incomeField == nil) {
    
        incomeField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
        incomeField.keyboardType = UIKeyboardTypeNumberPad;
        incomeField.borderStyle = UITextBorderStyleNone;
        incomeField.placeholder = @"Rp0";
        incomeField.font = [UIFont fontWithName:@"Helvetica" size:46.0];
        incomeField.textColor = [UIColor colorWithRed:107.0f/255.0f green:114.0f/255.0f blue:127.0f/255.0f alpha:1.0f];
        incomeField.delegate = self;
        incomeField.textAlignment = UITextAlignmentRight;
        incomeField.adjustsFontSizeToFitWidth = YES;
        [incomeField becomeFirstResponder];
        
        
        if (self.income.incomeAmount != 0) {
            NSLog(@"exist");
            //expenseField.placeholder = [self.expense.expenseAmount description];
        }
        else {
            
            //expenseField.placeholder = @"0.00";
        }
        
    }

    return incomeField;
}

- (void)cancel {
	
    NSError *error = nil;
    
    if(income) { 
        [income.managedObjectContext deleteObject:income];
        
        if (![income.managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
	[self dismissModalViewControllerAnimated:YES];
    //	[self.delegate AddNewExpenseViewController:self didSaveExpense:[NSDecimalNumber decimalNumberWithString:[self.expenseField text]]];
	
}

-(BOOL)textField:(UITextField *)textField 
shouldChangeCharactersInRange:(NSRange)range 
replacementString:(NSString *)string{
    BOOL result = NO; //default to reject
    
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
