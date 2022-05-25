//
//  ViewController.swift
//  Project4_EasyBrowser
//
//  Created by iMamad on 24.05.22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    private var websites = ["youtube.com", "apple.com", "hackingwithswift.com"]
    
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
        progressView = UIProgressView(progressViewStyle: .default) // TODO: Try other styles as well
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        toolbarItems = [progressButton, spacer, refresh]
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
extension ViewController: WKNavigationDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
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
    }
}

// MARK: UIBarButtons
extension ViewController {
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
