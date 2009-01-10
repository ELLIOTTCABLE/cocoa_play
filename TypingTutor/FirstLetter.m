//
//  FirstLetter.m
//  TypingTutor
//

#import "FirstLetter.h"

@implementation NSString (FirstLetter)

- (NSString *)YR_firstLetter {
  if ([self length] <= 1)
    return self;
  NSRange r;
  r.location = 0;
  r.length = 1;
  return [self substringWithRange:r];
}

@end
