//
//  DetailViewController.swift
//  Project1_StormViewer
//
//  Created by iMamad on 20.05.22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectionInfo: (name: String?, index: Int, totalCount: Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationBar()
        
        if let imageToLoad = selectionInfo?.name {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    private func configNavigationBar() {
        if let selectionInfo = selectionInfo {
            self.title = "\(selectionInfo.index + 1)/\(selectionInfo.totalCount)"
        }
        navigationItem.largeTitleDisplayMode = .never
        
        // add share button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(shareTapped))
    }
    
    @objc private func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else { return }
        
        let vc = UIActivityViewController(activityItems: [image],
                                          applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
