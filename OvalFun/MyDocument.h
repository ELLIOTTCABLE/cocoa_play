//
//  MyDocument.h
//  OvalFun
//

#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument {
  NSMutableSet *ovals;
}
@property (readwrite,copy) NSMutableSet *ovals;
@end
