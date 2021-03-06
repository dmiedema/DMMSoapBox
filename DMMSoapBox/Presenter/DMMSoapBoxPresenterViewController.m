//
//  DMMSoapBoxPresenterViewController.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import "DMMSoapBoxPresenterViewController.h"
#import "DMMUserDefaults.h"
#import <Colours/Colours.h>
@import WebKit;

NSString * const kDMMSoapBoxPresenterWebConfiguration   = @"kDMMSoapBoxPresenterWebConfiguration";
NSString * const kDMMSoapBoxPresenterShowAcceptButton   = @"kDMMSoapBoxPresenterShowAcceptButton";
NSString * const kDMMSoapBoxPresenterAcceptButtonText   = @"kDMMSoapBoxPresenterAcceptButtonText";
NSString * const kDMMSoapBoxPresenterAcceptButtonColor  = @"kDMMSoapBoxPresenterAcceptButtonColor";
NSString * const kDMMSoapBoxPresenterDismissButtonColor = @"kDMMSoapBoxPresenterDismissButtonColor";
NSString * const kDMMSoapBoxPresenterAcceptButtonBlock  = @"kDMMSoapBoxPresenterAcceptButtonBlock";


@interface DMMSoapBoxPresenterViewController ()
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) WKWebViewConfiguration *webViewConfiguration;
@property (strong, nonatomic) UIButton *acceptButton;
@property (strong, nonatomic) UIButton *dismissButton;
@property (strong, nonatomic) NSURLRequest *urlRequest;
@end

@implementation DMMSoapBoxPresenterViewController

+ (instancetype)presentationControllerWithURL:(NSURL *)url options:(NSDictionary *)options {
    DMMSoapBoxPresenterViewController *controller = [[DMMSoapBoxPresenterViewController alloc] init];
    
    controller.announcementURL = url;
    
    if (options[kDMMSoapBoxPresenterWebConfiguration]) {
        controller.webViewConfiguration = options[kDMMSoapBoxPresenterWebConfiguration];
    }
    
//    if (options[kDMMSoapBoxPresenterShowAcceptButton]) {
    controller.showAcceptButton = [options[kDMMSoapBoxPresenterShowAcceptButton] boolValue];
//    }
    
    if (options[kDMMSoapBoxPresenterAcceptButtonText]) {
        controller.acceptButtonText = options[kDMMSoapBoxPresenterAcceptButtonText];
    }
    if (options[kDMMSoapBoxPresenterAcceptButtonColor]) {
        controller.acceptButtonColor = options[kDMMSoapBoxPresenterAcceptButtonColor];
    }
    if (options[kDMMSoapBoxPresenterDismissButtonColor]) {
        controller.dismissButtonColor = options[kDMMSoapBoxPresenterDismissButtonColor];
    }
    if (options[kDMMSoapBoxPresenterAcceptButtonBlock]) {
        controller.acceptBlock = options[kDMMSoapBoxPresenterAcceptButtonBlock];
    }
    
    return controller;

}

+ (void)presentRelativeURL:(NSString *)url withOptions:(NSDictionary *)options {
    NSString *fullURL = DMMURLForRelativePath(url);

    DMMSoapBoxPresenterViewController *controller = [self presentationControllerWithURL:[NSURL URLWithString:fullURL] options:options];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:controller animated:YES completion:nil];
}

+ (void)presentURL:(NSString *)url withOptions:(NSDictionary *)options {    
    DMMSoapBoxPresenterViewController *controller = [self presentationControllerWithURL:[NSURL URLWithString:url] options:options];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:controller animated:YES completion:nil];
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.acceptButton];
    [self.view addSubview:self.dismissButton];
    [self.view addConstraints:[self acceptButtonConstraints]];
    [self.view addConstraints:[self dismissButtonConstraints]];
    [self.view addConstraints:[self webViewContraints]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadRequest];
}

#pragma mark - Getters
- (UIButton *)acceptButton {
    if (!_acceptButton) {
        _acceptButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _acceptButton.translatesAutoresizingMaskIntoConstraints = NO;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu-conditional-omitted-operand"
        NSString *title = self.acceptButtonText ?: NSLocalizedString(@"Accept", @"Accept");
#pragma clang diagnostic pop
        [_acceptButton setTitle:title forState:UIControlStateNormal];
        _acceptButton.backgroundColor = self.acceptButtonColor;
        [_acceptButton addTarget:self action:@selector(acceptPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _acceptButton;
}
- (UIButton *)dismissButton {
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu-conditional-omitted-operand"
        NSString *title = self.acceptButtonText ?: NSLocalizedString(@"Dismiss", @"Dismiss");
#pragma clang diagnostic pop
        [_dismissButton setTitle:title forState:UIControlStateNormal];
        [_dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu-conditional-omitted-operand"
        _dismissButton.backgroundColor = self.dismissButtonColor ?: [UIColor darkGrayColor];
#pragma clang diagnostic pop
        [_dismissButton addTarget:self action:@selector(dismissPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:self.webViewConfiguration];
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _webView;
}
- (WKWebViewConfiguration *)webViewConfiguration {
    if (!_webViewConfiguration) {
        _webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        _webViewConfiguration.allowsInlineMediaPlayback = YES;
        _webViewConfiguration.mediaPlaybackRequiresUserAction = NO;
    }
    return _webViewConfiguration;
}

- (NSURLRequest *)urlRequest {
    return [NSURLRequest requestWithURL:self.announcementURL];
}

#pragma mark - Setters
- (void)setAnnouncementURL:(NSURL *)announcementURL {
    _announcementURL = announcementURL;
    [self loadRequest];
}

- (void)setAcceptButtonColor:(UIColor *)acceptButtomColor {
    _acceptButtonColor = acceptButtomColor;
    
    [self setButtonTitleColor:[_acceptButtonColor blackOrWhiteContrastingColor] button:self.acceptButton];
    
    self.acceptButton.backgroundColor = _acceptButtonColor;
}

- (void)setDismissButtonColor:(UIColor *)dismissButtomColor {
    _dismissButtonColor = dismissButtomColor;
    
    [self setButtonTitleColor:[_dismissButtonColor blackOrWhiteContrastingColor] button:self.dismissButton];
    
    self.dismissButton.backgroundColor = _dismissButtonColor;
}

- (void)setAcceptButtonText:(NSString *)acceptButtonText {
    _acceptButtonText = acceptButtonText;
    [self.acceptButton setTitle:_acceptButtonText forState:UIControlStateNormal];
}

#pragma mark Constraints
- (NSArray *)webViewContraints {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.webView.superview attribute:NSLayoutAttributeTopMargin multiplier:1 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.webView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.webView.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.acceptButton attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    return @[top, bottom, left, right];
}

- (NSArray *)acceptButtonConstraints {
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.acceptButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:(self.showAcceptButton) ? 40 : 0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.acceptButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.acceptButton.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.acceptButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.acceptButton.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.acceptButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.dismissButton attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    return @[height, bottom, left, right];
}

- (NSArray *)dismissButtonConstraints {
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.dismissButton.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.dismissButton.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.dismissButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.dismissButton.superview attribute:NSLayoutAttributeBottomMargin multiplier:1 constant:0];
    
    return @[height, bottom, left, right];
}

#pragma mark - Implementation
- (void)setButtonTitleColor:(UIColor *)color button:(UIButton *)button {
    [button setTitleColor:color forState:UIControlStateNormal];
}

- (void)loadRequest {
    [self.webView loadRequest:self.urlRequest];
}

#pragma mark - Actions
- (void)acceptPressed:(UIButton *__unused)sender {
    if (self.acceptBlock) {
        self.acceptBlock();
    } else if ([DMMUserDefaults acceptActionURL]) {
        NSURL *actionURL = [DMMUserDefaults acceptActionURL];
        [[UIApplication sharedApplication] openURL:actionURL];
    }
    
    [self sharedDismiss];
}

- (void)dismissPressed:(UIButton *__unused)sender {
    [self sharedDismiss];
}

- (void)sharedDismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        [DMMUserDefaults markLastAnnouncementAsRead];
    }];
}

@end
