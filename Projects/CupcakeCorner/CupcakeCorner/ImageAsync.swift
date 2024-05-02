//
//  ImageAsync.swift
//  CupcakeCorner
//
//  Created by Anthony TK on 8/30/23.
//

import SwiftUI

// image hasn't fetched so the modifiers don't do anything.
struct AsyncImageEx: View {
    var body: some View{
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
//            Color.red
            ProgressView()      // that spinny thing to indicate it loads
        }
        .frame(width: 200, height: 200)
    }

}

// this is the way you can set image modifiers and handle
// (1) waiting the image, and (2) givin gan error message.
struct AsyncImageExMissing: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }

}


struct ImageAsync: View {
    var body: some View {
        VStack{
            AsyncImageEx()
            AsyncImageExMissing()
        }
    }
}

struct ImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        ImageAsync()
    }
}
