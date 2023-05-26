//
//  TheaterViewController.swift
//  MoviesAPI
//
//  Created by user232105 on 4/18/23.
//

import Foundation
import UIKit

class TheaterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var theaterTable: UITableView!
    var responses = [InTheaterResponse]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("In Theater")
        theaterTable.backgroundColor = UIColor.black
        let url = "https://imdb-api.com/en/API/InTheaters/k_mwycke97"
        NetworkingManager.shared.getAPIData(url: url) { result in
            
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                    
                    break
                    
                case .success(let data):
                    print(data)
                    do {
                        let jsonDecoder = JSONDecoder()
                        
                        let response = try jsonDecoder.decode(InTheaterReply.self, from: data)
                        self.responses = response.items
                        self.theaterTable.reloadData()
                        print(self.responses.count)
                        //self.searchResultLabel.text = "\(response.results.count) results"
                        //self.searchTable.reloadData()
                        
                    } catch {
                        print("Error")
                    }
                    
                    //self.allCitiesFromAPI =   JsonManager.shared.fromJsonDataTOCityArray(jsonData: data)
                    //self.tableView.reloadData()
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
        let cell = theaterTable.dequeueReusableCell(withIdentifier: "inTheaterCell", for: indexPath)
       
        
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
        
        if segue.identifier == "theaterDetailSegue" {
            let detailVC = segue.destination as! TheaterDetailController
            detailVC.movie =  responses[theaterTable.indexPathForSelectedRow!.row]
            print(detailVC.movie)
            
        }
        let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem    }
    
}


