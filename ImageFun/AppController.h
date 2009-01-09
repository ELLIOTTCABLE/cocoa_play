//
//  AppController.h
//  ImageFun
//

#import <Cocoa/Cocoa.h>

@interface AppController : NSObject {
  IBOutlet StretchView *stretchView;
}
- (IBAction)showOpenPanel:(id)sender;
@end
