//
//  SpotList.m
//  FoodRecord
//
//  Created by Tim Chen on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpotList.h"
#import "AppDelegate.h"
#import "SaveLocs.h"
#import "NSData+Base64.h"
#import "showLocation.h"

@interface SpotList ()

@end

@implementation SpotList

@synthesize aryData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *buttonBack = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    self.navigationItem.leftBarButtonItem = buttonBack;
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    
    /*
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SaveLocs" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [req setEntity:entity];
    
    NSSortDescriptor *descr = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    
    NSArray *aryDescripts = [[NSArray alloc] initWithObjects:descr, nil];
    
    [req setSortDescriptors:aryDescripts];
    
    NSError *err = nil;
    
    NSMutableArray *ary = [[[appDelegate managedObjectContext] executeFetchRequest:req error:&err] mutableCopy];
    
    if (ary == nil)
    {
        //oops
        
    }
    
    self.aryData = ary;
     */
    
    [self fetchData];
    
}

- (void) fetchData
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SaveLocs" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [req setEntity:entity];
    
    NSSortDescriptor *descr = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    
    NSArray *aryDescripts = [[NSArray alloc] initWithObjects:descr, nil];
    
    [req setSortDescriptors:aryDescripts];
    
    NSError *err = nil;
    
    NSMutableArray *ary = [[[appDelegate managedObjectContext] executeFetchRequest:req error:&err] mutableCopy];
    
    self.aryData = ary;

    
}

- (void) back
{
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
    if ((interfaceOrientation == UIInterfaceOrientationPortrait) ||
        (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown))
    {
        return YES;
    }
    else {
        return NO;
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [aryData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ((cell == nil) && (aryData != nil))
    {        
        cell = [[UITableViewCell alloc] init];
     
        SaveLocs *loc = (SaveLocs *)[aryData objectAtIndex:indexPath.row];
        
        if (loc)
        {
            cell.textLabel.text = loc.name;
            
            NSData *picData = [NSData dataFromBase64String:loc.picofbase64];
            
            UIImage *img = [UIImage imageWithData:picData];
            
            cell.imageView.image = img;
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        SaveLocs *loc = [aryData objectAtIndex:indexPath.row];
        
        if (loc)
        {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            //delete database 
            [[appDelegate managedObjectContext] deleteObject:loc];
            
            
            NSError *error = nil;
            
            if (![[appDelegate managedObjectContext] save:&error]){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                
                [alert show];
                
                return;
            }
            
            
            //[appDelegate saveContext];
            
            //delete array 
            
            NSLog(NSStringFromClass([aryData class]));
            
            [aryData removeObjectAtIndex:indexPath.row];
            
            //update UI
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
             
            
            
        }
        
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    showLocation *loc = [[showLocation alloc] init];
    
    SaveLocs *save = (SaveLocs *)[aryData objectAtIndex:indexPath.row];
    
    if (save)
    {
        loc.lat = [save.lat doubleValue];
        
        loc.lon = [save.lon doubleValue];
        
        loc.strName = save.name;
        
        loc.strText = save.note;
        
        //image 
        NSData *imgData = [NSData dataFromBase64String:save.picofbase64];
        
        UIImage *img = [UIImage imageWithData:imgData];
        
        loc.img = img;
        
        loc.bPreset = YES;
        
        loc.saveData = save;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loc];
        
        //[self presentModalViewController:nav animated:YES];
        
        [self presentViewController:nav animated:YES completion:^{
            [tableView reloadData];
            
        }];
        
               

    }
    
}

@end
