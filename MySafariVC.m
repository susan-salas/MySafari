//
//  MySafariVC.m
//  MySafari
//
//  Created by Rafael Auriemo on 1/12/16.
//  Copyright © 2016 Susan Salas. All rights reserved.
//

#import "MySafariVC.h"

@interface MySafariVC () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation MySafariVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    [self.textField setReturnKeyType:UIReturnKeyGo];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadURL: (NSString *) url{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [self loadURL:textField.text];
    return YES;

}

- (void) webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];

}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];

}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
