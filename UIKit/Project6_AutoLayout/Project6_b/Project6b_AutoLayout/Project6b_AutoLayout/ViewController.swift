//
//  ViewController.swift
//  Project6b_AutoLayout
//
//  Created by iMamad on 31.05.22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLabelsUsingAnchors()
    }
    
    private func addLabelsUsingVFL() { // VFL: Visual Formatting Language
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        let viewsDictionary = [
            "label1" : label1,
            "label2" : label2,
            "label3" : label3,
            "label4" : label4,
            "label5" : label5,
        ]
        
        for label in viewsDictionary.keys {
            // | or pipe sign means edge of the parent view(here means ViewController.view)
            // [] or brackets means edges of the control's view(here means label)
            //                                                                           H means Horizontal NOT Height!
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|",
                                                               metrics: nil,
                                                               views: viewsDictionary))
        }
        
        let metrics = ["labelHeight" : 88]
        
        //                                                              V means Vertical
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:
                                                            "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: viewsDictionary))
        
        // |s works like above
        // - or dash make 10 points space between views by default
        // [label1(==88)] ,,, (==88) within [] means make labels' size equal 88
        // -(<=10)-| means make space FROM last label to the END of the screen grater than 10
        // when we want specify the size of the space(-), we must specify dashes before and after the size
        
        // Auto layout has constraint priority
        // the value is between 1-1000
        // 1000 means absolutely required, anything less than that is optional
        // it can be add to the constraints by @1-1000
        
        // here @999 added to the first label to make its Vertical size optional
        // in order to make it compatible with landscape mode.
        // (@999) means if the constraints engine would need to change size of the label, it CAN.
        // Then, copy other labels' sizes from the first label.
        // By this condition the constraint engine can change Vertical size of the first label
        // and make other labels' Vertical size equal to the first label.
        // So, all of the labels will spread over the view evenly.
    }
    
    private func addLabelsUsingAnchors() {
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        var previousLabel: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
            let spaceBetweenLabels = 10.0
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,
                                          multiplier: 0.2,
                                          constant: -spaceBetweenLabels).isActive = true
            // it🔝 means:
            // each label's height should be 1/5 or 0.2 OF THE safe area's height
            // minus space between labels
            
            if let previousLabel = previousLabel {
                label.topAnchor.constraint(equalTo: previousLabel.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            
            previousLabel = label
        }
    }
}

// https://www.youtube.com/watch?v=z7EvsqDwcT4
// https://www.hackingwithswift.com/read/6/overview

