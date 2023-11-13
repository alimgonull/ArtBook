//
//  ViewController.swift
//  ArtBook
//
//  Created by Alim Gönül on 16.09.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var idArray = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addBarButton))
        
        getData()
 
    }
    
    func getData(){
        // VERİ ÇEKME İŞLEMLERİ
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Painting")
        fetchRequest.returnsObjectsAsFaults = false
       
        do {
            
           let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name") as? String {
                    self.nameArray.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
                self.tableView.reloadData()
            }
            
        }catch {
            print("error")
        }
        
    }
    
    @objc func addBarButton(){
        performSegue(withIdentifier: "detailVc", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
        
        
    }
        
}

