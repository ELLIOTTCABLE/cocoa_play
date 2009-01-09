//
//  StretchView.h
//  ImageFun
//

#import <Cocoa/Cocoa.h>

@interface StretchView : NSView {
  NSBezierPath *path;
}
- (NSPoint)randomPoint;
@end
