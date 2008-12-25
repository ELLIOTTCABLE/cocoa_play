#import "AppController.h"

@implementation AppController

- (void)awakeFromNib {
  [self countChars:nil];
}

- (IBAction)countChars:(id)sender {
  [numChars setIntValue:[[textField stringValue] length]];
}

@end
