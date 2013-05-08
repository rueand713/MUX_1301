//
//  AddItemView.h
//  shopaholist
//
//  Created by Rueben Anderson on 1/30/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

// protocol for setting data to web view
@protocol sendDataToWebView <NSObject>

@required
- (void) dataCart:(NSString*)item storeOrLocation:(NSString*)locName itemPrice:(NSString*)price itemQty:(NSString*)quantity;

@end

// protocal for setting data to local view
@protocol sendDataToLocalView <NSObject>

@required
- (void) dataCart:(NSString*)item storeOrLocation:(NSString*)locName itemPrice:(NSString*)price itemQty:(NSString*)quantity;

@end

@interface AddItemView : UIViewController <UITextFieldDelegate>
{
    // IB Interface objects
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *cancelButton;
    IBOutlet UITextField *itemQuantityData;
    IBOutlet UITextField *itemPriceData;
    IBOutlet UITextField *storeNameData;
    IBOutlet UITextField *itemNameData;
    IBOutlet UILabel *storeSiteLabel;
    
    NSString *locTitleLabel;
    UIColor *colorReferencer;
    
    // track the current list mode (webmode 1/ localmode 0) as integer values
    NSInteger listMode;
    
    // data delegates
    id<sendDataToWebView> webDelegate;
    id<sendDataToLocalView> localDelegate;
    
    // will hold the passed in item data for viewing
    NSMutableArray *currentItemData;
    
}

-(IBAction)onClick:(id)sender;

@property NSString *labelTitle;
@property NSString *locTitleLabel;
@property NSInteger listMode;
@property (strong) id<sendDataToWebView> webDelegate;
@property (strong) id<sendDataToLocalView> localDelegate;
@property NSMutableArray *currentItemData;
@end
