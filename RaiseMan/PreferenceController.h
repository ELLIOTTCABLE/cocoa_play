#import <Cocoa/Cocoa.h>

@interface PreferenceController : NSWindowController {
  IBOutlet NSColorWell *colorWell;
  IBOutlet NSButton *checkbox;
}
- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;
@end