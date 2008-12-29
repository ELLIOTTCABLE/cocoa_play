#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument {
  NSMutableArray *employees;
}
- (void)setEmployees:(NSMutableArray *)a;
@end
