//
//  HLAction.h
//  Hey Listen
//
//  Created by Nathan Lambson on 6/20/14.
//  Copyright (c) 2014 instructure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLAction : NSObject
enum {
    HLNew,
    HLMessage,
    HLLog,
    HLGroupMessage
};
typedef NSUInteger HLActionType;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;
@end
