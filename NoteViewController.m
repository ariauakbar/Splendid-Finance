//
//  NoteViewController.m
//  Splendid
//
//  Created by Mohamad Ariau Akbar on 11/28/11.
//  Copyright (c) 2011 JPMobile. All rights reserved.
//

#import "NoteViewController.h"
#import "Expense.h"
#import "Recurring.h"

@interface NoteViewController (PrivateMethod)
- (void)dismissKeyboard;
- (void)keyboardShowUpWithAnimation;
- (void)dismissVC;
@end


@implementation NoteViewController

@synthesize textView;
@synthesize expense;
@synthesize recurring;

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
    UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard)];
    self.navigationItem.rightBarButtonItem = dismissButton;
    [dismissButton release];
    
    UIImage *notes = [UIImage imageNamed:@"notes.png"];
    UIImageView *notesView = [[UIImageView alloc] initWithImage:notes];
    notesView.frame = CGRectMake(0.0, 0.0, notes.size.width, notes.size.height);
    [self.view insertSubview:notesView aboveSubview:self.view];
    [notesView release];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(45.0, 0.0, self.view.frame.size.width - 45.0, 100.0)];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    
    
   // textView.delegate = self;
    
    //[textView.delegate ]
    [self.view addSubview:textView];
    
    if (self.expense.notes != nil) {
        
        self.textView.text = self.expense.notes;
    }
    
    if (self.recurring.notes != nil) {
        
        self.textView.text = self.recurring.notes;
    }
    
    // register notification
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissVC) name:UIKeyboardWillHideNotification object:nil];
    
   
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    [textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    [textView resignFirstResponder];
}


- (void)dismissKeyboard {
    
    //if ([textView becomeFirstResponder]) {
        
    [textView resignFirstResponder];
    [self performSelector:@selector(dismissVC) withObject:nil afterDelay:0.2];
    //}
    
}

- (void)dismissVC {
    
    NSLog(@"keyboardHide!");
    if(![self.textView.text isEqualToString:@""]){
        
        if(self.recurring == nil)
        {
            self.expense.notes = self.textView.text;
            NSLog(@"notes expense");
        }
        else
        {
            self.recurring.notes = self.textView.text;
            NSLog(@"notes recurring");
        }
        NSLog(@"note saved");
    }
    else {
        
        NSLog(@"not saved");
    }
    
    NSLog(@"%@", self.textView.text);
    [self dismissModalViewControllerAnimated:YES];
    
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
