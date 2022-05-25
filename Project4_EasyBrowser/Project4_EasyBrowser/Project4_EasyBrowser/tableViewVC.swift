//
//  TableViewController.swift
//  Project4_EasyBrowser
//
//  Created by iMamad on 25.05.22.
//

import UIKit

class tableViewVC: UITableViewController {

    private var websites = ["youtube.com", "apple.com", "hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites"
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
        let webVC = WebVC()
        let row = indexPath.row
        websites.insert(websites[row], at: 0)
        websites.remove(at: row)
        webVC.websites = websites
        navigationController?.pushViewController(webVC, animated: true)
    }
}
