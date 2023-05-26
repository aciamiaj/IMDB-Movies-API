//
//  SearchHistoryViewController.swift
//  MoviesAPI
//
//  Created by user232105 on 2023-04-19.
//

import Foundation
import UIKit
import CoreData

class SearchHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet weak var searchesTable: UITableView!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var searches = [Searches]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request: NSFetchRequest<Searches> = Searches.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        guard let searchesCD = try? managedContext.fetch(request) else {
            print("ERROR During getting all places")
            return
        }
        
        searches = searchesCD
        searchesTable.backgroundColor = UIColor.black
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchesTable.dequeueReusableCell(withIdentifier: "searchHistoryCell", for: indexPath)
        
        let search = searches[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.string(for: search.date!)
        
        let title = "\(search.search!) on \(date!)"
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = "\(search.result) results find"
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    
}
