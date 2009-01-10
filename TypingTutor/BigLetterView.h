//
//  BigLetterView.h
//  TypingTutor
//

#import <Cocoa/Cocoa.h>

@interface BigLetterView : NSView {
  NSColor *bgColor;
  NSString *string;
}
@property (retain, readwrite) NSColor *bgColor;
@property (copy, readwrite) NSString *string;
@end
