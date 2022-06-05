//
//  ViewController.swift
//  Project8_7SwiftyWords
//
//  Created by iMamad on 03.06.22.
//

import UIKit

class ViewController: UIViewController {
    
    private var cluesLabel: UILabel!
    private var answersLabel: UILabel!
    private var currentAnswer: UITextField!
    private var scoreLabel: UILabel!
    private var letterButtons = [UIButton]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0 // take as many as lines you need to wrap the whole text
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate( // margin is out of safeArea
            [
                scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                
                cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
                cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
                
                answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
                answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
                answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
                
                currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
                
                submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
                submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
                submit.heightAnchor.constraint(equalToConstant: 44),
                
                clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
                clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
                clear.heightAnchor.constraint(equalToConstant: 44),
                
                buttonsView.widthAnchor.constraint(equalToConstant: 750),
                buttonsView.heightAnchor.constraint(equalToConstant: 320),
                buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
                buttonsView.bottomAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            ]
        )
        
        let buttonHeight = 80
        let buttonWidth = 150
        
        for row in 0 ..< 4 {
            for column in 0 ..< 5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                
                let frame = CGRect(x: buttonWidth * column, y: buttonHeight * row,
                                   width: buttonWidth, height: buttonHeight)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
        cluesLabel.backgroundColor = .red
        answersLabel.backgroundColor = .blue
        submit.backgroundColor = .green
        clear.backgroundColor = .yellow
        
        buttonsView.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(view.frame.size)
    }
}

// https://youtu.be/yhxhKpyyQzE?t=801
// Content Hugging Priority =
// view resists being made larger than its intrinsic size - high means AutoLayout refers to NOT streach it.
// default = 250

// Content Compression Resistance Priority =
// view resists being made smaller than its intrinsic size
// default = 750

// Higher priorities means AutoLayout tries hard to satisfy them
