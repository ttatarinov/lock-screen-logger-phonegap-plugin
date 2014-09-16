//
//  ZBarCDVPlugin.h
//  Planstery
//
//  Created by Timofey Tatarinov on 07.01.14.
//
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import "ZBarSDK.h"

@interface LockScreenLoggerCDVPlugin : CDVPlugin
{
    NSString* callbackId;
}
- (void) init:(CDVInvokedUrlCommand*)command;
- (NSString*)getLocks:(CDVInvokedUrlCommand*)command;

- (void)logSwitchOnEvent;
- (void)logSwitchOffEvent;

@property(retain, nonatomic) NSString* callbackId;

@end
