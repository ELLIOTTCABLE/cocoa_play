#import "MyDocument.h"
#import "Person.h"

@implementation MyDocument

- (id)init {
  self = [super init];
  employees = [[NSMutableArray alloc] init];
  return self;
}

- (void)setEmployees:(NSMutableArray *)a {
  // This is an unusual setter method.  We are going to add a lot
  // of smarts to it in the next chapter.
  if (a == employees)
    return;
  
  [a retain];
  [employees release];
  employees = a;
}

- (void)insertObject:(Person *)p inEmployeesAtIndex:(int)index {
  NSLog(@"adding %@ to %@", p, employees);
  // Add the inverse of this operation to the undo stack
  NSUndoManager *undo = [self undoManager];
  [[undo prepareWithInvocationTarget:self] removeObjectFromEmployeesAtIndex:index];
  if (![undo isUndoing]) {
    [undo setActionName:@"Insert Person"];
  }
  // Add the Person to the array
  [employees insertObject:p atIndex:index];
}

- (void)removeObjectFromEmployeesAtIndex:(int)index {
  Person *p = [employees objectAtIndex:index];
  NSLog(@"removing %@ from %@", p, employees);
  // Add the inverse of this operation to the undo stack
  NSUndoManager *undo = [self undoManager];
  [[undo prepareWithInvocationTarget:self] insertObject:p inEmployeesAtIndex:index];
  if (![undo isUndoing]) {
    [undo setActionName:@"Delete Person"];
  }
  
  [employees removeObjectAtIndex:index];
}

- (NSString *)windowNibName {
  // Override returning the nib file name of the document
  // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
  return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController {
  [super windowControllerDidLoadNib:aController];
  // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
  // Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.
  
  // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
  
  // For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.
  
  if ( outError != NULL ) {
    *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
  }
  return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
  // Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.
  
  // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
  
  // For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
  
  if ( outError != NULL ) {
    *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
  }
  return YES;
}

- (void)dealloc {
  [self setEmployees:nil];
  [super dealloc];
}

@end
