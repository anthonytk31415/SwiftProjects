//
//  CoreImagePlay.swift
//  Instafilter
//
//  Created by Anthony TK on 9/13/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct CoreImagePlay: View {
    @State private var image: Image?
    @State private var adjAmount: Double = 1.0
    @State private var transformation = "Sepia Tone"
    let transformations = ["Twirl Distortion", "Sepia Tone"]
    let notes = "Currently, toggling is disabled. Update coming soon!"
    
    var body: some View {
        VStack {
            Picker("Transformations", selection: $transformation) {
                ForEach(transformations, id: \.self) {
                    Text($0)
                }
            }
            Text(notes)
                .padding(5)
                .background(.gray)
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: {
            loadImage(transformation)
        })
    }
    
    
    
    // create CIImage, then image
    func loadImage(_ transformation: String) {
        guard let inputImage = UIImage(named: "Example") else {return}
        let beginImage = CIImage(image: inputImage)
        
        // use CoreImage for image manipulation
        let context = CIContext()
        
        // SepiaTone
//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1

        
        // pixellate
//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 50
        
//        var currentFilter: CIFilter
        let amount = adjAmount
        
        // twirl distortion
//        switch transformation {
//            case "Twirl Distortion":
//                currentFilter = CIFilter.twirlDistortion()
//
//            case "Sepia Tone":
//                currentFilter = CIFilter.sepiaTone()
//            default:
//                currentFilter = CIFilter.sepiaTone()
//        }

        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        // note: pixellate requires a scale probably

        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputRadiusKey)
        }
        
//        currentFilter.radius = 1000
//        currentFilter.center = CGPoint(x: inputImage.size.width/2, y: inputImage.size.height / 2)
        
        // convert back to CIImage > CGimage > UIImage > SwiftUIImage
        // for formatting purposes
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) { // get all image
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct CoreImagePlay_Previews: PreviewProvider {
    static var previews: some View {
        CoreImagePlay()
    }
}
