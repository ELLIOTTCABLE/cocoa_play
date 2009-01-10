//
//  BigLetterView.m
//  TypingTutor
//

#import "BigLetterView.h"

@implementation BigLetterView

#pragma mark ===== What's up in this mug? ==

- (id)initWithFrame:(NSRect)rect {
  NSLog(@"@BigLetterView - initWithFrame:]");
  if (![super initWithFrame:rect])
    return nil;
  
  bgColor = [[NSColor yellowColor] retain];
  string = @" ";
  
  return self;
}

#pragma mark ===== i r an accessarz ==

- (NSColor *)bgColor { return bgColor; }
- (void)setBgColor:(NSColor *)c {
  NSLog(@"@BigLetterView - setBgColor:%@]", c);
  [c retain];
  [bgColor release];
  bgColor = c;
  [self setNeedsDisplay:YES];
}

- (NSString *)string { return string; }
- (void)setString:(NSString *)s {
  NSLog(@"@BigLetterView - setString:%@]", s);
  s = [s copy];
  [string release];
  string = s;
}

#pragma mark ===== Dwawing ==

- (BOOL)isOpaque { return YES; }
- (void)drawRect:(NSRect)rect {
  NSLog(@"@BigLetterView - drawRect:]");
  NSRect bounds = [self bounds];
  [bgColor set];
  [NSBezierPath fillRect:bounds];
  
  // Am I the window's first responder?
  if ([[self window] firstResponder] == self) {
    [[NSColor keyboardFocusIndicatorColor] set];
    [NSBezierPath setDefaultLineWidth:4.0];
    [NSBezierPath strokeRect:bounds];
  }
}

#pragma mark ===== Aww, it's been fun )-: ==

- (void)dealloc {
  NSLog(@"@BigLetterView - dealloc]");
  [bgColor release];
  [string release];
  [super dealloc];
}

@end
