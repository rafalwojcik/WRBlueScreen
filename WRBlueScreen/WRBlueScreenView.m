@import CoreText;
#import "WRBlueScreenView.h"

static NSString * const kBundle = @"WRBlueScreenBundle";
static NSString * const kDOSFont = @"PerfectDOSVGA437Win";
static NSString * const kDOSFontFileName = @"DOSFont";

@interface WRBlueScreenView()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *blinkCursor;

@end

@implementation WRBlueScreenView

+ (NSBundle *)resourcesBundle {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:kBundle ofType:@"bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}

+ (instancetype)fromNibFile {
    WRBlueScreenView *view = (WRBlueScreenView *)[[[self.class resourcesBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] firstObject];
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self dynamicallyLoadFontNamed:kDOSFontFileName];
    [self styleAllLabels];
}

- (void)styleAllLabels {
    for (UILabel *label in self.allLabels) {
        UIFont *dosFont = [UIFont fontWithName:kDOSFont size:label.font.pointSize];
        label.font = dosFont;
    }
    [self animateBlinkLabel];
}

- (void)animateBlinkLabel {
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(changeAlphaOfBlinkCursor) userInfo:nil repeats:YES];
}

- (void)changeAlphaOfBlinkCursor {
    self.blinkCursor.alpha = self.blinkCursor.alpha == 0.0f ? 1.0f : 0.0f;
}

- (void)showErrorMessage:(NSString *)errorMessage {
    self.errorLabel.text = [NSString stringWithFormat:@"Error: %@", errorMessage];
    [self randomCrashApp];
}

- (void)dynamicallyLoadFontNamed:(NSString *)name {
    NSURL *url = [[self.class resourcesBundle] URLForResource:kDOSFontFileName withExtension:@"ttf"];
    NSData *fontData = [NSData dataWithContentsOfURL:url];
    if (fontData) {
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
        CGFontRef font = CGFontCreateWithDataProvider(provider);
        if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CFRelease(font);
        CFRelease(provider);
    }
}

- (void)randomCrashApp {
    NSInteger randomNumber = arc4random() % 100;
    if (randomNumber > 70) {
        NSInteger randomCrashTime = 1 + arc4random() % 5;
        [NSTimer scheduledTimerWithTimeInterval:randomCrashTime target:self selector:@selector(crashApp) userInfo:nil repeats:FALSE];
    }
}

- (void)crashApp {
    NSLog(@"BSOD");
    [@[] objectAtIndex:666];
}

@end
