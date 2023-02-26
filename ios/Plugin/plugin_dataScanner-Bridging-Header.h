//
//  plugin_dataScanner-Bridging-Header.h
//  plugin_dataScanner
//
//  Created by Scott Harrison on 2/20/23.
//

#ifndef PluginFramework_Bridging_Header_h
#define PluginFramework_Bridging_Header_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <CoronaLua.h>
@class Scanner;

@interface Scanner : NSObject

-(Scanner*)init;
-(void)startScanning;
-(void)stopScanning;
-(UIViewController*)makeUIViewController:(BOOL)isHighFrameRateTrackingEnabled isHighlightingEnabled:(BOOL)isHighlightingEnabled recognizesMultipleItems:(BOOL)recognizesMultipleItems supportBarCode:(BOOL)supportBarCode supportText:(BOOL)supportText;

@end

@interface scannerHolder : UIViewController

@property(retain) Scanner* myScanner;
@property(retain) UIViewController* scannerView;
@property (nonatomic, assign) lua_State *myLuaState;
@property (nonatomic, assign) CoronaLuaRef myRef;
- (void) closeDataScanner;
- (void) gotText:(NSString*)text;
- (void) gotBarcode:(NSString*)barcode;
@end

#endif /* PluginFramework_Bridging_Header_h */
