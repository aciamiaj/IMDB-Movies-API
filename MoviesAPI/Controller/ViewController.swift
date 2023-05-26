//
//  ViewController.swift
//  MoviesAPI
//
//  Created by user232105 on 4/18/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var searchResultLabel: UILabel!
    
    @IBOutlet weak var searchTable: UITableView!
    
    var responses = [SearchResponse]()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchField.text = ""
        searchResultLabel.text = ""
        searchTable.backgroundColor = UIColor.black
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
        
        if searchField.text == nil {
            return
        }
        let search = searchField.text!
        
        callSearchApi(search: search)
        
    }
    
    func callSearchApi(search: String) {
        
        print("start search")
        let url = "https://imdb-api.com/en/API/Search/k_mwycke97/\(search)"
        NetworkingManager.shared.getAPIData(url: url) { result in
            
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                    //self.allCitiesFromAPI = [City]()
                    //self.tableView.reloadData()
                    break
                    
                case .success(let data):
                    print(data)
                    
                    do {
                        print("0")
                        let jsonDecoder = JSONDecoder()
                        print("1")
                        let response = try jsonDecoder.decode(ApiReply.self, from: data)
                        print("2")
                        self.responses = response.results
                        print("3")
                        self.searchResultLabel.text = "\(response.results.count) results"
                        
                        // Save the result to Core Data
                        let cdSearch = Searches(context: self.managedContext)
                        cdSearch.id = UUID()
                        cdSearch.search = search
                        cdSearch.date = Date()
                        cdSearch.result = Int64(response.results.count)
                        try self.managedContext.save()
                        
                        self.searchTable.reloadData()
                        print(response)
                        
                    } catch let error {
                        print("Error: \(error)")
                    }
                    
                    break
                    
                }
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTable.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
       
        
        let title = "\(responses[indexPath.row].title)"
        cell.textLabel?.text = title
        //cell.detailTextLabel?.text = "$\(price)"
        cell.textLabel?.textAlignment = .left
        //cell.detailTextLabel?.textAlignment = .right
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            let detailVC = segue.destination as! MovieDetailController
            detailVC.movie =  responses[searchTable.indexPathForSelectedRow!.row]
            
        }
        let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem    }
        
    }
    
    

