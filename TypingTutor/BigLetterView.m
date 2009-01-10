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
  [self prepareAttributes];
  
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
  [self setNeedsDisplay:YES];
}

- (void)prepareAttributes {
  attributes = [[NSMutableDictionary alloc] init];
  
  [attributes setObject:[NSFont fontWithName:@"Helvetica" size:75]
                 forKey:NSFontAttributeName];
  
  [attributes setObject:[NSColor redColor]
                 forKey:NSForegroundColorAttributeName];
}

#pragma mark ===== Dwawing ==

- (BOOL)isOpaque { return YES; }
- (void)drawRect:(NSRect)rect {
  NSLog(@"@BigLetterView - drawRect:]");
  NSRect bounds = [self bounds];
  [bgColor set];
  [NSBezierPath fillRect:bounds];
  [self drawStringCenteredIn:bounds];
  
  // Am I the window's first responder?
  if (([[self window] firstResponder] == self) && [NSGraphicsContext currentContextDrawingToScreen]) {
    [NSGraphicsContext saveGraphicsState];
    NSSetFocusRingStyle(NSFocusRingOnly);
    [NSBezierPath fillRect:bounds];
    [NSGraphicsContext restoreGraphicsState];
  }
}

- (void)drawStringCenteredIn:(NSRect)r {
  NSSize strSize = [string sizeWithAttributes:attributes];
  NSPoint strOrigin;
  strOrigin.x = r.origin.x + (r.size.width - strSize.width)/2;
  strOrigin.y = r.origin.y + (r.size.height - strSize.height)/2;
  [string drawAtPoint:strOrigin withAttributes:attributes];
}

#pragma mark ===== It's kinda like the first lady, but not. ==

- (BOOL)acceptsFirstResponder {
  NSLog(@"@BigLetterView - acceptsFirstResponder]");
  return YES;
}

- (BOOL)resignFirstResponder {
  NSLog(@"@BigLetterView - resignFirstResponder]");
  [self setKeyboardFocusRingNeedsDisplayInRect:[self bounds]];
  return YES;
}

- (BOOL)becomeFirstResponder {
  NSLog(@"@BigLetterView - becomeFirstResponder]");
  [self setNeedsDisplay:YES];
  return YES;
}

#pragma mark ===== Clickity-clack ==

- (void)keyDown:(NSEvent *)event { [self interpretKeyEvents:[NSArray arrayWithObject:event]]; }
- (void)insertText:(NSString *)input { [self setString:input]; }

- (void)insertTab:(id)sender { [[self window] selectKeyViewFollowingView:self]; }
- (void)insertBacktab:(id)sender { [[self window] selectKeyViewPrecedingView:self]; }
- (void)deleteBackward:(id)sender { [self setString:@" "]; }

#pragma mark ===== Portable Retarded Format, more like it ==

- (IBAction)savePDF:(id)sender {
  NSSavePanel *panel = [NSSavePanel savePanel];
  [panel setRequiredFileType:@"pdf"];
  [panel beginSheetForDirectory:nil
                           file:nil
                 modalForWindow:[self window]
                  modalDelegate:self
                 didEndSelector:@selector(didEnd:returnCode:contextInfo:)
                    contextInfo:NULL];
}

- (void)didEnd:(NSSavePanel *)sheet
    returnCode:(int)code
   contextInfo:(void *)contextInfo {
  if (code != NSOKButton)
    return;
  
  NSRect r = [self bounds];
  NSData *data = [self dataWithPDFInsideRect:r];
  NSString *path = [sheet filename];
  NSError *error;
  BOOL successful = [data writeToFile:path
                              options:0
                                error:&error];
  if (!successful) {
    NSAlert *a = [NSAlert alertWithError:error];
    [a runModal];
  }
}

#pragma mark ===== Aww, it's been fun )-: ==

- (void)dealloc {
  NSLog(@"@BigLetterView - dealloc]");
  [bgColor release];
  [string release];
  [attributes release];
  [super dealloc];
}

@end
