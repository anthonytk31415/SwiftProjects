//
//  SwiftUIView.swift
//  Instafilter
//
//  Created by Anthony TK on 9/13/23.
//


// putting UIViewController in SwiftUI; in this case, the ImagePicker


import SwiftUI

struct ImageUI: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage()}
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
        
    }
}

struct ImageUIView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUI()
    }
}
