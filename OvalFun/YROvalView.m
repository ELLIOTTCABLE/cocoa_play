//
//  YROvalView.m
//  OvalFun
//

#import "YROvalView.h"

@implementation YROvalView

#pragma mark Hi, I'm YROvalView! Who're you?

- (id)initWithFrame:(NSRect)frame {
  NSLog(@"- initWithFrame:]");
  if (![super initWithFrame:frame])
    return nil;
  
  return self;
}

#pragma mark Things go clicky-click

- (void)mouseDown:(NSEvent *)event {
  NSPoint p = [event locationInWindow];
  NSLog(@"- mouseDragged:%@]", NSStringFromPoint(p));
  downPoint = [self convertPoint:p fromView:nil];
  currentPoint = downPoint;
  [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event {
  NSPoint dragToPoint = [event locationInWindow];
  NSLog(@"- mouseDragged:%@]", NSStringFromPoint(dragToPoint));
  currentPoint = [self convertPoint:dragToPoint fromView:nil];
  [self autoscroll:event];
  [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event {
  NSLog(@"- mouseUp:]");
  
  NSSize newRectSize;
  newRectSize.width = currentPoint.x - downPoint.x;
  newRectSize.height = currentPoint.y - downPoint.y;
  NSRect newRect;
  newRect.origin = downPoint;
  newRect.size = newRectSize;
  
  NSValue *rectAsValue = [NSValue valueWithRect:newRect];
  NSLog(@"- mouseUp:] preparing to add %@", rectAsValue);
  [[owner mutableSetValueForKey:@"ovals"] addObject:[rectAsValue retain]];
  
  NSLog(@"- mouseUp:] deposited %@", rectAsValue);
  
  // Set the two points the same, to ensure an extra 'rectangle' isn't drawn
  currentPoint = downPoint;
  [self setNeedsDisplay:YES];
}

#pragma mark Drawing shit

- (NSRect)currentRect
{
  float minX = MIN(downPoint.x, currentPoint.x);
  float maxX = MAX(downPoint.x, currentPoint.x);
  float minY = MIN(downPoint.y, currentPoint.y);
  float maxY = MAX(downPoint.y, currentPoint.y);
  
  return NSMakeRect(minX, minY, maxX-minX, maxY-minY);
}

- (void)drawRect:(NSRect)rect {
  NSLog(@"- drawRect:]");
  NSRect bounds = [self bounds];
  [[NSColor grayColor] set];
  [NSBezierPath fillRect:bounds];
  
  [[NSColor whiteColor] set];
  [[NSBezierPath bezierPathWithOvalInRect:[self currentRect]] fill];
  [[NSColor blueColor] set];
  NSEnumerator *rectEnumerator = [[owner ovals] objectEnumerator];
  NSValue *value = nil;
  while (value = [rectEnumerator nextObject]) {
    NSLog(@"- drawRect:] retreived %@", value);
    [[NSBezierPath bezierPathWithOvalInRect:[value rectValue]] fill];
  }
}

@end
