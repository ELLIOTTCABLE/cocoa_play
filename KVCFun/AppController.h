#import <Cocoa/Cocoa.h>

@interface AppController : NSObject {
  int fido;
}

- (int)fido;
- (void)setFido:(int)x;
- (IBAction)incrementFido:(id)sender;

@end
