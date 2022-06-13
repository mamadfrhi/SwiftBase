//
//  ViewController.swift
//  Project7_WhitehousePetitions
//
//  Created by iMamad on 01.06.22.
//

import UIKit

class ViewController: UITableViewController {
    
    private var petitions = [Petition]()
    private var filteredPetitions = [Petition]() {
        didSet {
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData),
                            with: nil, waitUntilDone: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtons()
        setTitles()
        performSelector(inBackground: #selector(fetchData), with: nil)
    }
}

// MARK: Prepare VC
extension ViewController {
    @objc private func fetchData() {
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
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    private func setTitles() {
        if navigationController?.tabBarItem.tag == 0 {
            title = "Petitions"
        } else {
            title = "Top Rated Petitions"
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
    @objc private func showError() {
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
        
        let searchAction = UIAlertAction(title: "Search",
                                         style: .cancel) {
            [weak ac, weak self] _ in
            guard let self = self, let searchValue = ac?.textFields?[0].text else { return }
            
            self.performSelector(inBackground: #selector(self.search), with: searchValue)
        }
        let resetSearchAction = UIAlertAction(title: "Reset search",
                                              style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.filteredPetitions = self.petitions
        }
        
        ac.addAction(searchAction)
        ac.addAction(resetSearchAction)
        present(ac, animated: true)
    }
    
    @objc private func showCredit() {
        let ac = UIAlertController(title: "Credit",
                                   message: "The data of this application comes from Whitehouse's API",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc private func search(_ value: Any) {
        if let searchValue = value as? String {
            filteredPetitions = petitions.filter {
                $0.body.contains(searchValue) ? true : false
            }
        }
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

