//
//  HLActionCollectionViewController.m
//  Hey Listen
//
//  Created by Nathan Lambson on 6/23/14.
//  Copyright (c) 2014 instructure. All rights reserved.
//

#define TILE_PADDING 35

#import "HLActionCollectionViewController.h"
#import "HLActionCollectionViewCell.h"
#import "HLAction.h"
#import <M13ContextMenu/M13ContextMenu.h>
#import <M13ContextMenu/M13ContextMenuItemIOS7.h>

@interface HLActionCollectionViewController () <M13ContextMenuDelegate>

@end

@implementation HLActionCollectionViewController
{
    M13ContextMenu *menu;
    UILongPressGestureRecognizer *longPress;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tileSize = 96;
    self.tileBorder = 10;
    
    if (self.actions != nil) {
        return;
    }
    
    NSArray * paths = [NSBundle pathsForResourcesOfType: @"png" inDirectory: [[NSBundle mainBundle] bundlePath]];
    self.actions = [[NSMutableArray alloc] init];
    
    for (NSString * path in paths) {
        if ([[path lastPathComponent] hasPrefix: @"AQ"]) {
            continue;
        }
        
        HLAction *action = [HLAction new];
        action.title = [path lastPathComponent];
        action.image = [UIImage imageNamed:action.title];
        [self.actions addObject:action];
    }
    
    HLAction *action = [HLAction new];
    action.title = @"New Action";
    action.image = [UIImage imageNamed:@"icon_plus"];
    [self.actions addObject:action];
    
    [self.collectionView reloadData];
    
    //Create M13 menu items
    M13ContextMenuItemIOS7 *bookmarkItem = [[M13ContextMenuItemIOS7 alloc] initWithUnselectedIcon:[UIImage imageNamed:@"BookmarkIcon"] selectedIcon:[UIImage imageNamed:@"BookmarkIconSelected"]];
    M13ContextMenuItemIOS7 *uploadItem = [[M13ContextMenuItemIOS7 alloc] initWithUnselectedIcon:[UIImage imageNamed:@"UploadIcon"] selectedIcon:[UIImage imageNamed:@"UploadIconSelected"]];
    M13ContextMenuItemIOS7 *trashIcon = [[M13ContextMenuItemIOS7 alloc] initWithUnselectedIcon:[UIImage imageNamed:@"TrashIcon"] selectedIcon:[UIImage imageNamed:@"TrashIconSelected"]];
	//Create the menu
    menu = [[M13ContextMenu alloc] initWithMenuItems:@[bookmarkItem, uploadItem, trashIcon]];
    menu.delegate = self;
    
    //Create the gesture recognizer
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:menu action:@selector(showMenuUponActivationOfGetsure:)];
    [self.collectionView addGestureRecognizer:longPress];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
//    return self.actions.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HLActionCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ActionCell" forIndexPath:indexPath];
    
    int row = [indexPath row];
    
    myCell.imageView.image = [self.actions[row] image];
    
    return myCell;
}

#pragma mark -
#pragma mark M13ContextMenuDelegate

- (BOOL)shouldShowContextMenu:(M13ContextMenu *)contextMenu atPoint:(CGPoint)point
{
    //If there is a cell, then the menu should activate.
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:point];
    UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    return cell != nil;
}

- (void)contextMenu:(M13ContextMenu *)contextMenu atPoint:(CGPoint)point didSelectItemAtIndex:(NSInteger)index
{
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    NSMutableString *string = [@"You selected the " mutableCopy];
    if (index == 0) {
        [string appendString:@"Bookmark Action."];
    } else if (index == 1) {
        [string appendString:@"Upload Action."];
    } else {
        [string appendString:@"Trash Action."];
    }
    
    [string appendFormat:@" For cell at index: %li.", (long)indexPath.row];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Action Selected" message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end