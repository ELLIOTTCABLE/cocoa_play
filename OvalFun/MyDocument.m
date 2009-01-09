//
//  MyDocument.m
//  OvalFun
//

#import "MyDocument.h"

@implementation MyDocument

- (id)init {
  if (![super init])
    return nil;
  return self;
}

- (NSString *)windowNibName {
  return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController {
  [super windowControllerDidLoadNib:aController];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    if (outError) *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    if (outError) *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    return YES;
}

@end
