//
//  Arrows.swift
//  Drawing
//
//  Created by Anthony TK on 8/29/23.
//

import SwiftUI

struct Arrow: InsettableShape {
    var insetAmount: Double = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))                  // top
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.maxX * 3/4 - insetAmount, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.maxX * 3/4 - insetAmount, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX / 4 + insetAmount, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX / 4 + insetAmount, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.minX + insetAmount, y: rect.maxY / 4))
        path.closeSubpath()
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ColorCyclingArrow: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack{
            ForEach(0..<steps, id: \.self) { value in
                Arrow()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}



struct Arrows: View {
    @State private var colorCycle = 0.0
    var amount: Double = 0.0
    var steps: Int = 100

    var body: some View {
        VStack{
            ColorCyclingArrow(amount: colorCycle)
            VStack {
                Text("Gradient")
                Slider(value: $colorCycle)
            }
        }
    }
}

struct Arrows_Previews: PreviewProvider {
    static var previews: some View {
        Arrows()
    }
}
