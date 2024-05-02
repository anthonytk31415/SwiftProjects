//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Anthony TK on 8/28/23.
//



import Foundation
import SwiftUI


// write custom dark mode!
// extend only when its used as a color
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }

    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }

}
