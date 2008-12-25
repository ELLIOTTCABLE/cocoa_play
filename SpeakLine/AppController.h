#import <Cocoa/Cocoa.h>

@interface AppController : NSObject {
  IBOutlet NSButton *stopButton;
  IBOutlet NSButton *startButton;
  IBOutlet NSTextField *textField;
  NSSpeechSynthesizer *speechSynth;
}

- (IBAction)sayIt:(id)sender;
- (IBAction)stopIt:(id)sender;

@end