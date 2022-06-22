//
//  DetailViewController.swift
//  Project7_WhitehousePetitions
//
//  Created by iMamad on 01.06.22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        let html = """
            <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style> body {
                font-size: 150%;
                background-image:linear-gradient(30deg,green,orange,black);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            } </style>
            </head>
            <body>
            \(detailItem.body)
            </body>
            </html>
            """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
