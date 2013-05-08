//
//  SiteAView.m
//  shopaholist
//
//  Created by Rueben Anderson on 1/31/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "SiteAView.h"

typedef enum {
    NEWBUTTON = 0,
    BACKBUTTON
} toolBarButtons;

@implementation SiteAView

@synthesize webDataADelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // close the keyboard and load the web address
    [textField resignFirstResponder];
    [self connectionCenter:addressField.text];
    
    return true;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    // close the keyboard and clear the textfield
    textField.text = @"";
    [textField resignFirstResponder];
    
    return true;
}

-(IBAction)onClick:(id)sender
{
    UIBarButtonItem *btn = (UIBarButtonItem*)sender;
    
    if (btn && btn.tag == NEWBUTTON)
    {
        AddItemView *addItemView = [[AddItemView alloc] initWithNibName:@"AddItemView" bundle:nil];
        
        if (addItemView)
        {
            addItemView.labelTitle = @"Add New Web Item";
            addItemView.locTitleLabel = @"Site Name";
            addItemView.listMode = 0;
            addItemView.webDelegate = self;
            
            // present the add item view
            [self presentViewController:addItemView animated:YES completion:nil];
        }
    }
    else if (btn && btn.tag == BACKBUTTON)
    {
        // close the webview for the selected tab
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)connectionCenter:(NSString*)stringURL
{
    if (![stringURL isEqualToString:@"http://" ] && ![stringURL isEqualToString:@"https://"])
    {
        if (![stringURL isEqualToString:@""])
        {
            NSURL *webURL = [[NSURL alloc] initWithString:stringURL];
            
            if (webURL)
            {
                NSURLRequest *webRequest = [[NSURLRequest alloc] initWithURL:webURL];
                
                if (webRequest)
                {
                    webBrowser.scalesPageToFit = true;
                    [webBrowser loadRequest:webRequest];
                }
            }
 
        }
    }
}

// custom delegate for handling the adding of new items to the list
- (void) dataCart:(NSString*)item storeOrLocation:(NSString*)locName itemPrice:(NSString*)price itemQty:(NSString*)quantity
{
    // create an object of the item data for storing into the list object
    NSArray *object = [[NSArray alloc] initWithObjects:item, locName, quantity, price, nil];
    
    if (object)
    {
        // send the item object to the weblist
        [webDataADelegate sendArrayData:object];
    }
    
}


@end
