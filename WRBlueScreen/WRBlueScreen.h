#import <Foundation/Foundation.h>

@interface WRBlueScreen : UIWindow

/**
 *  Set it to false to avoid random crash of application. Default value: true
 */

@property (nonatomic, assign) BOOL shouldCrashApplication;

/**
 *  Percentage chance that show blue screen will cause crash. Default value: 70%
 */

@property (nonatomic, assign) int percentageChanceToCrash;

/**
 *  Minimum time from show blue screen to crash. Default: 2 seconds
 */

@property (nonatomic, assign) int minIntervalToCrash;

/**
 *  Maximum time from show blue screen to crash. Default: 5 seconds
 */

@property (nonatomic, assign) int maxIntervalToCrash;

/**
 *  Get instance of BlueScreen UIWindow
 *
 *  @return Instance of BlueScreen UIWindow
 */

+ (instancetype)sharedWindow;

/**
 *  Imidietly show blue screen with your error message
 *
 *  @param errorMessage Any error you want in string
 */

- (void)showErrorMessage:(NSString *)errorMessage;

/**
 *  Imidietly show blue screen with message based on NSError
 *
 *  @param error Based on this error library will generate error message in format: {error code} : {error memory address}
 */

- (void)showError:(NSError *)error;

@end
