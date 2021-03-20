//
//  ViewController.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/1/22.
//

import UIKit

class ViewController: UIViewController {

//    var bannersData = [BannerModel]()
//
//    var privateData = [PrivateCustomModel]()
//
//    lazy var adScrollerBanner: JJNewsBanner = {
//        let banner = JJNewsBanner(frame: CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 200))
//        banner.currentPageDotColor = UIColor.white
//        banner.pageDotColor = UIColor.gray
//        banner.autoScrollTimeInterval = 5.0
//        banner.pageControlDotSize = CGSize(width: 10, height: 10)
//
//        return banner
//    }()
//
//    lazy var privateSongListView: PrivateCustomView = {
//        let view = PrivateCustomView(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 300), data: privateData)
//        return view
//    }()
    
    
    private var tableList: UITableView!
    
    private var simpleCubeView: SimpleCubeViewController!
    private var waterFallView: WaterFallViewController!
    private var coverFlowView: CoverFlowViewController!
    private var baseApiView: BaseAPIViewController!
    private var bookShelfView: BookShelfViewController!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        tableList = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        tableList.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        tableList.delegate = self
        tableList.dataSource = self
        self.view.addSubview(tableList)
        
        
        
//        // +++++++++++++++++++++++++++++ 轮播图 ++++++++++++++++++++++++++++++++++++++
//        self.view.addSubview(adScrollerBanner)
//
//        let model1: BannerModel = BannerModel(pic: "https://p1.music.126.net/g7O3fXseRtDKfiqLpQSV-g==/109951165439360647.jpg")
//        let model2: BannerModel = BannerModel(pic: "https://p1.music.126.net/TW3OuCmEZfxI6EWAJjp0Kg==/109951165626512352.jpg")
//        let model3: BannerModel = BannerModel(pic: "https://p1.music.126.net/Q9MXwiNR8oKuR_Zd5pncJw==/109951165043282575.jpg")
//        let model4: BannerModel = BannerModel(pic: "https://p1.music.126.net/3xjiLJOe4QflowFMm2Of4Q==/109951165636689592.jpg")
//        let model5: BannerModel = BannerModel(pic: "https://p1.music.126.net/PJylNWy_2-jI7LRgQ2Cm6w==/109951165649129522.jpg")
//        let model6: BannerModel = BannerModel(pic: "https://p1.music.126.net/JqcjsT2bqtLqnpe8W7didg==/109951163680713819.jpg")
//        let model7: BannerModel = BannerModel(pic: "https://p1.music.126.net/IHbAYpNSMTvGt0oLS3QMUw==/109951165584948265.jpg")
//        let model8: BannerModel = BannerModel(pic: "https://p1.music.126.net/bfjxpm2L1JLAP3S02Jwduw==/109951165634942723.jpg")
//
//        adScrollerBanner.updateUI(imageUrlStrArray: [model1,model2,model3,model4,model5,model6,model7,model8], placeholderImage: UIImage(named: "ad_placeholder"))
//
//        // +++++++++++++++++++++++++++++ 分页 ++++++++++++++++++++++++++++++++++++++
//        let songMode1: SongModel = SongModel(image: "http://p2.music.126.net/1gNcBmzdIaQtU00Dvp_TvQ==/109951163912081772.jpg", order: 1, songName: "一路向北", singer: "周杰伦", extra: "新")
//        let songMode2: SongModel = SongModel(image: "http://p2.music.126.net/1gNcBmzdIaQtU00Dvp_TvQ==/109951163912081772.jpg", order: 1, songName: "一路向北", singer: "周杰伦", extra: "新")
//        let songMode3: SongModel = SongModel(image: "http://p2.music.126.net/1gNcBmzdIaQtU00Dvp_TvQ==/109951163912081772.jpg", order: 1, songName: "一路向北", singer: "周杰伦", extra: "新")
//
//        // 刷新
//        let songs: [SongModel] = [songMode1, songMode2, songMode3]
//        let privateModel: PrivateCustomModel = PrivateCustomModel(songsList: songs)
//        privateData = [privateModel, privateModel, privateModel]
//
//        self.view.addSubview(privateSongListView)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            simpleCubeView = SimpleCubeViewController()
            self.navigationController!.pushViewController(simpleCubeView, animated: true)
        } else if indexPath.row == 1 {
            waterFallView = WaterFallViewController()
            self.navigationController!.pushViewController(waterFallView, animated: true)
        } else if indexPath.row == 2 {
            coverFlowView = CoverFlowViewController()
            self.navigationController!.pushViewController(coverFlowView, animated: true)
        } else if indexPath.row == 3 {
            baseApiView = BaseAPIViewController()
            self.navigationController?.pushViewController(baseApiView, animated: true)
        } else if indexPath.row == 4 {
            bookShelfView = BookShelfViewController()
            self.navigationController?.pushViewController(bookShelfView, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "大小方块"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "瀑布流"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Cover Flow"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "追加视图"
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "装饰视图"
        } else {
            cell.textLabel?.text = "其他"
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
