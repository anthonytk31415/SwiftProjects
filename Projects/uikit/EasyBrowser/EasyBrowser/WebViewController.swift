//
//  WebViewController.swift
//  EasyBrowser
//
//  Created by Anthony TK on 9/12/23.
//

import UIKit
import WebKit

// When creating new views that "link", 



class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com", "google.com"]
    
    var initialWebsite: String?
        
    // override original loadView to now load the webView
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // estiamtedProgress property to calculate load times
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        // build the upper toolbar
        let backButton = UIBarButtonItem(title: "Back", style: .plain,
                                         target: webView, action: #selector(webView.goBack))
        let fwdButton = UIBarButtonItem(title: "Forward", style: .plain,
                                        target: webView, action: #selector(webView.goForward))
        let openButton = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))

        navigationItem.rightBarButtonItems = [openButton, fwdButton, backButton]
        // note: navigationItem.rightBarButtonItem is the singular item; above is array = multiple items
        
        // build the progress and refresh lower bar called the "Toolbar"
        // "spacer" = takes up as much room for spacing
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

        // define the progress view using ios developed progress feature that leverages addObserver
        progressView = UIProgressView(progressViewStyle: .default)      // create the instance
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)  // put that view item in the UI barbuttonitem

        // from UIViewCOntroller
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false       // unhides the lower toolbar
        
        // load initial page based on thing you clicked
        let url = URL(string: "https://" + initialWebsite!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page... ", message: nil, preferredStyle: .actionSheet )
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem // important for ipad: where actionsheet is anchored
        present(ac, animated: true)
    }

    // open Page custom with the title used in openTapped
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    // define webview title
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    // (1) need this for the observer as observer requires this method
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    // only go to websites that are contained in "websites" array
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {     // check if the host is in the allowable websites
                    decisionHandler(.allow)     // allow loading
                    print("this site is ok: \(host), because of this website: \(website)")
                    return
                }
            }
            badWebsiteAlert()
        }
        decisionHandler(.cancel)                // disallow
    }
    
    // creating the alert for banned webpage
    @objc func badWebsiteAlert() {
        let ac = UIAlertController(title: "Alert!", message: "this is an alert", preferredStyle: .alert )
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

}
