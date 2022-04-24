//
//  HomeVC.swift
//  Shortly
//
//  Created by Hamit Seyrek on 24.04.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WelcomeCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        tableView.contentInsetAdjustmentBehavior = .never
        
        
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = Helper().hexStringToUIColor(hex: "#F0F1F6")
            statusBar.tag = 100
            UIApplication.shared.keyWindow?.addSubview(statusBar)
            
        }
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? WelcomeCell else {
            fatalError("Error dequing cell: MovieCell")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.tableView.frame.height
    }
}
