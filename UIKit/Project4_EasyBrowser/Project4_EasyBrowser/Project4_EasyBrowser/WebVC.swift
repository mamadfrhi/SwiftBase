//
//  ViewController.swift
//  Project4_EasyBrowser
//
//  Created by iMamad on 24.05.22.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    var websites : [String]!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configToolbar()
        configNavigationBar()
        configWebView()
    }
    
    private func configToolbar() {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: webView, action: #selector(webView.reload))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .rewind,
                                         target: webView,
                                         action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(barButtonSystemItem: .fastForward,
                                         target: webView,
                                         action: #selector(webView.goForward))
        
        toolbarItems = [backButton, forwardButton, spacer, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
    private func configNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openTapped))
    }
    private func configWebView() {
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
    }
}

// MARK: WebView
extension WebVC: WKNavigationDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if webView.estimatedProgress == 1 {
                progressView.isHidden = true
            } else{
                progressView.isHidden = false
            }
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
        if url?.absoluteString != "about:blank" { showBlockedWebAddressAlert() }
    }
    
    private func showBlockedWebAddressAlert() {
        let ac = UIAlertController(title: "This URL is blocked!",
                                   message: nil,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
}

// MARK: UIBarButtons
extension WebVC {
    // rightBarButtonItem
    @objc private func openTapped() {
        let ac = UIAlertController(title: "Open page...",
                                   message: nil,
                                   preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website,
                                       style: .default,
                                       handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel",
                                   style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    private func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
}
