#import "AppController.h"

@implementation AppController

- (id)init {
  [super init];
  [self setValue:[NSNumber numberWithInt:5] forKey:@"fido"];
  NSNumber *n = [self valueForKey:@"fido"];
  NSLog(@"fido = %@", n);
  return self;
}

@synthesize fido;

- (IBAction)incrementFido:(id)sender {
  [self setFido:[self fido] + 1];
  NSLog(@"fido is now %d", fido);
}

@end
