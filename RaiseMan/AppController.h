#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface AppController : NSObject {
  PreferenceController *preferenceController;
  IBOutlet NSPanel *aboutPanel;
}
- (IBAction)showPreferencePanel:(id)sender;
- (IBAction)showAboutPanel:(id)sender;
@end
