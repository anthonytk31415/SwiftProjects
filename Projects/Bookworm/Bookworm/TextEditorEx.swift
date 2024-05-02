//
//  TextEditorEx.swift
//  Bookworm
//
//  Created by Anthony TK on 9/1/23.
//

import Foundation
import SwiftUI


struct TextEditorEx: View {
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        TextEditor(text: $notes)
            .navigationTitle("Notes")
            .padding()
    }
}
