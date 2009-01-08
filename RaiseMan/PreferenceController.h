#import <Cocoa/Cocoa.h>

// DKs - Defaults Keys
extern NSString * const YRDKTableBackgroundColor;
extern NSString * const YRDKEmptyDocumentAtStartup;

@interface PreferenceController : NSWindowController {
  IBOutlet NSColorWell *colorWell;
  IBOutlet NSButton *checkbox;
}
- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;
- (NSColor *)tableBgColor;
- (BOOL)emptyDoc;
@end
