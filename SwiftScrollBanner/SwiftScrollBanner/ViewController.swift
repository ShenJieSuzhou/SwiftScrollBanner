//
//  ViewController.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/1/22.
//

import UIKit

class ViewController: UIViewController {

    lazy var adScrollerBanner: JJNewsBanner = {
        let banner = JJNewsBanner(frame: CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 200))
        banner.currentPageDotColor = UIColor.white
        banner.pageDotColor = UIColor.gray
        banner.autoScrollTimeInterval = 5.0
        banner.pageControlDotSize = CGSize(width: 10, height: 10)
        
        return banner
    }()
    
    var bannersData = [BannerModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(adScrollerBanner)
        
        let model1: BannerModel = BannerModel(pic: "https://p1.music.126.net/g7O3fXseRtDKfiqLpQSV-g==/109951165439360647.jpg")
        let model2: BannerModel = BannerModel(pic: "https://p1.music.126.net/TW3OuCmEZfxI6EWAJjp0Kg==/109951165626512352.jpg")
        let model3: BannerModel = BannerModel(pic: "https://p1.music.126.net/Q9MXwiNR8oKuR_Zd5pncJw==/109951165043282575.jpg")
        let model4: BannerModel = BannerModel(pic: "https://p1.music.126.net/3xjiLJOe4QflowFMm2Of4Q==/109951165636689592.jpg")
        let model5: BannerModel = BannerModel(pic: "https://p1.music.126.net/PJylNWy_2-jI7LRgQ2Cm6w==/109951165649129522.jpg")
        let model6: BannerModel = BannerModel(pic: "https://p1.music.126.net/JqcjsT2bqtLqnpe8W7didg==/109951163680713819.jpg")
        let model7: BannerModel = BannerModel(pic: "https://p1.music.126.net/IHbAYpNSMTvGt0oLS3QMUw==/109951165584948265.jpg")
        let model8: BannerModel = BannerModel(pic: "https://p1.music.126.net/bfjxpm2L1JLAP3S02Jwduw==/109951165634942723.jpg")
    
        
        adScrollerBanner.updateUI(imageUrlStrArray: [model1,model2,model3,model4,model5,model6,model7,model8], placeholderImage: UIImage(named: "ad_placeholder"))
    }


}

