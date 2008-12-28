#import "AppController.h"

@implementation AppController

- (id)init {
  [super init];
  
  toDos = [NSMutableArray arrayWithCapacity:1];
  
  return self;
}

- (void)controlTextDidEndEditing:(NSNotification *)aNotification {
	NSLog(@"- controlTextDidEndEditing called");
}

@end
