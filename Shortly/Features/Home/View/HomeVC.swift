//
//  HomeVC.swift
//  Shortly
//
//  Created by Hamit Seyrek on 24.04.2022.
//

import UIKit
import Alamofire

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shortenButton: UIButton!
    @IBOutlet weak var shortenLabel: UITextField!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shortenButton.layer.cornerRadius = 5
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HistoryCell", bundle: Bundle.main), forCellReuseIdentifier: "HCell")
        tableView.contentInsetAdjustmentBehavior = .never
        
        
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = Helper().hexStringToUIColor(hex: "#F0F1F6")
            statusBar.tag = 100
            UIApplication.shared.keyWindow?.addSubview(statusBar)
            
        }
    }
    
    @IBAction func shortenClicked(_ sender: Any) {
        
        guard let shortenLink = shortenLabel.text else { return }
        
        viewModel.getLinkInfo(shortenLink: shortenLink)
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HCell", for: indexPath) as? HistoryCell else {
            fatalError("Error dequing cell: MovieCell")
        }
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = "Your Link History"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .center
        
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
