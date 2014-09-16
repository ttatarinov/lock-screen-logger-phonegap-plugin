//
//  ZBarCDVPlugin.m
//  Planstery
//
//  Created by Timofey Tatarinov on 07.01.14.
//
//

#import "LockScreenLoggerCDVPlugin.h"

@implementation LockScreenLoggerCDVPlugin

#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]

int notifyToken;
UIBackgroundTaskIdentifier bgTask;

@synthesize callbackId;

- (void)logSwitchOnEvent {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    // update gost history
    NSString *pathToFile = [documentsPath stringByAppendingPathComponent:@"switchOnEvents"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:pathToFile];
    NSMutableArray *switchesArr = nil;
    if (fileExists) {
        switchesArr = [[NSMutableArray alloc] initWithContentsOfFile:pathToFile];
    } else {
        switchesArr = [NSMutableArray new];
    }
    NSString* timestamp = TimeStamp;
    [switchesArr addObject:timestamp];
    // TODO: move to constant
    [switchesArr writeToFile:pathToFile atomically:YES];
    
}

- (void)logSwitchOffEvent {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    // update gost history
    NSString *pathToFile = [documentsPath stringByAppendingPathComponent:@"switchOffEvents"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:pathToFile];
    NSMutableArray *switchesArr = nil;
    if (fileExists) {
        switchesArr = [[NSMutableArray alloc] initWithContentsOfFile:pathToFile];
    } else {
        switchesArr = [NSMutableArray new];
    }
    NSString* timestamp = TimeStamp;
    [switchesArr addObject:timestamp];
    // TODO: move to constant
    [switchesArr writeToFile:pathToFile atomically:YES];
}


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
                                     [self logSwitchOffEvent];
                                 } else {
                                     dispatch_sync(dispatch_get_main_queue(), ^{
                                         [self logSwitchOnEvent];

                                         NSString *jsStatement = [NSString stringWithFormat:@"LockScreenLoggerCDVPlugin.onLock('YES');"];
                                         [self.webView  stringByEvaluatingJavaScriptFromString:jsStatement];
                                     });
                                 }
                                 NSLog(@"Cur state is %llu", state);
                             });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            sleep(100);
        }
    });
}

- (void)getLocks:(CDVInvokedUrlCommand *)command
{
   
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"123"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
    
    self.callbackId = command.callbackId;
}

@end
