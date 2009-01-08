#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

+ (void)initialize {
  // Create a dictionary
  NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
  
  // Archive the color object
  NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]];
  
  // Put defaults in the dictionary
  [defaultValues setObject:colorAsData forKey:YRDKTableBackgroundColor];
  [defaultValues setObject:[NSNumber numberWithBool:YES] forKey:YRDKEmptyDocumentAtStartup];
  
  // Register the dictionary of defaults
  [[NSUserDefaults standardUserDefaults]
   registerDefaults: defaultValues];
  NSLog(@"registered defaults: %@", defaultValues);
}

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

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender {
  NSLog(@"- applicationShouldOpenUntitledFile:");
  return [[NSUserDefaults standardUserDefaults] boolForKey:YRDKEmptyDocumentAtStartup];
}

@end
