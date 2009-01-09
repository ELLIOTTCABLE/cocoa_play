//
//  StretchView.m
//  ImageFun
//

#import "StretchView.h"

@implementation StretchView

- (id)initWithFrame:(NSRect)frame {
  if (![super initWithFrame:frame])
    return nil;
  return self;
}

- (void)drawRect:(NSRect)rect {
  NSRect bounds = [self bounds];
  [[NSColor greenColor] set];
  [NSBezierPath fillRect:bounds];
}

@end
