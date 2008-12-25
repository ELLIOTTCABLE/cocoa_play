#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
  IBOutlet NSTextField *textField;
  IBOutlet NSTextField *numChars;
}

- (IBAction)countChars:(id)sender;

@end
