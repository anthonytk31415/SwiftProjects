//
//  BlursAndBlending.swift
//  Drawing
//
//  Created by Anthony TK on 8/29/23.
//

import SwiftUI

// - black is (0,0,0); so black * somePixel is still black
//
// mix of colors are "adaptive" colors that change the way they look based on light and dark mode
struct BlursAndBlending: View {
    
    @State private var amount = 0.0
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
//                    .fill(.red) // these are the adaptive colors
                    .fill(Color(red:1, green: 0, blue: 0))  // the pure colors
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)     // this blend will have nice opacity with overlaps
                
                Circle()
//                    .fill(.green)
                    .fill(Color(red:0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)

                Circle()
//                    .fill(.blue)
                    .fill(Color(red:0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            Slider(value: $amount)
                .padding()
            
            // settings below control the blur with a slider for the image
            Image("tay1989")
                .resizable()
                .scaledToFit()
                .frame(width:100, height: 100)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
//                .colorMultiply(.gray) // same effect as the blend mode! b/c its so popular
            
            //            Rectangle()
            //                .fill(.red)
            //                .blendMode(.multiply)   // multiplies pixels to get the new color: pixel * pixel
            //
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
        
    }
}

struct BlursAndBlending_Previews: PreviewProvider {
    static var previews: some View {
        BlursAndBlending()
    }
}
