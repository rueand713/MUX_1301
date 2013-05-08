//
//  FirstViewController.h
//  shopaholist
//
//  Created by Rueben Anderson on 1/29/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemView.h"
#import "SiteAView.h"
#import "SiteBView.h"
#import "SiteCView.h"

@interface FirstViewController : UIViewController <UITableViewDelegate, sendWebDataA, sendWebDataB, sendWebDataC>
{
    // IB interface objects
    IBOutlet UISegmentedControl *browsers;
    IBOutlet UIButton *editButton;
    IBOutlet UITableView *webTableView;
    
    // the actual list of data
    NSMutableArray *webList;
}

// click handler for the new and edit buttons
-(IBAction) onClick:(id)sender;

// click handler for the browser buttons
-(IBAction) onItemClick:(id)sender;

@end
