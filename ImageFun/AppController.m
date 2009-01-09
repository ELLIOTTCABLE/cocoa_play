//
//  AppController.m
//  ImageFun
//

#import "AppController.h"

@implementation AppController

- (void)openPanelDidEnd:(NSOpenPanel *)openPanel
             returnCode:(int)returnCode
            contextInfo:(void *)x {
  // Did they choose "Open"?
  if (returnCode == NSOKButton) {
    NSString *path = [openPanel filename];
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
    [stretchView setImage:image];
    [image release];
  }
}

- (IBAction)showOpenPanel:(id)sender {
  NSOpenPanel *panel = [NSOpenPanel openPanel];
  
  // Run the open panel
  [panel beginSheetForDirectory:nil
                           file:nil
                          types:[NSImage imageFileTypes]
                 modalForWindow:[stretchView window]
                  modalDelegate:self
                 didEndSelector:
   @selector(openPanelDidEnd:returnCode:contextInfo:)
                    contextInfo:NULL];
}

@end
