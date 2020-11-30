//
//  ViewController.swift
//  Json-Codable
//
//  Created by Mahmoud Nasser on 30/11/2020.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString:String!
        
        if navigationController?.tabBarItem.tag == 0{
             urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
             urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
       
        if let data = fetchData(fromUrl: urlString) {
            parseJson(json: data)
        }
        
    }
    
    
    
    func fetchData(fromUrl urlString:String)->Data?{
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url){
                return data
            }
        }
        
        return nil
    }
    
    func parseJson(json:Data){
        let decoder = JSONDecoder()
        if let jsonData = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonData.results
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pitition = petitions[indexPath.row]
        cell.textLabel?.text = pitition.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = pitition.body
            return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

