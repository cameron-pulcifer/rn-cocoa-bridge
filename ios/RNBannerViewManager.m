#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(RNBannerViewManager, RCTViewManager)


RCT_EXPORT_VIEW_PROPERTY(adUnit, NSString);
RCT_EXPORT_VIEW_PROPERTY(bannerSize, NSString);
RCT_EXPORT_VIEW_PROPERTY(onClick, RCTBubblingEventBlock)

@end
