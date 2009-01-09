//
//  StretchView.m
//  ImageFun
//

#import "StretchView.h"

@implementation StretchView

- (id)initWithFrame:(NSRect)frame {
  if (![super initWithFrame:frame])
    return nil;
  
  // Seed the random number generator
  srandom(time(NULL));
  
  // Create a path object
  path = [[NSBezierPath alloc] init];
  [path setLineWidth:3.0];
  NSPoint p1 = [self randomPoint];
  [path moveToPoint:p1];
  int i;
  NSPoint p2;
  NSPoint p3;
  for (i = 0; i < 15; i++) {
    p1 = [self randomPoint];
    p2 = [self randomPoint];
    p3 = [self randomPoint];
    [path curveToPoint:p1 controlPoint1:p2 controlPoint2:p3];
  }
  [path closePath];
  
  return self;
}

- (NSPoint)randomPoint {
  NSPoint result;
  NSRect r = [self bounds];
  result.x = r.origin.x + random() % (int)r.size.width;
  result.y = r.origin.y + random() % (int)r.size.height;
  return result;
}

- (void)drawRect:(NSRect)rect {
  NSRect bounds = [self bounds];
  [[NSColor greenColor] set];
  [NSBezierPath fillRect:bounds];
  
  [[NSColor whiteColor] set];
  [path fill];
}

- (void)dealloc {
  [path release];
  [super dealloc];
}

@end
