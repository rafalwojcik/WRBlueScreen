#import <Foundation/Foundation.h>

@interface WRBlueScreen : UIWindow

+ (instancetype)sharedWindow;
- (void)showErrorMessage:(NSString *)errorMessage;
- (void)showError:(NSError *)error;

@end
