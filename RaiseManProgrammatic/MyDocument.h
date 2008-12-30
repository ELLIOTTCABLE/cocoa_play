#import <Cocoa/Cocoa.h>
@class Person;

@interface MyDocument : NSDocument {
  NSMutableArray *employees;
  IBOutlet NSTableView *tableView;
}
- (IBAction)createEmployee:(id)sender;
- (IBAction)deleteSelectedEmployees:(id)sender;
@end
