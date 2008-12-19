//
//  Foo.h
//  RandomApp
//
//  Created by elliottcable on 12/18/08.
//  Copyright 2008 yreality. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Foo : NSObject {
  IBOutlet NSTextField *textField;
}

- (IBAction)seed:(id)sender;
- (IBAction)generate:(id)sender;

@end
