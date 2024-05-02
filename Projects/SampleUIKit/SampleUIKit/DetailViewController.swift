//
//  DetailViewController.swift
//  SampleUIKit
//
//  Created by Anthony TK on 9/10/23.
//


// houses the detail screen

import UIKit

class DetailViewController: UIViewController {

    // this defines from the main storyboard which page this is
    @IBOutlet var imageView: UIImageView!
    
    // here we'll pass class properties to then render; we'll define them when we
    // build the class from the ViewController
    var selectedImage: String?
    var imageIndex: Int?
    var totalImages: Int? 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // this is property of the class you can identify
        
        title = "Filename: \(selectedImage!), Image \(imageIndex! + 1) of \(totalImages!)"
        
        // small titles after the main one (in the bar)
        navigationItem.largeTitleDisplayMode = .never
        
        // front navigation: large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        
    }
    
    // trigger the hide bars on tap method when view appears and you tap it to get a
    // fullscreen view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
        
//    trigger hides bar on tap to enable it again
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
