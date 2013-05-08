//
//  SecondViewController.h
//  shopaholist
//
//  Created by Rueben Anderson on 1/29/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemView.h"

@interface SecondViewController : UIViewController <UITableViewDelegate, sendDataToLocalView>
{
    IBOutlet UIButton *newButton;
    IBOutlet UIButton *editButton;
    IBOutlet UITableView *localTableView;
    
    NSMutableArray *localList;
}

-(IBAction) onClick:(id)sender;
@end
