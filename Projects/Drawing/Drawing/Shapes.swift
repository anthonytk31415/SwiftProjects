//
//  Shapes.swift
//  Drawing
//
//  Created by Anthony TK on 8/29/23.
//

import SwiftUI

// pi radians = 180 degrees
// rotating, then moving is not commutative
struct Flower: Shape {

    var petalOffset: Double = -20    // how much to move this petal away from the center
    var petalWidth: Double = 100     // how wide to make each petal
    
    func path(in rect: CGRect) -> Path {
        var path = Path()   // the path will hold all petals
        
        // Count from 0 up to 2*pi moving up pi/8 each time
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)
            
            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height / 2))
            
            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y:0, width: petalWidth, height: rect.width / 2))
            
            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)
            
            // add it to our main path
            path.addPath(rotatedPetal)
            
        }
        return path
    }
}


// an example of a triangle as a
// need to define an insetAMount on struct Arc with an InsettableShape protocol so that it can accept
// the strokeborder modifier

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount = 0.0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}


struct Shapes: View {
    // for the petal/flower
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var circleArcSwitch = false
    
    var body: some View {
        NavigationView{
            ZStack {
                if circleArcSwitch {
                    Group{
                        
                        //        Circle().stroke(.blue, lineWidth: 40)       // this circle is traced outisde the screen
                        Circle().strokeBorder(.blue, lineWidth: 10) // the strokes the inside of the circle, nto center of border
                        Arc(startAngle: .degrees(0), endAngle: .degrees(20), clockwise: true).strokeBorder(.red, lineWidth: 30)
                    }
                } else {
                    VStack{
                        Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                            .stroke(.red, lineWidth: 1)
//                            .fill(.red) // pretty ugly
                            .fill(.red, style: FillStyle(eoFill: true)) // crazy overlapping
                        Text("Offset")
                        Slider(value: $petalOffset, in: -40...40)
                            .padding([.horizontal, .bottom])
                    }
                }
            }
            .navigationTitle("Shapes")
            .toolbar {
                Button("switch") {
                    circleArcSwitch.toggle()
                }
            }
        }
        
    }
}

struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        Shapes()
    }
}
