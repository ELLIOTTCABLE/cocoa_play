#import "AppController.h"

@implementation AppController

- (id)init {
  [super init];
  
  // Logs can help the beginner understand what is happening and hunt down bugs.
  NSLog(@"init");
  
  // Create a new instance of NSSpeechSynthesizer with the default voice.
  speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
  [speechSynth setDelegate:self];
  
  return self;
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender
        didFinishSpeaking:(BOOL)complete {
  NSLog(@"complete = %d", complete);
  
  [stopButton setEnabled:NO];
  [startButton setEnabled:YES];
}

- (IBAction)sayIt:(id)sender {
  NSString *string = [textField stringValue];
  
  if ([string length] == 0) {
    NSLog(@"string from %@ is of zero-length", textField);
    return;
  }
  [speechSynth startSpeakingString:string];
  NSLog(@"Have started to say: %@", string);
  
  [stopButton setEnabled:YES];
  [startButton setEnabled:NO];
}

- (IBAction)stopIt:(id)sender {
  NSLog(@"stopping");
  [speechSynth stopSpeaking];
}

@end