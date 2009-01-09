//
//  AppController.h
//  ImageFun
//

#import <Cocoa/Cocoa.h>
#import "StretchView.h"

@interface AppController : NSObject {
  IBOutlet StretchView *stretchView;
}
- (IBAction)showOpenPanel:(id)sender;
@end
