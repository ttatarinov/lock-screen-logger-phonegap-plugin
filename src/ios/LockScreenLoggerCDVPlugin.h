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
    NSInteger screenStatus;
}
- (void) init:(CDVInvokedUrlCommand*)command;
- (void)getScreenStatus:(CDVInvokedUrlCommand*)command;

- (void)logSwitchOnEvent;
- (void)logSwitchOffEvent;

@property(retain, nonatomic) NSString* callbackId;
@property(readwrite, atomic) NSInteger screenStatus;

@end
