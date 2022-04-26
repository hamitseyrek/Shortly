//
//  HomeVC.swift
//  Shortly
//
//  Created by Hamit Seyrek on 24.04.2022.
//

import UIKit
import Alamofire
import Combine

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shortenButton: UIButton!
    @IBOutlet weak var shortenLabel: UITextField!
    
    private let viewModel = HomeViewModel()
    
    var dataSource: [SingleResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shortenButton.layer.cornerRadius = 5
        
        tableView.dataSource = self
        tableView.delegate = self
        reloadTableView()
        
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
        
        reloadTableView()
    }
    
    func reloadTableView() {
        
        viewModel.getFromCoreData()
        dataSource = viewModel.dataSource
        
        if dataSource.count == 0 {
            tableView.register(UINib(nibName: "WelcomeCell", bundle: Bundle.main), forCellReuseIdentifier: "WCell")
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            tableView.register(UINib(nibName: "HistoryCell", bundle: Bundle.main), forCellReuseIdentifier: "HCell")
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        tableView.reloadData()
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.count == 0 {
            return 1
        } else {
            return dataSource.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataSource.count == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WCell", for: indexPath) as? WelcomeCell else {
                fatalError("Error dequing cell: MovieCell")
            }
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HCell", for: indexPath) as? HistoryCell else {
                fatalError("Error dequing cell: MovieCell")
            }
            cell.layer.cornerRadius = 20
            
            cell.originalLink.text = dataSource.reversed()[indexPath.row].code
            cell.shortLink.text = dataSource.reversed()[indexPath.row].fullShortLink2
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataSource.count == 0 {
            return self.tableView.frame.height
        } else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if dataSource.count == 0 {
            
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            return headerView
        } else {
            
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
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if dataSource.count == 0 {
            return 0
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if dataSource.count != 0 {
            
            viewModel.delFromCoreData(code: dataSource[indexPath.row].code)
            dataSource.remove(at: indexPath.row)
            self.reloadTableView()
        }
    }
}
