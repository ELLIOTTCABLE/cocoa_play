//
//  BigLetterView.m
//  TypingTutor
//

#import "BigLetterView.h"
#import "FirstLetter.h"

@implementation BigLetterView

#pragma mark ===== What's up in this mug? ==

- (id)initWithFrame:(NSRect)rect {
  NSLog(@"@BigLetterView - initWithFrame:]");
  if (![super initWithFrame:rect])
    return nil;
  
  bgColor = [[NSColor yellowColor] retain];
  string = @" ";
  [self prepareAttributes];
  bold = NO;
  italic = NO;
  
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
  
  NSFont *font = [NSFont fontWithName:@"Helvetica" size:75];
  NSFontManager *fontManager = [NSFontManager sharedFontManager];
  if (italic) font = [fontManager convertFont:font toHaveTrait:NSItalicFontMask];
  if (bold) font = [fontManager convertFont:font toHaveTrait:NSBoldFontMask];
  
  [attributes setObject:font
                 forKey:NSFontAttributeName];
  
  [attributes setObject:[NSColor redColor]
                 forKey:NSForegroundColorAttributeName];
  NSShadow *shadow = [[NSShadow alloc] init];
  [shadow setShadowBlurRadius:5.0];
  NSSize offset;
  offset.width = 4;
  offset.height = -4;
  [shadow setShadowOffset:offset];
  [attributes setObject:shadow
                 forKey:NSShadowAttributeName];
  [self setNeedsDisplay:YES];
}

- (BOOL)italic { return italic; }
- (void)setItalic:(BOOL)i {
  NSLog(@"@BigLetterView - setItalic:%d]", i);
  italic = i;
  [self prepareAttributes];
}
- (IBAction)toggleItalic:(id)sender { [self setItalic:![self italic]]; }

- (BOOL)bold { return bold; }
- (void)setBold:(BOOL)b {
  NSLog(@"@BigLetterView - setBold:%d]", b);
  bold = b;
  [self prepareAttributes];
}
- (IBAction)toggleBold:(id)sender { [self setBold:![self bold]]; }

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

#pragma mark ===== Paste bored. ==

- (IBAction)cut:(id)sender {
  NSLog(@"@BigLetterView - cut:]");
  [self copy:sender];
  [self setString:@""];
}

- (IBAction)copy:(id)sender {
  NSLog(@"@BigLetterView - copy:]");
  NSPasteboard *pb = [NSPasteboard generalPasteboard];
  [self writeToPasteboard:pb];
}

- (IBAction)paste:(id)sender {
  NSLog(@"@BigLetterView - paste:]");
  NSPasteboard *pb = [NSPasteboard generalPasteboard];
  NSString *value = [self readFromPasteboard:pb];
  [self setString:[value YR_firstLetter]];
}

- (void)writeToPasteboard:(NSPasteboard *)pb {
  NSLog(@"@BigLetterView - writeToPasteboard:]");
  NSString *stringType = [NSStringPboardType retain];
  NSString *PDFType = [NSPDFPboardType retain];
  // For whatever reason, I always get tons of errors if I try to create a normal NSArray with +arrayWithObjects:... so doing it the round-about way.
  NSMutableArray *types = [[NSMutableArray arrayWithCapacity:2] retain];
  [types addObject:stringType];
  [types addObject:PDFType];
  [pb declareTypes:types owner:self];
  [pb setString:string forType:stringType];
  NSRect r = [self bounds];
  NSData *data = [self dataWithPDFInsideRect:r];
  [pb setData:data forType:PDFType];
}

- (NSString *)readFromPasteboard:(NSPasteboard *)pb {
  NSLog(@"@BigLetterView - readFromPasteboard:]");
  NSString *type = NSStringPboardType;
  if ([[pb types] containsObject:type])
    return [pb stringForType:type];
  return nil;
}

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
