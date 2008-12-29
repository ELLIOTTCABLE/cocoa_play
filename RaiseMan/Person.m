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

- (void)dealloc {
  [personName release];
  [super dealloc];
}

@end
