// core packages
import CoreLocation
import UIKit
// 3rd party packages
import GoogleMobileAds
import PrebidMobile

class PrebidBanner: UIView {

  // global vars
  var coreLocation: CLLocationManager?

  // init
  override init(frame: CGRect) {
    super.init(frame: frame)
    Prebid.shared.prebidServerHost = PrebidHost.Rubicon;
    Prebid.shared.prebidServerAccountId = "1001"
    Prebid.shared.shareGeoLocation = true
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // RN props
  @objc var bannerSize: NSString = "" {
    didSet {
      print("\nreached bannerSize didSet: \(bannerSize)\n")
      loadView()
    }
  }

  // RN props
  @objc var adUnit: NSString = "" {
    didSet {
      print("\nreached adUnit didSet: \(adUnit)\n")
      loadView()
    }
  }

  // exposed to RN as function
  @objc var onClick: RCTDirectEventBlock?

  func loadView() {

    if self.adUnit == "" || self.bannerSize == "" {
      print("\nProps not ready. Banner: \(self.bannerSize) | Ad Unit: \(self.adUnit)\n")
      return
    }

    if let viewWithTag = self.viewWithTag(100) {
      viewWithTag.removeFromSuperview()
    }

    if self.bannerSize == "destroy" {
      print("\n\nDestroyed \(self.subviews.count)\n\n")
      return
    }

    let adSize = self.getGadAdSize(self.bannerSize)

    // Create the ad unit(s) - this is an example for a Banner ad unit
    let bannerUnit = BannerAdUnit(
      configId: String(self.adUnit),
      size: adSize.size
    )

    print("Google Mobile Ads SDK version: \(DFPRequest.sdkVersion())")

    let request = DFPRequest()
    request.testDevices = [ kGADSimulatorID ];
    let dfpBannerView = DFPBannerView(adSize: adSize)
    dfpBannerView.tag = 100
    // dfpBannerView.adUnitID = "xxxxxxxxxxxx"
    dfpBannerView.rootViewController = UIApplication.shared.keyWindow!.rootViewController

    dfpBannerView.backgroundColor = .orange
    self.addSubview(dfpBannerView)

    bannerUnit.fetchDemand(adObject: request) { [weak self] (resultCode: ResultCode) in
      print("\n\nGOT HERE \(self!.subviews.count)\n\n")
      // Load the dfp request
      dfpBannerView.load(request)
    }

  }

  func getGadAdSize(_ name:NSString) -> GADAdSize {
    if name == "banner" {
      return kGADAdSizeBanner
    } else if name == "largeBanner" {
         return kGADAdSizeLargeBanner
    } else if name == "mediumRectangle" {
       return kGADAdSizeMediumRectangle
    } else if name == "fullBanner" {
       return kGADAdSizeFullBanner
    } else if name == "leaderboard" {
       return kGADAdSizeLeaderboard
    } else if name == "smartBannerPortrait" {
       return kGADAdSizeSmartBannerPortrait
    } else if name == "smartBannerLandscape" {
       return kGADAdSizeSmartBannerLandscape
    } else {
      return kGADAdSizeBanner
    }
  }

}
