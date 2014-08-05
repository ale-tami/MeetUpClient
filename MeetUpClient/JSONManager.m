//
//  JSONManager.m
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "JSONManager.h"

@implementation JSONManager

- (void)makeRequestWithCriteria:(NSString *)criteria
{
    __block NSDictionary * responseJSON = [[NSDictionary alloc] init]; //why I have to do this 
    
//    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=20652d28384d49b1932544980405817"];
    
    NSString *stringURL = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=20652d28384d49b1932544980405817", criteria];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [self.delegate responseWithJSON:responseJSON];

    }];
    
}

- (void) responseWithJSON:(NSDictionary *) json
{
    
}

@end
