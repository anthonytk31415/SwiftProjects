//
//  DetailViewController.swift
//  FlagExpander
//
//  Created by Anthony TK on 9/11/23.
//

import UIKit

// to set up the DetailViewController:
// - create the DetailViewController from a ViewController object in the main.storyboard
// - give the storyboard ID: "Detail"
// - point its class to "DetailViewController" to let teh storyboard know that DetailViewController class is associated with the storyboard element
// - since we're using images, we need to then define the object UIimage, set its constraints to "reset to suggested constraints", the control drag the
//   element to the DetailViewController class to give it an @IBOutlet var so that we can define its properties
// - later we will call this class on viewController to render it

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let imageToLoad: String = selectedImage {
            let imageToLoad3x = imageToLoad.replacingOccurrences(of: "@2x", with: "@3x")
            imageView.image = UIImage(named: imageToLoad3x)
        }


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
