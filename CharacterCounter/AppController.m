#import "AppController.h"

@implementation AppController

- (void)awakeFromNib {
  [numChars setIntValue:0];
}

- (IBAction)countChars:(id)sender {
  [numChars setIntValue:[[textField stringValue] length]];
}

@end
