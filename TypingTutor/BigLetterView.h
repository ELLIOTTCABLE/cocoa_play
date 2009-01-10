//
//  BigLetterView.h
//  TypingTutor
//

#import <Cocoa/Cocoa.h>

@interface BigLetterView : NSView {
  NSColor *bgColor;
  NSString *string;
  BOOL bold;
  BOOL italic;
  NSMutableDictionary *attributes;
}
@property (retain, readwrite) NSColor *bgColor;
@property (copy, readwrite) NSString *string;
- (BOOL)italic;
- (void)setItalic:(BOOL)i;
- (IBAction)toggleItalic:(id)sender;
- (BOOL)bold;
- (void)setBold:(BOOL)b;
- (IBAction)toggleBold:(id)sender;
- (void)prepareAttributes;
- (void)drawStringCenteredIn:(NSRect)r;
- (void)writeToPasteboard:(NSPasteboard *)pb;
- (NSString *)readFromPasteboard:(NSPasteboard *)pb;
- (IBAction)savePDF:(id)sender;
@end
