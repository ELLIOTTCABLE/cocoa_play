#import "Person.h"

@implementation Person

- (id)init {
  [super init];
  expectedRaise = 5.0;
  personName = @"New Person";
  return self;
}

@synthesize personName;
@synthesize expectedRaise;

- (void)setNilValueForKey:(NSString *)key {
  if ([key isEqual:@"expectedRaise"]) {
    [self setExpectedRaise:0.0];
  } else {
    [super setNilValueForKey:key];
  }
}

- (void)dealloc {
  [personName release];
  [super dealloc];
}

@end
