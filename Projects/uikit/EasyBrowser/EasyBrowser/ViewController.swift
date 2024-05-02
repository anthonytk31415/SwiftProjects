//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Anthony TK on 9/11/23.
//

import UIKit
import WebKit

// Remember: to have navigation:
// (1) ViewController has the attached NavigationController
// (2) NavigationController = first destination

class ViewController: UITableViewController, WKNavigationDelegate {

    var websites = ["apple.com", "hackingwithswift.com", "google.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Easy Browser"
    }
    
    // define rows in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    // Define contents of the table.
    // each row is "represeted" in the storyboard by the Identifier of the table cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebURL", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
        
    // When you select the row, based on the index, you'll load the WebViewController with some
    // parameters filled
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? WebViewController {
            vc.initialWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }

    }

}

