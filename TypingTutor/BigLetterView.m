//
//  BigLetterView.m
//  TypingTutor
//

#import "BigLetterView.h"

@implementation BigLetterView

- (id)initWithFrame:(NSRect)frame {
  NSLog(@"@BigLetterView - initWithFrame:]");
  if (![super initWithFrame:frame])
    return nil;
  return self;
}

- (void)drawRect:(NSRect)rect {
  NSLog(@"@BigLetterView - drawRect:]");
}

@end
