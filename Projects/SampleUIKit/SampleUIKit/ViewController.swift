//
//  ViewController.swift
//  SampleUIKit
//
//  Created by Anthony TK on 9/9/23.
//

import UIKit

// The folders are loosely bundled "in app" within bundle
// Theres UIViewController, and UITableViewController,
// in UIKit, you'' inherit classes

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        var items = try! fm.contentsOfDirectory(atPath: path)
        print(items)
        items.sort()
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                pictures.append(item)
            }
        }
        print(pictures)
    }

    // overrite how many rows to have?
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // this will give the rows and what each row contains
    // note it will do lazy cell creation
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)     // does some recycled cell stuff
        cell.textLabel?.text = pictures[indexPath.row]                                          // optional
        return cell
    }
    
    // create code that will host the detail screen
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // (1) try loading the detail view controller and typecasting it to be detailviewcontroller
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            // (2) success! now set the image with the correct path from the array
            vc.selectedImage = pictures[indexPath.row]
            vc.imageIndex = indexPath.row
            vc.totalImages = pictures.count

            // (3) now display it in push view controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

