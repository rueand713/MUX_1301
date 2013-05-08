//
//  FirstViewController.m
//  shopaholist
//
//  Created by Rueben Anderson on 1/29/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "FirstViewController.h"

typedef enum {
    WEBBUTTONS = 0,
    NEW,
    EDIT
} buttonTags;

typedef enum {
    TABA = 0,
    TABB,
    TABC
} browserTabs;

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Web List", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    // create the dummy data
    NSArray *ipod = [[NSArray alloc] initWithObjects:@"iPod Touch", @"www.Apple.com", @"2", @"299.99", nil];
    NSArray *tablet = [[NSArray alloc] initWithObjects:@"MS Surface", @"www.Ebay.com", @"1", @"499.99", nil];
    NSArray *gameconsole = [[NSArray alloc] initWithObjects:@"Xbox Bundle", @"www.toysrus.com", @"1", @"349.99", nil];
    
    // init with some dummy data
    webList = [[NSMutableArray alloc] initWithObjects:ipod, tablet, gameconsole, nil];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    // set the frame size of the segmented control to a custom height
    //browsers.frame = CGRectMake(0.0f, 0.0f, browsers.frame.size.width, 44.0f);
    
    // check whether to hide or show the edit button
    if ([webList count] > 0)
    {
        // if there are items present show the edit button
        editButton.hidden = NO;
    }
    else if ([webList count] < 1)
    {
        // if there are no items in the list hide the edit button
        editButton.hidden = YES;
    }
    
    [super viewWillAppear:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if (btn)
    {
        if (btn.tag == EDIT)
        {
            if (webTableView.editing)
            {
                // if the edit button is clicked and the table is in editing mode
                // take the table out of editing mode
                webTableView.editing = false;
            }
            else if (!webTableView.editing)
            {
                // if the edit button is clicked and the table is not in editing mode
                // take the table into editing mode
                webTableView.editing = true;
            }
        }
        else if (btn.tag == NEW)
        {
            // REMOVED
        }
    }
    
}

-(IBAction) onItemClick:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    
    if (seg)
    {
        if (seg.selectedSegmentIndex == TABA)
        {
            SiteAView *siteA = [[SiteAView alloc] initWithNibName:@"SiteAView" bundle:nil];
            
            if (siteA)
            {
                // set the recieving view for the delegate and call the web view
                siteA.webDataADelegate = self;
                [self presentViewController:siteA animated:YES completion:nil];
            }
        }
        else if (seg.selectedSegmentIndex == TABB)
        {
            SiteBView *siteB = [[SiteBView alloc] initWithNibName:@"SiteBView" bundle:nil];
            
            if (siteB)
            {
                // set the recieving view for the delegate and call the web view
                siteB.webDataBDelegate = self;
                [self presentViewController:siteB animated:YES completion:nil];
            }
        }
        else if (seg.selectedSegmentIndex == TABC)
        {
            SiteCView *siteC = [[SiteCView alloc] initWithNibName:@"SiteCView" bundle:nil];
            
            if (siteC)
            {
                // set the recieving view for the delegate and call the web view
                siteC.webDataCDelegate = self;
                [self presentViewController:siteC animated:YES completion:nil];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of items in the web list
    return [webList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    
    // query for a previously created cell
    UITableViewCell *cell = [webTableView dequeueReusableCellWithIdentifier:cellId];
    
    // no cell found intialize with new cell
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // set the cell label text
    cell.textLabel.text = [[webList objectAtIndex: indexPath.row] objectAtIndex:0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddItemView *viewItemDrilldown = [[AddItemView alloc] initWithNibName:@"AddItemView" bundle:nil];
    
    if (viewItemDrilldown)
    {
        viewItemDrilldown.labelTitle = @"View Item Details";
        viewItemDrilldown.locTitleLabel = @"Site Name";
        viewItemDrilldown.listMode = 2;
        viewItemDrilldown.currentItemData = [webList objectAtIndex:indexPath.row];
        
        [self presentViewController:viewItemDrilldown animated:YES completion:nil];
    }
}

// custom protocol for receiving the array of data from the webview
-(void) sendArrayData:(NSArray*)object
{
    if (object)
    {
        int items = [webList count] - 1;
        
        //if the new object is created properly, insert the new item object into the list of items
        if (items > 0)
        {
            [webList insertObject:object atIndex:items];
        }
        else
        {
            [webList insertObject:object atIndex:0];
        }
    }
    
    // refresh the tableview
        [webTableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // remove the row from the business name, city and location arrays
        [webList removeObjectAtIndex: indexPath.row];
        
        // remove the cell row from the tableView
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
    }
}


@end
