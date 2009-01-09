#import "PreferenceController.h"

// DKs - Defaults Keys
NSString * const YRDKTableBackgroundColor = @"TableBackgroundColor";
NSString * const YRDKEmptyDocumentAtStartup = @"EmptyDocumentAtStartup";

@implementation PreferenceController

- (id)init {
  if (![super initWithWindowNibName:@"Preferences"])
    return nil;
  return self;
}

- (NSColor *)tableBgColor {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSData *colorAsData = [defaults objectForKey:YRDKTableBackgroundColor];
  return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}

- (BOOL)emptyDoc {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  return [defaults boolForKey:YRDKEmptyDocumentAtStartup];
}

- (void)windowDidLoad {
  NSLog(@"Nib file is loaded");
  [colorWell setColor:[self tableBgColor]];
  [checkbox setState:[self emptyDoc]];
}

- (IBAction)changeBackgroundColor:(id)sender {
  NSColor *color = [colorWell color];
  NSLog(@"Color changed: %@", color);
  NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:colorAsData forKey:YRDKTableBackgroundColor];
}

- (IBAction)changeNewEmptyDoc:(id)sender {
  int state = [checkbox state];
  NSLog(@"Checkbox changed %d", state);
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setBool:state forKey:YRDKEmptyDocumentAtStartup];
}

- (IBAction)resetPreferences:(id)sender {
  NSLog(@"- resetPreferences:]");
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults removeObjectForKey:YRDKTableBackgroundColor];
  [defaults removeObjectForKey:YRDKEmptyDocumentAtStartup];
  [colorWell setColor:[self tableBgColor]];
  [checkbox setState:[self emptyDoc]];
}

@end
