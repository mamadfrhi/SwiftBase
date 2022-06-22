//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by iMamad on 23.05.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    private var countries = [String]()
    private var score = 0
    private var correctAnswer = 0
    private var questionAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco","nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        configBarButton()
        askQuestion()
    }
    
    private func askQuestion(action: UIAlertAction! = nil) {
        if questionAsked == 5 {
            showResultAlertAction()
            return
        }
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]),
                         for: .normal)
        button2.setImage(UIImage(named: countries[1]),
                         for: .normal)
        button3.setImage(UIImage(named: countries[2]),
                         for: .normal)
        
        title = countries[correctAnswer].uppercased() + " / \(score)"
        questionAsked += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        let tag = sender.tag
        
        if tag == correctAnswer {
            title = "Correct"
            score += 1
        }else {
            let selectedCountry = countries[tag]
            title = "Wrong!\nIt's flag of \(selectedCountry.uppercased())"
            score -= 1
        }
        
        showAlertAction(title: title)
    }
    
    private func showResultAlertAction() {
        let ac = UIAlertController(title: "Result",
                                   message: "In this round you gained \(score) scores!",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Play Again!", style: .destructive, handler: resetGame))
        present(ac, animated: true)
    }
    
    @objc private func showAlertAction(title: String) {
        let ac = UIAlertController(title: title,
                                   message: "Your score is \(score)",
                                   preferredStyle: .alert)
        let handler = (title == "") ? nil : askQuestion
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: handler))
        present(ac, animated: true)
    }
    
    private func resetGame(action: UIAlertAction! = nil) {
        score = 0
        correctAnswer = 0
        questionAsked = 0
        askQuestion()
    }
    
    private func configBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(barButtonPressed))
    }
    @objc private func barButtonPressed() {
        showAlertAction(title: "")
    }
}
