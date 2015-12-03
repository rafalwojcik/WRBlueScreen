#import <UIKit/UIKit.h>

@interface WRBlueScreenView : UIView

/**
 *  Initialize WRBlueScreenView from xib file.
 *
 *  @return Instance of WRBlueScreenView
 */

+ (instancetype)fromNibFile;

/**
 *  Prepare view with given error message
 *
 *  @param errorMessage Error message in NSString
 */

- (void)showErrorMessage:(NSString *)errorMessage;

@end
