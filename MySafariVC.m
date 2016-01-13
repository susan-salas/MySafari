//
//  MySafariVC.m
//  MySafari
//
//  Created by Rafael Auriemo on 1/12/16.
//  Copyright © 2016 Susan Salas. All rights reserved.
//

#import "MySafariVC.h"

@interface MySafariVC () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rewindButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextPageButton;
@property (nonatomic) CGFloat pointNow;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;


@end

@implementation MySafariVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    
    [self.textField setReturnKeyType:UIReturnKeyGo];
    [self checkForRewindAndForward];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadURL: (NSString *) url{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField.text hasPrefix:@"http://"]) {
        [self loadURL:textField.text];
    }else{
        NSString *string = [NSString stringWithFormat:@"https://%@", textField.text];
        [self loadURL:string];
    }
    
    return YES;

}

- (void) webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];

}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
    [self checkForRewindAndForward];
    self.textField.text = [[self.webView.request URL] absoluteString];
     self.navBar.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
}

- (IBAction)stopNavigation:(UIBarButtonItem *)sender {
    [self.webView stopLoading];
}

- (IBAction)previousPage:(UIBarButtonItem *)sender {
   
    [self.webView goBack];

}

- (IBAction)nextPage:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

-(void) checkForRewindAndForward {
    if ([self.webView canGoBack]) {
        [self.rewindButton setTintColor:[UIColor blueColor]];
    }else{
        [self.rewindButton setTintColor:[UIColor grayColor]];
    }
    if ([self.webView canGoForward]) {
        [self.nextPageButton setTintColor:[UIColor blueColor]];
    }else{
        [self.nextPageButton setTintColor:[UIColor grayColor]];
    }
}

- (IBAction)comingSoon:(UIBarButtonItem *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Coming Soon" message:@"stay tuned for things to come!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alertView show];
}

- (IBAction)clearUrlBar:(UIButton *)sender {
    self.textField.text = @"";
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.pointNow > scrollView.contentOffset.y)
    {
        //scroll down
        self.textField.alpha = 0;
    }
    else if (self.pointNow < scrollView.contentOffset.y)
    {
        //scroll up
        self.textField.alpha = 1;
    }
    
    self.pointNow = scrollView.contentOffset.y;
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
