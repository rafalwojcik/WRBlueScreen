#import "ViewController.h"
#import <WRBlueScreen/WRBlueScreen.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showBSOD:(id)sender {
    [[WRBlueScreen sharedWindow] showErrorMessage:@"API Fatality !!!"];
}

@end
