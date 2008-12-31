#import "PreferenceController.h"

@implementation PreferenceController

- (id)init {
  if (![super initWithWindowNibName:@"Preferences"])
    return nil;
  return self;
}

- (void)windowDidLoad {
  NSLog(@"Nib file is loaded");
}

- (IBAction)changeBackgroundColor:(id)sender {
  NSColor *color = [colorWell color];
  NSLog(@"Color changed: %@", color);
}

- (IBAction)changeNewEmptyDoc:(id)sender {
  int state = [checkbox state];
  NSLog(@"Checkbox changed %d", state);
}

@end
