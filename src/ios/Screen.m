//
//  Screen.m
//  Citronium
//
//  Created by Timofey Tatarinov on 16.09.14.
//
//

#import "Screen.h"
#import <notify.h>

@implementation Screen

#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]

int notifyToken;
UIBackgroundTaskIdentifier bgTask;

@synthesize callbackId;
@synthesize screenStatus;

- (void) init:(CDVInvokedUrlCommand*)command {
    // send to web view
    
    UIApplication*    app = [UIApplication sharedApplication];
    dispatch_block_t expirationHandler;
    expirationHandler = ^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
        
        
        bgTask = [app beginBackgroundTaskWithExpirationHandler:expirationHandler];
    };
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:expirationHandler];
    
    notify_register_dispatch("com.apple.springboard.lockstate",
                             &notifyToken,
                             dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0l),
                             ^(int info) {
                                 
                                 uint64_t state;
                                 notify_get_state(notifyToken, &state);
                                 if (state == 1) {
                                     dispatch_sync(dispatch_get_main_queue(), ^{
                                         NSString *jsStatement = [NSString stringWithFormat:@"Screen.screenoff(%.0f);", [[NSDate date] timeIntervalSince1970] * 1000];
                                         [self.webView  stringByEvaluatingJavaScriptFromString:jsStatement];
                                     });
                                 } else {
                                     dispatch_sync(dispatch_get_main_queue(), ^{
                                         NSString *jsStatement = [NSString stringWithFormat:@"Screen.screenon(%.0f);", [[NSDate date] timeIntervalSince1970] * 1000];
                                         [self.webView  stringByEvaluatingJavaScriptFromString:jsStatement];
                                     });
                                 }
                                 NSLog(@"Cur state is %llu", state);
                                 self.screenStatus = state;
                             });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            sleep(100);
        }
    });
}

- (void)getScreenStatus:(CDVInvokedUrlCommand *)command
{
    
    self.callbackId = command.callbackId;
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"%d", self.screenStatus]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
    
    
}

@end
