//
//  ViewController.swift
//  FlagExpander
//
//  Created by Anthony TK on 9/11/23.
//

import UIKit

class ViewController: UITableViewController {

    var picturesList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Flag Browser"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.contains("@2x") {
                picturesList.append(item)
            }
        }
        print(picturesList)
        
    }

    // define the num rows in the tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picturesList.count
    }
    
    // define the rows in the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = picturesList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // do something with DetailViewController

            // this defines the class view
            vc.selectedImage = picturesList[indexPath.row]

            // this then pushes the view
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

