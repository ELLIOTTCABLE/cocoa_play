#import <Cocoa/Cocoa.h>

// DKs - Defaults Keys
extern NSString * const YRDKTableBackgroundColor;
extern NSString * const YRDKEmptyDocumentAtStartup;

// NNs - Notification Names
extern NSString * const YRNNTableBackgroundColorChanged;

@interface PreferenceController : NSWindowController {
  IBOutlet NSColorWell *colorWell;
  IBOutlet NSButton *checkbox;
}
- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;
- (IBAction)resetPreferences:(id)sender;
- (NSColor *)tableBgColor;
- (BOOL)emptyDoc;
@end
