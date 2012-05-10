//
//  PhotoShootModeController.h
//  FoodRecord
//
//  Created by Tim Chen on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoShootModeController : UIViewController<UIImagePickerControllerDelegate>
{
    
    
}

- (IBAction)fromAlbum:(id)sender;

- (IBAction)directShoot:(id)sender;

- (IBAction)cancel:(id)sender;


- (void) back;

@property (weak, nonatomic) IBOutlet UIButton *btChooseFromAlbum;
@property (weak, nonatomic) IBOutlet UIButton *btDirectShoot;

@end
