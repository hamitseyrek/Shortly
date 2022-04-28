//
//  HomeViewModel.swift
//  Shortly
//
//  Created by Hamit Seyrek on 25.04.2022.
//

import UIKit
import Alamofire
import CoreData

class HomeViewModel {
        
    var dataSource: [SingleResult] = []
        
    var singleResult: SingleResult?
    
    func getLinkInfo(shortenLink: String) -> Void {
        
        ApiService().getInfo(shortenLink: shortenLink) { result in
            
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let singleResult):
                if let singleResult = singleResult?.result {
                    DispatchQueue.main.async { [weak self] in
                        self?.singleResult = singleResult
                        self?.saveToCoreData()
                        print("burada1")
                    }
                }
            }
        }
    }
    
    func saveToCoreData() -> Void {
        
        guard let singleResult = singleResult else { return }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyLinks")
        fetchRequest.predicate = NSPredicate (format: "code = '\(singleResult.code)'")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(fetchRequest)

            if results.count == 0 {
                
                let saveData = NSEntityDescription.insertNewObject(forEntityName: "MyLinks", into: context)
                saveData.setValue(singleResult.code, forKey: "code")
                saveData.setValue(singleResult.fullShortLink2, forKey: "fullShortLink2")
                saveData.setValue(singleResult.originalLink, forKey: "originalLink")
                
                do {
                    try context.save()
                } catch let err {
                    print("Something went wrong 3", err)
                }
            }
        } catch {
            
        }
        
        
    }
        
    func getFromCoreData() {
        
        dataSource = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyLinks")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let originalLink = result.value(forKey: "originalLink") as? String {
                    if let code = result.value(forKey: "code") as? String {
                        if let fullShortLink2 = result.value(forKey: "fullShortLink2") as? String {
                            dataSource.append(SingleResult(code: code, fullShortLink2: fullShortLink2, originalLink: originalLink))
                        }
                    }
                }
            }
        } catch {
            print("Something went wrong 1")
        }
    }
    
    func delFromCoreData(code: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyLinks")

        fetchRequest.predicate = NSPredicate (format: "code = '\(code)'")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(fetchRequest)

            for result in results as! [NSManagedObject] {
                if let _ = result.value(forKey: "code") as? String {
                    
                    context.delete(result)
                    getFromCoreData()
                    do {
                        try context.save()
                    } catch {
                        
                    }
                }
            }
        } catch {
                print("Something went wrong 2")        }
    }
}


