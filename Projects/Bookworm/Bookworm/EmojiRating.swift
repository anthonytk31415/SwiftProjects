//
//  EmojiRating.swift
//  Bookworm
//
//  Created by Anthony TK on 9/7/23.
//

import SwiftUI

// do a custom emoji view with the lsit of books

struct EmojiRatingView: View {
    let rating: Int16
    
    var body: some View {
        switch rating {
        case 1:
            return Text("💩")
        case 2:
            return Text("😞")
        case 3:
            return Text("🙂")
        case 4:
            return Text("😃")
        default:
            return Text("🤩")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 1)
    }
}
