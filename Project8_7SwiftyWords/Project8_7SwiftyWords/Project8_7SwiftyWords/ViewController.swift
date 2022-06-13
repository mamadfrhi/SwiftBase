//
//  ViewController.swift
//  Project8_7SwiftyWords
//
//  Created by iMamad on 03.06.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    private var cluesLabel: UILabel!
    private var answersLabel: UILabel!
    private var currentAnswer: UITextField!
    private var scoreLabel: UILabel!
    private var letterButtons = [UIButton]()
    private var buttonsView : UIView!
    
    private var activatedButtons = [UIButton]()
    private var solutions = [String]()
    
    private var score = 0.0 {
        didSet {
            if score < 0 { score = 0 }
            scoreLabel.text = "Score: \(score)"
        }
    }
    private var level = 1
    private var correctAnswers = 0
}

// MARK: LifeCycle
extension ViewController {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        addLabels()
        addAnswerTextField()
        addConstraints()
        addAnswerButtons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
    }
}

// MARK: Leveling
extension ViewController {
    private func loadLevel() {
        DispatchQueue.global(qos: .userInteractive).async {
            [weak self] in guard let self = self else { return }
            
            var clueString = ""
            var solutionsString = ""
            var letterBits = [String]()
            
            if let levelFileURL = Bundle.main.url(forResource: "level\(self.level)", withExtension: "txt") {
                if let levelContents = try? String(contentsOf: levelFileURL) {
                    var lines = levelContents.components(separatedBy: "\n")
                    lines.shuffle()
                    
                    for (index, line) in lines.enumerated() {
                        let parts = line.components(separatedBy: ": ")
                        let answers = parts[0]
                        let clue = parts[1]
                        
                        clueString += "\(index + 1). \(clue)\n"
                        
                        let solutionWord = answers.replacingOccurrences(of: "|", with: "")
                        solutionsString += "\(solutionWord.count) letters\n"
                        self.solutions.append(solutionWord)
                        
                        let bits = answers.components(separatedBy: "|")
                        letterBits += bits
                    }
                }
            }
            
            letterBits.shuffle()
            
            let cluesLabelText = clueString.trimmingCharacters(in: .whitespacesAndNewlines) // it removes \n or space from the very end of the string
            let answersLabelText = solutionsString.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let labelsTextsTuple = (cluesLabelText, answersLabelText)

            
            self.performSelector(onMainThread: #selector(self.setLabelText(labelsTextsTuple:)), with: labelsTextsTuple, waitUntilDone: false)
            self.performSelector(onMainThread: #selector(self.setButtonsTexts(letterBits:)), with: letterBits, waitUntilDone: false)
        }
    }
    
    @objc private func setLabelText(labelsTextsTuple: (Any)) {
        if let labelsTextsTuple = labelsTextsTuple as? (String, String) {
            cluesLabel.text = labelsTextsTuple.0
            answersLabel.text = labelsTextsTuple.1
        }
    }
    
    @objc private func setButtonsTexts(letterBits: Any) {
        
        guard let letterBits = letterBits as? [String] else { return }
        
        if letterButtons.count == letterBits.count {
            for i in 0 ..< letterButtons.count {
                let button = letterButtons[i]
                let title = letterBits[i]
                button.setTitle(title, for: .normal)
            }
        }
    }
}

// MARK: UIAlert Actions
extension ViewController {
    @objc private func levelUp(action: UIAlertAction) {
        level += 1
        
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
        }
    }
    
    @objc private func tryAgainTapped(action: UIAlertAction) {
        clearTapped(UIButton())
    }
}

// MARK: - Add views
extension ViewController {
    private func addLabels() {
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
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
        //                     👆🏼Hugging => view prevents to grow
        // answersLabel.contentCompressionResistancePriority(for: .vertical)
        //                     👆🏼Compression Resistance => view prevents to shrink
        view.addSubview(answersLabel)
    }
    
    private func addAnswerTextField() {
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
    }
    
    private func addConstraints() {
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(buttonsView)
        
        // margin means 8-10 points inner or outer
        // from a edge of a view
        // e.g.     safeArea          .leadingAnchor is exactly at the very left of the view
        // HOWEVER, layoutMarginsGuide.leadingAnchor is exactly at the very left of the view + 8 points
        
        NSLayoutConstraint.activate(
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
                buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            ]
        )
    }
    
    private func addAnswerButtons() {
        
        let buttonHeight = 80
        let buttonWidth = 150
        
        // create 20 buttons as a 4x5 grid
        for row in 0 ..< 4 {
            for column in 0 ..< 5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: buttonWidth * column, y: buttonHeight * row,
                                   width: buttonWidth, height: buttonHeight)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }
}

// MARK: - UIButton Actions
extension ViewController {
    @objc private func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc private func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        
        if let solutionPosition = solutions.firstIndex(of: answerText) { // correct
            
            currentAnswer.text = ""
            score += 1
            correctAnswers += 1
            
            activatedButtons.removeAll()
            
            // update answersLabel
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            
            if correctAnswers == solutions.count {
                // show alert
                let ac = UIAlertController(title: "Well done!",
                                           message: "Are you ready for the next level?",
                                           preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!",
                                           style: .default,
                                           handler: levelUp))
                present(ac, animated: true)
            }
        } else { // false
            score -= 0.5
            let ac = UIAlertController(title: "No no no!",
                                       message: "Entered solutions isn't correct!",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try again.",
                                       style: .default,
                                       handler: tryAgainTapped))
            present(ac, animated: true)
        }
    }
    
    @objc private func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        
        for button in activatedButtons {
            button.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
}

// https://www.youtube.com/watch?v=InHeXXy3NFc
// *************** Good Tips ***************
// Content Hugging Priority =
// view resists to resize larger than its intrinsic size - high means AutoLayout prefers to NOT stretch it.
// default = 250

// Content Compression Resistance Priority =
// view resists to resize smaller than its intrinsic size
// default = 750

// Higher priorities means AutoLayout tries hard to satisfy them


// layoutMarginsGuide is inside the safeAreaLayoutGuide, so it will be slightly smaller.

