//
//  ViewController.swift
//  NavBarExample
//
//  Created by Anthony TK on 9/12/23.
//

import UIKit

class ViewController: UITableViewController {

    var songs = ["Lavender Haze", "Anti-Hero", "The Great War"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let aboutButton = UIBarButtonItem(title: "About", style: .plain,
                                     target: self, action: #selector(aboutMessageAlert))
        
        navigationItem.rightBarButtonItems = [aboutButton]
        
    }
    
    @objc func aboutMessageAlert() {
        let msg = "This page is inspired by Damon and Stefan."
        let ac = UIAlertController(title: "About", message: msg, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Song: \(songs[indexPath.row])"
        cell.detailTextLabel?.text = "Album: Midnights"
        return cell
    }


}

