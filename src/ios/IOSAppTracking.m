#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <Cordova/CDVPluginResult.h>
#import "IOSAppTracking.h"

@implementation IOSAppTracking

- (NSString*)requestPermission:(CDVInvokedUrlCommand*)command
{
    __block NSMutableString* res = [[NSMutableString alloc] initWithString:@"none"];
    NSLog(@"[IOSAppTracking] Request Permission called!");

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    if (@available(iOS 14, *)) {
        NSLog(@"[IOSAppTracking] iOS 14 detected!");

        if ([ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
            NSLog(@"[IOSAppTracking] Asking permission...");
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                NSLog(@"[IOSAppTracking] permission status: %lu", status);

                switch (status) {
                    case ATTrackingManagerAuthorizationStatusAuthorized:
                        [res setString:@"authorized"];
                        break;

                    case ATTrackingManagerAuthorizationStatusNotDetermined:
                        [res setString:@"not-determined"];
                        break;

                    case ATTrackingManagerAuthorizationStatusRestricted:
                        [res setString:@"restricted"];
                        break;

                    case ATTrackingManagerAuthorizationStatusDenied:
                        [res setString:@"denied"];
                        break;

                    default:
                        [res setString:@"unknown"];
                        break;
                }
                dispatch_semaphore_signal(semaphore);
                NSLog(@"[IOSAppTracking] permission status result: %@", res);
            }];
        } else {
            NSLog(@"[IOSAppTracking] Dialog was already shown, skipping ...");
            dispatch_semaphore_signal(semaphore);
        }
    } else {
        NSLog(@"[IOSAppTracking] iOS 14 not detected!");
        dispatch_semaphore_signal(semaphore);
    }
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
