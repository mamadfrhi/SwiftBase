//
//  ViewController.swift
//  Project5_WordScramble
//
//  Created by iMamad on 25.05.22.
//

import UIKit

class ViewController: UITableViewController {

    private var allWords = [String]()
    private var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        prepareAllWordsArray()
        startGame()
    }
    
    // preparation
    private func configNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                           target: self,
                                                           action: #selector(startGame))
    }
    private func prepareAllWordsArray() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
    }
    @objc private func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc private func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    private func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isLongEnough(word: lowerAnswer){
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        usedWords.insert(lowerAnswer, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        return
                    } else { // isReal failed
                        showErrorAlert(title: "Word not recognized",
                                  message: "You can't just make them up, you know!")
                    }
                } else { // is original failed
                    showErrorAlert(title: "Word already used",
                              message: "Be more original")
                }
            } else {// is real failed
                showErrorAlert(title: "Word not possible",
                          message: "You can't spell \(answer) word from \(title!.lowercased())")
            }
        } else { // is long enough failed
            showErrorAlert(title: "Word is too short",
                      message: "Your word should has more than 3 letters.")
        }
        
        
    }
    private func showErrorAlert(title: String, message: String) {
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK!", style: .default))
        present(ac, animated: true)
    }
    
    // conditions
    private func isLongEnough(word: String) -> Bool {
        word.count > 3
    }
    private func isPossible(word: String) -> Bool {
        
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    private func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    private func isReal(word: String) -> Bool {
        if (word == title) { return false }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: "en")
        return misspelledRange.location == NSNotFound
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
}

