//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Anthony TK on 9/13/23.
//

import PhotosUI
import SwiftUI

// Steps:
// (1) build a UI photo images UI controller and import to swift UI
// (2) will build coordinators
struct ImagePicker: UIViewControllerRepresentable {

    @Binding var image: UIImage?
    
    // build a nested class Coordinator
    // NSObjects are the obj C's basic object
    // PHPickerViewControllerDelegate allows obj-c to check for the functionality
    // - need to implement some methods for protocol compliance
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // gives functionality to exit, cancel, or grab results and look for UIImage
        // and then load into image property
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            // can this thing load ui image?
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) {image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        // make the view controller
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator   // delgate uses that coordinator
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    // swiftui will call it when it makes the struct
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
