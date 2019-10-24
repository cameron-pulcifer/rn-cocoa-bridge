@objc(RNBannerViewManager)
class RNBannerViewManager: RCTViewManager {
  override func view() -> UIView! {
    return PrebidBanner()
  }
  
  // gets rid of warning in simulator
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
