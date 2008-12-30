#import "Person.h"

@implementation Person

- (id)init {
  [super init];
  expectedRaise = 5.0;
  personName = @"New Person";
  return self;
}

- (id)initWithCoder:(NSCoder *)coder {
  [super init];
  personName = [[coder decodeObjectForKey:@"personName"] retain];
  expectedRaise = [coder decodeFloatForKey:@"expectedRaise"];
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

- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:personName forKey:@"personName"];
  [coder encodeFloat:expectedRaise forKey:@"expectedRaise"];
}

- (void)dealloc {
  [personName release];
  [super dealloc];
}

@end
