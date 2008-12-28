#import <Cocoa/Cocoa.h>

@interface AppController : NSObject {
  IBOutlet NSTextField *textField;
  IBOutlet NSTableView *tableView;
  
  NSArray *toDos;
}



@end
