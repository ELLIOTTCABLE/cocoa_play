#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

- (IBAction)showPreferencePanel:(id)sender{
  // Is preferenceController nil?
  if (!preferenceController) {
    preferenceController = [[PreferenceController alloc] init];
  }
  NSLog(@"showing %@", preferenceController);
  [preferenceController showWindow:self];
}

@end
