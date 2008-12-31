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

- (IBAction)showAboutPanel:(id)sender {
  [NSBundle loadNibNamed:@"About" owner:self];
  
  if (!aboutController) {
    aboutController = [[NSWindowController alloc] init];
  }
  NSLog(@"showing %@", aboutController);
  [aboutController showWindow:aboutPanel];
}

@end
