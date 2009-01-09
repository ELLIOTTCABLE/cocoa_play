//
//  StretchView.h
//  ImageFun
//

#import <Cocoa/Cocoa.h>

@interface StretchView : NSView {
  NSBezierPath *path;
  NSImage *image;
  float opacity;
}
@property (readwrite) float opacity;
- (void)setImage:(NSImage *)newImage;
- (NSPoint)randomPoint;
@end
