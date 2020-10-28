#import <Cordova/CDV.h>

@interface IOSAppTracking : CDVPlugin

- (NSString*) requestPermission:(CDVInvokedUrlCommand*)command;

@end
