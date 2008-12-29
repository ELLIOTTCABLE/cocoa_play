#import "AppController.h"

@implementation AppController

- (id)init {
  [super init];
  
  toDos = [NSMutableArray arrayWithCapacity:1];
  [toDos addObject:@"Play with ToDoList!"];
  
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
  NSString *value = [[aNotification object] stringValue];
  NSLog(@"- controlTextDidEndEditing:%@ == %@", [aNotification object], value);
  
  if([[aNotification object] isKindOfClass:[NSTextField class]]) {
    if(![value isEqualToString:@""]) {
      [toDos addObject:value];
      [[aNotification object] setStringValue:@""];
      [tableView reloadData];
    }
  }
}

@end
