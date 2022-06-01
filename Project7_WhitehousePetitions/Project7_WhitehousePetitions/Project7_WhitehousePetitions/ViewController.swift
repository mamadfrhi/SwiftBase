//
//  ViewController.swift
//  Project7_WhitehousePetitions
//
//  Created by iMamad on 01.06.22.
//

import UIKit

class ViewController: UITableViewController {
    
    private var petitions = [Petition]()
    private var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtons()
        
        let urlString : String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let jsonData = try? Data(contentsOf: url) {
                parse(json: jsonData)
                return
            }
        }
        showError()
    }
    
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }
}

// MARK: Bar Buttons
extension ViewController {
    private func addBarButtons() {
        addSearchButton()
        addCreditsButton()
    }
    
    private func addSearchButton() {
        let searchBarButton = UIBarButtonItem(barButtonSystemItem: .search,
                                              target: self,
                                              action: #selector(showSearch))
        navigationItem.rightBarButtonItem = searchBarButton
    }
    
    private func addCreditsButton() {
        let creditBarButton = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                              target: self,
                                              action: #selector(showCredit))
        navigationItem.leftBarButtonItem = creditBarButton
    }
}

// MARK: Show Alert Controllers
extension ViewController {
    private func showError() {
        let ac = UIAlertController(title: "Loading Error",
                                   message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc private func showSearch() {
        let ac = UIAlertController(title: "What are you searching for?",
                                   message: nil,
                                   preferredStyle: .alert)
        ac.addTextField()
        
        let action = UIAlertAction(title: "Search",
                                   style: .default) { [weak ac, weak self] _ in
            guard let searchValue = ac?.textFields?[0].text else { return }
            self?.search(searchValue)
        }
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    @objc private func showCredit() {
        let ac = UIAlertController(title: "Credit",
                                   message: "The data of this application comes from Whitehouse's API",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc private func search(_ value: String) {
        filteredPetitions = petitions.filter{
            $0.body.contains(value) ? true : false
        }
        tableView.reloadData()
    }
}

// MARK: TableView DataSource
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

