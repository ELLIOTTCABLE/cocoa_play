//
//  StretchView.m
//  ImageFun
//

#import "StretchView.h"

@implementation StretchView

#pragma mark Introduction

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
  
  opacity = 1.0;
  
  return self;
}

#pragma mark Accessors

- (void)setImage:(NSImage *)newImage {
  [newImage retain];
  [image release];
  image = newImage;
  NSSize imageSize = [newImage size];
  downPoint = NSZeroPoint;
  currentPoint.x = downPoint.x + imageSize.width;
  currentPoint.y = downPoint.y + imageSize.height;
  [self setNeedsDisplay:YES];
}

- (float)opacity {
  return opacity;
}

- (void)setOpacity:(float)x {
  opacity = x;
  [self setNeedsDisplay:YES];
}

#pragma mark Drawing

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
  if (image) {
    NSRect imageRect;
    imageRect.origin = NSZeroPoint;
    imageRect.size = [image size];
    NSRect drawingRect = [self currentRect];
    [image drawInRect:drawingRect
             fromRect:imageRect
            operation:NSCompositeSourceOver
             fraction:opacity];
  }
}

- (NSRect)currentRect {
  float minX = MIN(downPoint.x, currentPoint.x);
  float maxX = MAX(downPoint.x, currentPoint.x);
  float minY = MIN(downPoint.y, currentPoint.y);
  float maxY = MAX(downPoint.y, currentPoint.y);
  
  return NSMakeRect(minX, minY, maxX-minX, maxY-minY);
}

#pragma mark Events

- (void)mouseDown:(NSEvent *)event {
  NSLog(@"mouseDown: %d", [event clickCount]);
  NSPoint p = [event locationInWindow];
  downPoint = [self convertPoint:p fromView:nil];
  currentPoint = downPoint;
  [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event {
  NSPoint p = [event locationInWindow];
  NSLog(@"mouseDragged:%@", NSStringFromPoint(p));
  currentPoint = [self convertPoint:p fromView:nil];
  [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event {
  NSLog(@"mouseUp:");
  NSPoint p = [event locationInWindow];
  currentPoint = [self convertPoint:p fromView:nil];
  [self setNeedsDisplay:YES];
}

#pragma mark Closing remarks

- (void)dealloc {
  [path release];
  [image release];
  [super dealloc];
}

@end
