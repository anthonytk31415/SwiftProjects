//
//  DrawingGroupExamples.swift
//  Drawing
//
//  Created by Anthony TK on 8/29/23.
//

import SwiftUI

// how many concentric circles, how many cycles?
// cycles through the rainbow from 0 to 1
// this is painfully slow; lets add metal
// BUT: don't use this too many times. Only use it when you actually
// have a performance problem. 
struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Circle()
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
        .drawingGroup()     // now runs on Metal! it's so much faster!
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct DrawingGroupExamples: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
    }
}

struct DrawingGroupExamples_Previews: PreviewProvider {
    static var previews: some View {
        DrawingGroupExamples()
    }
}
