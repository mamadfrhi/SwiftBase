//
//  TableViewController.swift
//  Project4_EasyBrowser
//
//  Created by iMamad on 25.05.22.
//

import UIKit

class TableViewVC: UITableViewController {

    private var websites = ["youtube.com", "apple.com", "hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SiteCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        let chosenWebsite = websites[row]
        websites.remove(at: row)
        websites.insert(chosenWebsite, at: 0)
        
        let webVC = WebVC()
        webVC.websites = websites
        navigationController?.pushViewController(webVC, animated: true)
    }
}
