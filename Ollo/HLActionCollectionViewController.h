//
//  HLActionCollectionViewController.h
//  Hey Listen
//
//  Created by Nathan Lambson on 6/23/14.
//  Copyright (c) 2014 instructure. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLActionCollectionViewController : UICollectionViewController

@property (nonatomic) NSUInteger tileSize;
@property (nonatomic) NSUInteger tileBorder;
@property (nonatomic) NSMutableArray *actions;
@property (nonatomic) NSUInteger cellType;

@end