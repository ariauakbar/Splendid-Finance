//
//  AddNewExpenseViewController.m
//  Splendid
//
//  Created by  Ariau Akbar on 9/22/11.
//  Copyright 2011 JPMobile. All rights reserved.
//

#import "AddNewExpenseViewController.h"
#import "NoteViewController.h"
#import "Expense.h"
#import <QuartzCore/QuartzCore.h>
#import "ExpenseCategoryViewController.h"
#import "SplendidUtils.h"
#import "LocationViewController.h"
#import "Formatters.h"

#define kOriginalImage @"UIImagePickerControllerOriginalImage"

@interface AddNewExpenseViewController (PrivateMethod)
- (void)showMenu;
- (NSString *)stringWithCurrencyFormat:(NSString *)string;
- (void)addPhotoLibrary;
- (void)addNote;
- (void)addPhotoCamera;
- (void)addExpenseCategory;
- (void)addLocation;
- (void)bringThumbnail:(UIImage *)thumbnail;
@end

@implementation AddNewExpenseViewController

@synthesize expenseField;
@synthesize delegate;
@synthesize numberFormatter;
@synthesize expense;
@synthesize toolbar;
@synthesize mutabString;
@synthesize localCurrencySymbol;
@synthesize localGroupingSeparator;
@synthesize currencyFormatter;
@synthesize basicFormatter;
@synthesize nonNumberSet;
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
    
    NSLog(@"View Did Load");
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveExpense)];
	self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.rightBarButtonItem.enabled = NO;
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
    
    mutabString = [[NSMutableString alloc] init];
    //self.title = [SplendidUtils simpleDateFormat:[NSDate date]];
    self.title = @"Expense";
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
	
    NSLog(@"expense: %@", expense.totalExpense);
	//[textField release];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    NSLog(@"viewWillAppear called");
    NSLog(@"%@", [expense.expenseAmount description]);
    
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    NSLog(@"viewWillDisappear");
    //NSString *amountToSave = [self.expenseField text];
    //expense.expenseAmount = [NSDecimalNumber decimalNumberWithString:amountToSave];
    
}

#pragma mark -
#pragma mark UIComponents

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
        
        /*
        if (self.expense.expenseAmount != 0) {
            NSLog(@"exist");
            //expenseField.placeholder = [self.expense.expenseAmount description];
            expenseField.text = [self.expense.expenseAmount description];
        }
        else {
            
            //expenseField.placeholder = @"0.00";
        }
         */
         
        
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
    [[UIToolbar appearance] setTintColor:[UIColor colorWithRed:107.0f/255.0f green:114.0f/255.0f blue:127.0f/255.0f alpha:1.0f]];
    //[[UIToolbar appearance] setTintColor:[UIColor grayColor]];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showMenu)];
    UIBarButtonItem *blankspace_middle_left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *blankspace_middle_center = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *blankspace_middle_right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *category = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addExpenseCategory)];
    
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
	NSLog(@"begin editing");
	//expenseField.text = [expenseField.text stringByAppendingString:@"Rp"];
	
	//if ([textField.text length] == 4) {
		
    
//	textField.placeholder = nil;
	//}
	
	
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


// http://www.thepensiveprogrammer.com/2011/12/uitextfield-format-for-currency.html

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
#pragma mark ActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"buttonIndex 0");
            [self addPhotoCamera];
            break;
        case 1:
            NSLog(@"buttonIndex 1");
            [self addPhotoLibrary];
            break;
        case 2:
            NSLog(@"buttonIndex 2");
            [self addLocation];
            break;
        case 3:
            NSLog(@"buttonIndex 3");
            [self addNote];
            break;
        default:
            break;
    }
    
}

- (void)showMenu {
    
    NSString *notes = expense.notes == nil ? @"Add Notes..." : @"Edit Notes..."; 
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Additional Info" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo...", @"Photo from Library...", @"Add Location", notes, nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    [actionSheet release];
    
}

#pragma mark -
#pragma mark EditingCurrency


- (NSString *)stringWithCurrencyFormat:(NSString *)string {
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"id_ID"];
    NSNumberFormatter *numF = [[[NSNumberFormatter alloc] init] autorelease];
    //[numF setNumberStyle:NSNumberFormatterDecimalStyle];
    [numF setLocale:locale];
    [locale release];
    double stringDouble = [string doubleValue];
    
    return [numF stringFromNumber:[NSNumber numberWithDouble:stringDouble]];
}

- (void)cancel {
	
    NSError *error = nil;
   
    if(self.expense) { 
        [expense.managedObjectContext deleteObject:expense];
    
        if (![expense.managedObjectContext save:&error]) {
        
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
	[self dismissModalViewControllerAnimated:YES];
//	[self.delegate AddNewExpenseViewController:self didSaveExpense:[NSDecimalNumber decimalNumberWithString:[self.expenseField text]]];
	
}

- (void)saveExpense {
    
 
    NSLog(@"Saving Expense");
	//[self.delegate AddNewExpenseViewController:self didSaveExpense:[NSDecimalNumber decimalNumberWithString:[self.expenseField text]]];
    
    NSLog(@"expenseField -- %@ -- ", [[self.expenseField text] stringByReplacingOccurrencesOfString:@"." withString:@""]);
    // omit the "."
    NSString *amountToSave = [[self.expenseField text] stringByReplacingOccurrencesOfString:@"." withString:@""];
    // save to memory
    expense.expenseAmount = [NSDecimalNumber decimalNumberWithString:[amountToSave stringByReplacingOccurrencesOfString:@"Rp" withString:@""]];
    
    expense.date = [NSDate date];
    
  //  NSDecimalNumber *decimalNumber = [[[NSDecimalNumber alloc] initWithInt:1000] autorelease];
    // save to disk (Sqlite3)
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        
        dispatch_sync(dispatch_get_main_queue(), ^{
        
            NSError *error = nil;
            if (![expense.managedObjectContext save:&error]) {
                
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            
            [self dismissModalViewControllerAnimated:YES];
        });
     
    });
    
    
   // calling delegate

}

#pragma mark - 
#pragma mark Expense Metadata

- (void)addPhotoLibrary {
    
    NSLog(@"AddPhoto");
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self.navigationController presentModalViewController:imagePicker animated:YES];
    [imagePicker release];
    
}

- (void)addPhotoCamera {
    
    NSLog(@"AddPhotoCamera");
    //if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"Camera ready");
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        [self.navigationController presentModalViewController:imagePicker animated:YES];
        [imagePicker release];
    //}
}

- (void)addNote {
    
    NoteViewController *noteVC = [[NoteViewController alloc] init];
    noteVC.expense = self.expense;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:noteVC];
    navController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [noteVC release];
    
    [self.navigationController presentModalViewController:navController animated:YES];
    [navController release];
    
}

- (void)addExpenseCategory {
    
    ExpenseCategoryViewController *newViewController = [[ExpenseCategoryViewController alloc] init];
    newViewController.expense = self.expense;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newViewController];
    [self.navigationController presentModalViewController:navController animated:YES];
    
    
    [newViewController release];
    [navController release];
    
}

- (void)addLocation {
    
    LocationViewController *locationViewController = [[LocationViewController alloc] init];
    locationViewController.expense = self.expense;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:locationViewController];
    [self.navigationController presentModalViewController:navController animated:YES];
    
    [locationViewController release];
    [navController release];
    
}

#pragma mark -
#pragma mark UIImagePickerController

// This method called when app finished choosing any image from library or camera
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    UIImage *selectedImage = [info valueForKey:kOriginalImage];
    CGSize size = selectedImage.size;
    NSLog(@"%f", size.width);
    CGFloat ratio = 0;
    // resizing Image
    if (size.width > size.height) {
        
        ratio = 60.0 / size.width;
        
    } else {
        
        ratio = 65.0 / size.height;
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, 22.0, 22.0);
    UIGraphicsBeginImageContext(rect.size);
    [selectedImage drawInRect:rect]; // redrawn image to desired size
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext(); // save to thumbnail
    UIGraphicsEndImageContext();
    [self bringThumbnail:thumbnail]; // perform animation
    //UIImageView *v = [[UIImageView alloc] initWithImage:thumbnail];
    //v.frame = CGRectMake(40.0, 130.0, thumbnail.size.width, thumbnail.size.height);
    //[self.view addSubview:v];
    
    NSManagedObject *oldImage = self.expense.image;
    
    if (oldImage != nil) {
        [expense.managedObjectContext deleteObject:oldImage];
    }
    
    //NSData *resizedImageData = [SplendidUtils resizeImageToJPEG:selectedImage];
    NSString *imageName = [NSString stringWithFormat:@"image_%@", [[[NSDate date] description] stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
    NSDictionary *dict = [SplendidUtils saveImageToFileSystem:selectedImage withName:imageName];
    
    NSLog(@"a fullpath: %@", [dict objectForKey:@"path"]);
    NSLog(@"a result: %@", [dict objectForKey:@"result"]);
    
    if ([dict objectForKey:@"result"] == [NSNumber numberWithBool:YES]) {
        
        NSManagedObject *fullImage = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:self.expense.managedObjectContext];
        expense.image = fullImage;
        NSString *path = [dict objectForKey:@"path"];
        [fullImage setValue:path forKey:@"imagePath"];
        NSLog(@"Image saved!");
    }
    
    //[fullImage setValue:[UIImage imageWithData:resizedImageData] forKey:@"image"];
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)bringThumbnail:(UIImage *)thumbnail {
    
    UIImageView *thumbView = [[UIImageView alloc] initWithImage:thumbnail];
    thumbView.backgroundColor = [UIColor blackColor];
    thumbView.layer.cornerRadius = 3.0;
    [thumbView.layer setMasksToBounds:YES];
    thumbView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    thumbView.layer.borderWidth = 1.0;
    thumbView.layer.shadowColor = [UIColor whiteColor].CGColor;
    thumbView.layer.shadowOffset = CGSizeMake(2.0f, 2.0);
    thumbView.layer.shadowOpacity = 1.0;
    thumbView.userInteractionEnabled = YES;
    //thumbView.layer.shadowRadius = 1.0f;
    [UIView animateWithDuration:0.8 animations:^{
        
        [self.view addSubview:thumbView];
        thumbView.frame = CGRectMake(360.0, 168.0 , thumbnail.size.width, thumbnail.size.height);
        thumbView.frame = CGRectMake(55.0, 168.0 , thumbnail.size.width, thumbnail.size.height);
        //thumbView.layer.cornerRadius = 8.0;
        // thumbView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
                     completion:^(BOOL finished){
                         
                
                         
    }];

    
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
