// core packages
import CoreLocation
import UIKit
// 3rd party packages
import GoogleMobileAds
import PrebidMobile

class PrebidBanner: UIView {
  
  // global vars
  var coreLocation: CLLocationManager?
  var sizes = ["banner", "leaderboard", "mediumRectangle"]
  var isInitialized = false
//  let request = DFPRequest()
//  var dfpBanner: DFPBannerView!
  
  // init
  override init(frame: CGRect) {
    super.init(frame: frame)
    // will be late, but do it here to see if it will work
    Prebid.shared.prebidServerHost = PrebidHost.Rubicon;
    Prebid.shared.prebidServerAccountId = "1001"// "13116";
    Prebid.shared.shareGeoLocation = true
//    coreLocation = CLLocationManager()
//    coreLocation?.requestWhenInUseAuthorization()
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
    // dfpBannerView.adUnitID = "7009/mapp.noticias_section_noticias/inicio"
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
    
//    dfpBanner = DFPBannerView(adSize: kGADAdSizeMediumRectangle)
//    dfpBanner.adUnitID = "/7009/mapp.noticias_section_noticias/inicio"
////    dfpBanner.rootViewController = self
////    dfpBanner.delegate = self
//    dfpBanner.backgroundColor = .red
//    self.addSubview(dfpBanner)
//    request.testDevices = [(kGADSimulatorID as! String), "cc7ca766f86b43ab6cdc92bed424069b"]
//
//    bannerUnit.fetchDemand(adObject: self.request) { [weak self] (resultCode: ResultCode) in
//        print("Prebid demand fetch for DFP \(resultCode.name())")
//        self?.dfpBanner!.load(self?.request)
//    }

//  }

  
  

  
}
