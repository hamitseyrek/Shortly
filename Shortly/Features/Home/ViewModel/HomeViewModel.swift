//
//  HomeViewModel.swift
//  Shortly
//
//  Created by Hamit Seyrek on 25.04.2022.
//

import UIKit
import Alamofire

class HomeViewModel {
    
    
    //@Published var mainResult: MainResult = MainResult(ok: true, result: SingleResult(code: "", fullShortLink2: "", originalLink: ""))
    
//    var page = 1
//    var totalPage = 0
//    var movieFull = false
    
    var singleResult: SingleResult?
    
    func getLinkInfo(shortenLink: String) {
        
        ApiService().getInfo(shortenLink: shortenLink) { result in
            
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let singleResult):
                if let singleResult = singleResult?.result {
                    DispatchQueue.main.async { [weak self] in
                        self?.singleResult = singleResult
                        print(singleResult, "+++++++++++")
                        self?.saveToCoreData()
                    }
                }
            }
        }
    }
    
    func saveToCoreData() -> Void {
        print("saved to core data")
    }
    
}
