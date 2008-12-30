#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding> {
  NSString *personName;
  float expectedRaise;
}
@property (readwrite, copy) NSString *personName;
@property (readwrite) float expectedRaise;
@end
