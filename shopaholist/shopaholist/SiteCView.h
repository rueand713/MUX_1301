//
//  SiteCView.h
//  shopaholist
//
//  Created by Rueben Anderson on 1/31/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemView.h"

@protocol sendWebDataC <NSObject>

@required
-(void) sendArrayData:(NSArray*)object;

@end

@interface SiteCView : UIViewController <UIWebViewDelegate, UITextFieldDelegate, sendDataToWebView>
{
    NSString *urlString;
    
    // IB Interface objects
    IBOutlet UITextField *addressField;
    IBOutlet UIBarButtonItem *backButton;
    IBOutlet UIBarButtonItem *newButton;
    IBOutlet UIWebView *webBrowser;
    
    id<sendWebDataC> webDataCDelegate;
}

-(IBAction)onClick:(id)sender;

-(void)connectionCenter:(NSString*)stringURL;

@property (strong) id<sendWebDataC> webDataCDelegate;
@end
