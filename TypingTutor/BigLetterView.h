//
//  BigLetterView.h
//  TypingTutor
//

#import <Cocoa/Cocoa.h>

@interface BigLetterView : NSView {
  NSColor *bgColor;
  NSString *string;
  NSMutableDictionary *attributes;
}
@property (retain, readwrite) NSColor *bgColor;
@property (copy, readwrite) NSString *string;
- (void)prepareAttributes;
- (void)drawStringCenteredIn:(NSRect)r;
@end
