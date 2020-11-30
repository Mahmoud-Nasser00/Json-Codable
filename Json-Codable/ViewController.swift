//
//  ViewController.swift
//  Json-Codable
//
//  Created by Mahmoud Nasser on 30/11/2020.
//

import UIKit

class ViewController: UITableViewController {

    var petetions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petetions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "pettion title here"
            cell.detailTextLabel?.text = "petetion details goes here"
            return cell
        
    }
    
}

