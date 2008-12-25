#import "AppController.h"

@implementation AppController

- (id)init {
  [super init];
  
  // Logs can help the beginner understand what is happening and hunt down bugs.
  NSLog(@"init");
  
  // Create a new instance of NSSpeechSynthesizer with the default voice.
  speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
  [speechSynth setDelegate:self];
  voiceList = [[NSSpeechSynthesizer availableVoices] retain];
  
  return self;
}

- (void)awakeFromNib {
  int defaultRow = [voiceList indexOfObject:[NSSpeechSynthesizer defaultVoice]];
  [tableView selectRow:defaultRow byExtendingSelection:NO];
  [tableView scrollRowToVisible:defaultRow];
}

// Overriding this, just so we can see when things try to delegate to us
- (BOOL)respondsToSelector:(SEL)aSelector {
  NSLog(@"respondsToSelector:%@", NSStringFromSelector(aSelector));
  return [super respondsToSelector:aSelector];
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender
        didFinishSpeaking:(BOOL)complete {
  NSLog(@"complete = %d", complete);
  
  [stopButton setEnabled:NO];
  [startButton setEnabled:YES];
  [tableView setEnabled:YES];
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
  [tableView setEnabled:NO];
}

- (IBAction)stopIt:(id)sender {
  NSLog(@"stopping");
  [speechSynth stopSpeaking];
}

- (int)numberOfRowsInTableView:(NSTableView *)tv {
  return [voiceList count];
}

- (id)          tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tableColumn
                      row:(int)row {
  return [[NSSpeechSynthesizer attributesForVoice:[voiceList objectAtIndex:row]] objectForKey:NSVoiceName];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
  int row = [tableView selectedRow];
  if (row == -1) {
    return;
  }
  [speechSynth setVoice:[voiceList objectAtIndex:row]];
}

@end