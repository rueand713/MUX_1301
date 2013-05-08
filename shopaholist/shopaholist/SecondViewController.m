//
//  SecondViewController.m
//  shopaholist
//
//  Created by Rueben Anderson on 1/29/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "SecondViewController.h"
#import "AddItemView.h"

typedef enum {
    NEW = 0,
    EDIT
} buttonDefs;


@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Local List", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    // create the dummy data
    NSArray *watch = [[NSArray alloc] initWithObjects:@"Gold Watch", @"Kay Jewelers", @"1", @"350.00", nil];
    NSArray *shoes = [[NSArray alloc] initWithObjects:@"Nike Crosstrainers", @"Foot Action", @"1", @"150.00", nil];
    NSArray *ram = [[NSArray alloc] initWithObjects:@"8Gb Ram", @"Fry's Electronics", @"2", @"49.99", nil];
    
    // init with some dummy data
    localList = [[NSMutableArray alloc] initWithObjects:watch, shoes, ram, nil];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    // check whether to hide or show the edit button
    if ([localList count] > 0)
    {
        // if there are items present show the edit button
        editButton.hidden = NO;
    }
    else if ([localList count] < 1)
    {
        // if there are no items in the list hide the edit button
        editButton.hidden = YES;
    }
    
    [super viewDidAppear:YES];
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
        if (btn.tag == NEW)
        {
            AddItemView *addItemView = [[AddItemView alloc] initWithNibName:@"AddItemView" bundle:nil];
            
            if (addItemView)
            {
                addItemView.labelTitle = @"Add New Local Item";
                addItemView.locTitleLabel = @"Store Name";
                addItemView.listMode = 1;
                addItemView.localDelegate = self;
                
                // present the add item view
                [self presentViewController:addItemView animated:YES completion:nil];
            }
        }
        else if (btn.tag == EDIT)
        {
            if (localTableView.editing)
            {
                // if the edit button is clicked and the table is in editing mode
                // take the table out of editing mode
                localTableView.editing = false;
            }
            else if (!localTableView.editing)
            {
                // if the edit button is clicked and the table is not in editing mode
                // take the table into editing mode
                localTableView.editing = true;
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of items in the local list
    return [localList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    
    // query for a previously created cell
    UITableViewCell *cell = [localTableView dequeueReusableCellWithIdentifier:cellId];
    
    // no cell found intialize with new cell
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // set the cell label text
    cell.textLabel.text = [[localList objectAtIndex: indexPath.row] objectAtIndex:0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddItemView *viewItemDrilldown = [[AddItemView alloc] initWithNibName:@"AddItemView" bundle:nil];
    
    if (viewItemDrilldown)
    {
        viewItemDrilldown.labelTitle = @"View Item Details";
        viewItemDrilldown.locTitleLabel = @"Store Name";
        viewItemDrilldown.listMode = 2;
        viewItemDrilldown.currentItemData = [localList objectAtIndex:indexPath.row];
        
        [self presentViewController:viewItemDrilldown animated:YES completion:nil];
    }
}

// custom delegate for handling the adding of new items to the list
- (void) dataCart:(NSString*)item storeOrLocation:(NSString*)locName itemPrice:(NSString*)price itemQty:(NSString*)quantity
{
    // create an object of the item data for storing into the list object
    NSArray *object = [[NSArray alloc] initWithObjects:item, locName, quantity, price, nil];
    
    if (object)
    {
        int items = [localList count];
        
        // if the new object is created properly, insert the new item object into the list of items
        if (items > 0)
        {
            [localList insertObject:object atIndex:items];
        }
        else
        {
            [localList insertObject:object atIndex:0];
        }
    }

    // refresh the tableview
    [localTableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // remove the row from the business name, city and location arrays
        [localList removeObjectAtIndex: indexPath.row];
        
        // remove the cell row from the tableView
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:true];
    }
}


@end
