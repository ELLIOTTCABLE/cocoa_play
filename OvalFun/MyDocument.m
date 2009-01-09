//
//  MyDocument.m
//  OvalFun
//

#import "MyDocument.h"

@implementation MyDocument

- (id)init {
  if (![super init])
    return nil;
  
  ovals = [[NSMutableSet setWithCapacity:25] retain];
  NSLog(@"- init] created ovals: %@", ovals);
  
  return self;
}

@synthesize ovals;

- (NSString *)windowNibName {
  return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController {
  [super windowControllerDidLoadNib:aController];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
  NSLog(@"- dataOfType:%@ error:]", typeName);
  NSMutableSet *ovalsAsStrings = [NSMutableSet setWithCapacity:[ovals count]];
  NSEnumerator *ovalsEnumerator = [ovals objectEnumerator];
  NSValue *value = nil;
  while (value = [ovalsEnumerator nextObject]) {
    [ovalsAsStrings addObject:NSStringFromRect([value rectValue])];
  }
  
  return [NSKeyedArchiver archivedDataWithRootObject:ovalsAsStrings];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
  NSLog(@"- readFromData:ofType:%@ error:]", typeName);
  NSMutableSet *ovalsAsStrings = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  NSEnumerator *stringsEnumerator = [ovalsAsStrings objectEnumerator];
  NSString *string = nil;
  while (string = [stringsEnumerator nextObject]) {
    [ovals addObject:[NSValue valueWithRect:NSRectFromString(string)]];
  }
  
  return YES;
}

@end
