//
//  HomeViewController.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/5.
//

import UIKit

class HomeViewController: UINavigationController {

    private var tableList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.backgroundColor = .blue
    
        tableList = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        tableList.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        tableList.delegate = self
        tableList.dataSource = self

        self.view.addSubview(tableList)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
//            simpleCubeView = SimpleCubeViewController()
//            self.present(simpleCubeView, animated: true) {
//
//            }
            //self.navigationController?.pushViewController(simpleCubeView, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        if (indexPath.row == 0){
            cell.textLabel?.text = "效果1"
        } else if (indexPath.row == 1){
            cell.textLabel?.text = "效果2"
        } else {
            cell.textLabel?.text = "其他"
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
