#import <UIKit/UIKit.h>

@interface WRBlueScreenView : UIView

+ (instancetype)fromNibFile;
- (void)showErrorMessage:(NSString *)errorMessage;

@end
