//
//  UITableViewCell+JSONProperty.m
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "UITableViewCell+JSONProperty.h"
#import <objc/runtime.h>

static void * JSONPropertyKey = &JSONPropertyKey;

@implementation UITableViewCell (JSONProperty)


- (NSDictionary *)jsonCellAttribute {
    return objc_getAssociatedObject(self, JSONPropertyKey);
}

- (void)setJsonCellAttribute:(NSDictionary *)jsonCellAttribute {
    objc_setAssociatedObject(self, JSONPropertyKey, jsonCellAttribute, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
