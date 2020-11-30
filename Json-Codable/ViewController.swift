//
//  ViewController.swift
//  Json-Codable
//
//  Created by Mahmoud Nasser on 30/11/2020.
//

import UIKit

class ViewController: UITableViewController {

    //MARK: Variables
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var petitionsToShow = [Petition]()
    
    var isSearching:Bool = false
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString:String = route()
        
        addCreditsBarBtn()
        addSearchBar()
        
        if let data = fetchData(fromUrl: urlString) {
            parseJson(json: data)
        } else {
            showError()
        }
        
        petitionsToShow = petitions
        
    }
    
    //MARK: UIFunctions
    func route()->String{
        if navigationController?.tabBarItem.tag == 0{
             return "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            return "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
    }
    
    func addCreditsBarBtn(){
       navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showCredits))
    }
    
    func addSearchBar(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    //MARK: Functions
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
            return
        }
        showError()
    }
    //MARK: Objective C functions
    @objc func showCredits(){
        let ac = UIAlertController(title: "Credits", message: "he data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        ac.addAction(okAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    
    //MARK: table view functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitionsToShow.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pitition = petitionsToShow[indexPath.row]
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

extension ViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = String(searchController.searchBar.text!)
        print(searchText)
        filteredPetitions = petitions.filter({ (item) -> Bool in
            item.title.localizedCaseInsensitiveContains(searchText)
        })
        petitionsToShow = !searchText.isEmpty ? filteredPetitions : petitions
        tableView.reloadData()
    }
}
