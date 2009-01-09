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
  NSLog(@"- mouseDown:%d]", [event clickCount]);
}

- (void)mouseDragged:(NSEvent *)event {
  NSPoint p = [event locationInWindow];
  NSLog(@"- mouseDragged:%@]", NSStringFromPoint(p));
  [self autoscroll:event];
}

- (void)mouseUp:(NSEvent *)event {
  NSLog(@"- mouseUp:]");
}

#pragma mark Drawing shit

- (void)drawRect:(NSRect)rect {
  NSLog(@"- drawRect:]");
}

@end
