//
//  WebViewController.m
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property UIActivityIndicatorView *spinner;

@end

@implementation WebViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = self.webView.center;
    self.spinner.hidesWhenStopped = YES;
    
    [self.view addSubview:self.spinner];
    [self.view bringSubviewToFront:self.spinner];
    
    NSURL *myURL = [NSURL URLWithString:self.url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:myURL];
    [self.webView loadRequest:urlRequest];
    
}


#pragma mark actions
- (IBAction)onBackButtonTap:(id)sender {
    [self.webView goBack];
}

- (IBAction)onForwardButtonTap:(id)sender {
    [self.webView goForward];
}

#pragma mark WebView delegates
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
}

@end
