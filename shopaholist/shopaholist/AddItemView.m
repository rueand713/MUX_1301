//
//  AddItemView.m
//  shopaholist
//
//  Created by Rueben Anderson on 1/30/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "AddItemView.h"

typedef enum {
    DONE = 0,
    CANCEL
} addItemButtons;

typedef enum {
    WEBLIST = 0,
    LOCALLIST,
    VIEWING
} listModeType;


@implementation AddItemView

@synthesize labelTitle, webDelegate, localDelegate, listMode, currentItemData, locTitleLabel;

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
    // set the label text
    titleLabel.text = labelTitle;
    storeSiteLabel.text = locTitleLabel;
    
    //set the default color
    colorReferencer = itemNameData.backgroundColor;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    if (listMode == VIEWING)
    {
        // set the textfields to the data in the object being viewed
        itemNameData.text = [currentItemData objectAtIndex:0];
        storeNameData.text = [currentItemData objectAtIndex:1];
        itemQuantityData.text = [currentItemData objectAtIndex:2];
        itemPriceData.text = [currentItemData objectAtIndex:3];
        
        // hide the cancel button in viewing mode
        cancelButton.hidden = YES;
    }
    else
    {
        // reset all of the textfield values to defaults
        itemNameData.text = @"";
        itemPriceData.text = @"0.00";
        itemQuantityData.text = @"0";
        storeNameData.text = @"";
        
        // unhide the cancel button when not in viewing mode
        cancelButton.hidden = NO;
    }
    
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    NSString *itemName = itemNameData.text;
    NSString *storeSiteName = storeNameData.text;
    NSString *itemPrice = itemPriceData.text;
    NSString *itemQty = itemQuantityData.text;
    
    
    if (btn)
    {
        if (btn.tag == DONE)
        {
            if (listMode == LOCALLIST && ![itemName isEqualToString:@""])
            {
                [localDelegate dataCart:itemName storeOrLocation:storeSiteName itemPrice:itemPrice itemQty:itemQty];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else if (listMode == WEBLIST && ![itemName isEqualToString:@""])
            {
                [webDelegate dataCart:itemName storeOrLocation:storeSiteName itemPrice:itemPrice itemQty:itemQty];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else if (listMode == VIEWING)
            {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else if (listMode == LOCALLIST || listMode == WEBLIST)
            {
                if ([itemName isEqualToString:@""])
                {
                    // set the bgcolor to red to signal a required field
                    itemNameData.backgroundColor = [UIColor redColor];
                }
            }
        }
        else if (btn.tag == CANCEL)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // close the keyboard
    [textField resignFirstResponder];
    
    return true;
}

@end
