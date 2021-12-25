//
//  ViewController.swift
//  Project4
//
//  Created by Chandran, Sudha on 24/12/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webview: WKWebView!
    var progressview: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]

    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webview, action: #selector(webview.reload))
        progressview = UIProgressView(progressViewStyle: .default)
        progressview.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressview)

        let left = UIImage(systemName: "arrow.left")
        let right = UIImage(systemName: "arrow.right")

        let back = UIBarButtonItem(image: left,
                                  style: .plain,
                                  target: nil,
                                  action: #selector(webview.goBack))

        let forward = UIBarButtonItem(image: right,
                                  style: .plain,
                                  target: nil,
                                  action: #selector(webview.goForward))
//        let back = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: webview, action: #selector(webview.goBack))

//        let forward = UIBarButtonItem(barButtonSystemItem: .camera, target: webview, action: #selector(webview.goForward))

        toolbarItems = [progressButton, back, forward, spacer, refresh]
        navigationController?.isToolbarHidden = false

        webview.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
        
        let url = URL(string: "https://" + websites[1])!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page..",
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

    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else {
            return
        }
//        let url = URL(string: "https://" + action.title!)!
        guard let url =  URL(string: "https://" + actionTitle) else {
            return
        }
        webview.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webview.title
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressview.progress = Float(webview.estimatedProgress)
        }
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

