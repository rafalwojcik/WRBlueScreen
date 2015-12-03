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
        self.shouldCrashApplication = true;
        self.percentageChanceToCrash = 70;
        self.minIntervalToCrash = 2;
        self.maxIntervalToCrash = 5;
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

- (WRBlueScreenView *)blueScreenView {
    if (!_blueScreenView) {
        _blueScreenView = [WRBlueScreenView fromNibFile];
        _blueScreenView.frame = self.bounds;
    }
    return _blueScreenView;
}

- (void)showErrorMessage:(NSString *)errorMessage {
    [self hideKeybaord];
    [self.blueScreenView showErrorMessage:errorMessage];
    self.hidden = NO;
    [self makeKeyAndVisible];
    if (self.shouldCrashApplication) {
        [self randomCrashApp];
    }
}

- (void)showError:(NSError *)error {
    NSString *errorMessage = [NSString stringWithFormat:@"%ld : %p", (long)error.code, error];
    [self showErrorMessage:errorMessage];
}

- (void)hideKeybaord {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        [window endEditing:YES];
    }
    [UIView commitAnimations];
}

- (void)randomCrashApp {
    NSInteger randomNumber = 1 + arc4random() % 100;
    if (randomNumber <= self.percentageChanceToCrash) {
        NSInteger randomCrashTime = 0;
        if (self.minIntervalToCrash >= self.maxIntervalToCrash) {
            randomCrashTime = self.minIntervalToCrash;
        } else {
            randomCrashTime = self.minIntervalToCrash + arc4random() % (self.maxIntervalToCrash - self.minIntervalToCrash + 1);
        }
        [NSTimer scheduledTimerWithTimeInterval:randomCrashTime target:self selector:@selector(crashApp) userInfo:nil repeats:FALSE];
    }
}

- (void)crashApp {
    NSLog(@"BSOD");
    [@[] objectAtIndex:666];
}

@end
