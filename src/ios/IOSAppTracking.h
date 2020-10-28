#import <Cordova/CDV.h>

@interface IOSAppTracking : CDVPlugin

- (void) requestPermission:(CDVInvokedUrlCommand*)command;

@end
