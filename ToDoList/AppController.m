#import "AppController.h"

@implementation AppController

- (id)init {
  [super init];
  
  toDos = [NSMutableArray arrayWithCapacity:1];
  
  return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
  return [toDos count];
}

- (id)                tableView:(NSTableView *)aTableView
      objectValueForTableColumn:(NSTableColumn *)aTableColumn
                            row:(NSInteger)rowIndex {
  return [toDos objectAtIndex:rowIndex];
}

- (void)controlTextDidEndEditing:(NSNotification *)aNotification {
  NSLog(@"- controlTextDidEndEditing called");
}

@end
