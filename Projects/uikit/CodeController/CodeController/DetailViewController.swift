//
//  DetailViewController.swift
//  CodeController
//
//  Created by Anthony TK on 9/12/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition? // item that's passed from ViewController
        
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        // use string interpolation to put the body in the html string
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        // use custom html here
        // url = nil
        webView.loadHTMLString(html, baseURL: nil)
        
        // Do any additional setup after loading the view.
        
        let aboutButton = UIBarButtonItem(title: "About", style: .plain,
                                          target: self, action: #selector(aboutAlert))
        
        navigationItem.rightBarButtonItems = [aboutButton]
        
        
    }
    
    @objc func aboutAlert() {
        let msg = "blah"
        let ac = UIAlertController(title: "About", message: msg, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
