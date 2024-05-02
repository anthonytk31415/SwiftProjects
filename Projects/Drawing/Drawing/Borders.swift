//
//  Borders.swift
//  Drawing
//
//  Created by Anthony TK on 8/29/23.
//

import SwiftUI

struct Borders: View {
    var body: some View {
        Text("Taylor Swift 1989")
            .frame(width: 300, height: 300)
            .border(ImagePaint(image: Image("tay1989"),
                               sourceRect: CGRect(x: 0, y: 0.4, width: 1, height: 1),
                               scale: 0.2),
                    width: 50)
    }
}

struct Borders_Previews: PreviewProvider {
    static var previews: some View {
        Borders()
    }
}
