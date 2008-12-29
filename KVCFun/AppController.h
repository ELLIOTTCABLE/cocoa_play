#import <Cocoa/Cocoa.h>

@interface AppController : NSObject {
  int fido;
}

@property(readwrite, assign) int fido;
- (IBAction)incrementFido:(id)sender;

@end
