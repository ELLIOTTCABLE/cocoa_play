#import "AppController.h"

@implementation AppController

- (NSSize)windowWillResize:(NSWindow *)sender
                    toSize:(NSSize)frameSize {
  NSSize newSize;
  newSize.width = frameSize.width;
  newSize.height = 2 * frameSize.width;
  return newSize;
}

@end
