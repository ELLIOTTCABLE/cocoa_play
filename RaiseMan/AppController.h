#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface AppController : NSObject {
  PreferenceController *preferenceController;
  NSWindowController *aboutController;
  IBOutlet NSPanel *aboutPanel;
}
- (IBAction)showPreferencePanel:(id)sender;
- (IBAction)showAboutPanel:(id)sender;
@end
