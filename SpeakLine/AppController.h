#import <Cocoa/Cocoa.h>

@interface AppController : NSObject {
  IBOutlet NSTextField *textField;
  NSSpeechSynthesizer *speechSynth;
}
- (IBAction)sayIt:(id)sender;
- (IBAction)stopIt:(id)sender;
@end