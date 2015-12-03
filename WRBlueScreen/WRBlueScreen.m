#import "WRBlueScreen.h"
#import "WRBlueScreenView.h"

@interface WRBlueScreen()

@property (nonatomic, weak) WRBlueScreenView *blueScreenView;

@end

@implementation WRBlueScreen

- (instancetype)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar;
        [self addSubview:self.blueScreenView];
    }
    return self;
}

+ (instancetype)sharedWindow {
    static WRBlueScreen *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[WRBlueScreen alloc] init];
    });
    return _sharedInstance;
}

- (void)showErrorMessage:(NSString *)errorMessage {
    [self.blueScreenView showErrorMessage:errorMessage];
    self.hidden = NO;
    [self makeKeyAndVisible];
}

- (void)showError:(NSError *)error {
    NSString *errorMessage = [NSString stringWithFormat:@"%ld : %p", (long)error.code, error];
    [self showErrorMessage:errorMessage];
}

- (WRBlueScreenView *)blueScreenView {
    if (!_blueScreenView) {
        _blueScreenView = [WRBlueScreenView fromNibFile];
        _blueScreenView.frame = self.bounds;
    }
    return _blueScreenView;
}

@end
