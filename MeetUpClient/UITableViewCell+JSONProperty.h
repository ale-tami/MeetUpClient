//
//  UITableViewCell+JSONProperty.h
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (JSONProperty)

@property NSDictionary *jsonCellAttribute; // Added to the pch file so I dont have to import it

@end
