//
//  YROvalView.h
//  OvalFun
//

#import <Cocoa/Cocoa.h>
#import "MyDocument.h"

@interface YROvalView : NSView {
  NSPoint downPoint;
  NSPoint currentPoint;
  IBOutlet MyDocument *owner;
}

@end
