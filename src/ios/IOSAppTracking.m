#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <Cordova/CDVPluginResult.h>
#import "IOSAppTracking.h"

@implementation IOSAppTracking

- (NSString*)requestPermission:(CDVInvokedUrlCommand*)command
{
    __block NSString* resultString = @"";
    NSLog(@"[IOSAppTracking] Request Permission called!");

    if (@available(iOS 14, *)) {
        NSLog(@"[IOSAppTracking] iOS 14 detected!");
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            NSLog(@"[IOSAppTracking] depois do request");
//
//             switch (status) {
//                 case ATTrackingManagerAuthorizationStatusAuthorized:
//                     NSLog(@"Authorized");
//                     resultString = @"authorized";
//                     break;
//
//                 case ATTrackingManagerAuthorizationStatusNotDetermined:
//                     NSLog(@"not-determined");
//                     resultString = @"not-determined";
//                     break;
//
//                 case ATTrackingManagerAuthorizationStatusRestricted:
//                     NSLog(@"restricted");
//                     resultString = @"restricted";
//                     break;
//
//                 case ATTrackingManagerAuthorizationStatusDenied:
//                     NSLog(@"denied");
//                     resultString = @"denied";
//                     break;
//
//                 default:
//                     NSLog(@"unknown");
//                     resultString = @"unknown";
//                     break;
//             }
//
//             NSLog(@"[IOSAppTracking] permission status: %@", resultString);
        }];
    } else {
        NSLog(@"[IOSAppTracking] iOS 14 not detected!");
    }

    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultString];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
