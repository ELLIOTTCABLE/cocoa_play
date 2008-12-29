#import <Foundation/Foundation.h>

@interface Person : NSObject {
  NSString *personName;
  float expectedRaise;
}
@property (readwrite, copy) NSString *personName;
@property (readwrite) float expectedRaise;
@end
