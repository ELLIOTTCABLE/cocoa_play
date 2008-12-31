#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface AppController : NSObject {
  PreferenceController *preferenceController;
}
- (IBAction)showPreferencePanel:(id)sender;
@end
