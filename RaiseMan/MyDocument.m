#import "PreferenceController.h"
#import "MyDocument.h"
#import "Person.h"

@implementation MyDocument

- (id)init {
  self = [super init];
  employees = [[NSMutableArray alloc] init];
  
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self
         selector:@selector(handleColorChange:)
             name:YRNNTableBackgroundColorChanged
           object:nil];
  NSLog(@"Registered with notification center");
  
  return self;
}

- (BOOL)readFromData:(NSData *)data
              ofType:(NSString *)typeName
               error:(NSError **)outError {
  NSLog(@"About to read data of type %@", typeName);
  NSMutableArray *newArray = nil;
  @try {
    newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  }
  @catch (NSException *e) {
    if (outError) {
      NSDictionary *d = [NSDictionary
                         dictionaryWithObject:@"The data is corrupted."
                         forKey:NSLocalizedFailureReasonErrorKey];
      *outError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                      code:unimpErr
                                  userInfo:d];
    }
    return NO;
  }
  [self setEmployees:newArray];
  return YES;
}

- (IBAction)createEmployee:(id)sender {
  NSWindow *w = [tableView window];
  
  // Try to end any editing that is taking place
  BOOL editingEnded = [w makeFirstResponder:w];
  if (!editingEnded) {
    NSLog(@"Unable to end editing");
    return;
  }
  NSUndoManager *undo = [self undoManager];
  
  // Has an edit occurred already in this event?
  if ([undo groupingLevel]) {
    // Close the last group
    [undo endUndoGrouping];
    // Open a new group
    [undo beginUndoGrouping];
  }
  // Create the object
  Person *p = [employeeController newObject];
  
  // Add it to the content array of 'employeeController'
  [employeeController addObject:p];
  [p release];
  // Re-sort (in case the user has sorted a column)
  [employeeController rearrangeObjects];
  
  // Get the sorted array
  NSArray *a = [employeeController arrangedObjects];
  
  // Find the object just added
  int row = [a indexOfObjectIdenticalTo:p];
  NSLog(@"starting edit of %@ in row %d", p, row);
  
  // Begin the edit in the first column
  [tableView editColumn:0
                    row:row
              withEvent:nil
                 select:YES];
}

- (void)setEmployees:(NSMutableArray *)a {
  // This is an unusual setter method.  We are going to add a lot
  // of smarts to it in the next chapter.
  if (a == employees)
    return;
  
  for (Person *person in employees) {
    [self stopObservingPerson:person];
  }
  
  [a retain];
  [employees release];
  employees = a;
  for (Person *person in employees) {
    [self startObservingPerson:person];
  }
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
  [self startObservingPerson:p];
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
  
  [self stopObservingPerson:p];
  [employees removeObjectAtIndex:index];
}

- (void)startObservingPerson:(Person *)person {
  [person addObserver:self
           forKeyPath:@"personName"
              options:NSKeyValueObservingOptionOld
              context:NULL];
  
  [person addObserver:self
           forKeyPath:@"expectedRaise"
              options:NSKeyValueObservingOptionOld
              context:NULL];
}

- (void)stopObservingPerson:(Person *)person {
  [person removeObserver:self forKeyPath:@"personName"];
  [person removeObserver:self forKeyPath:@"expectedRaise"];
}

- (void)handleColorChange:(NSNotification *)note {
  NSLog(@"Received notification: %@", note);
}

- (void)changeKeyPath:(NSString *)keyPath
             ofObject:(id)obj
              toValue:(id)newValue {
  // setValue:forKeyPath: will cause the key-value observing method
  // to be called, which takes care of the undo stuff
  [obj setValue:newValue forKeyPath:keyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  NSUndoManager *undo = [self undoManager];
  id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
  
  // NSNull objects are used to represent nil in a dictionary
  if (oldValue == [NSNull null]) {
    oldValue = nil;
  }
  NSLog(@"oldValue = %@", oldValue);
  [[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath
                                                ofObject:object
                                                 toValue:oldValue];
  [undo setActionName:[NSString stringWithFormat:@"Edit to %@", [object personName]]];
}

- (NSString *)windowNibName {
  // Override returning the nib file name of the document
  // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
  return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController {
  [super windowControllerDidLoadNib:aController];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSData *colorAsData;
  colorAsData = [defaults objectForKey:YRDKTableBackgroundColor];
  
  [tableView setBackgroundColor:[NSKeyedUnarchiver unarchiveObjectWithData:colorAsData]];
}

- (NSData *)dataOfType:(NSString *)aType
                 error:(NSError **)outError {
  // End editing
  [[tableView window] endEditingFor:nil];
  
  // Create an NSData object from the employees array
  return [NSKeyedArchiver archivedDataWithRootObject:employees];
}

- (void)dealloc {
  [self setEmployees:nil];
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc removeObserver:self];
  [super dealloc];
}

@end
