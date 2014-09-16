//
//  ZBarCDVPlugin.h
//  Planstery
//
//  Created by Timofey Tatarinov on 07.01.14.
//
//

#import <Cordova/CDVPlugin.h>

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
