//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Anthony TK on 8/31/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingOrderFail = false
    @State private var orderFailMessage = ""
    var body: some View {
        ScrollView {
            VStack{
                // grabbing an image from an external server
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Text("Your Total is \(order.orderData.cost, format: .currency(code: "USD"))")
                Button("Place Order") {
                    Task {          // specify task for async functions
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK"){}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Oh no! Your order did not go through", isPresented: $showingOrderFail) {
            Button("OK") {}
        } message: {
            Text(orderFailMessage)
        }
    }
    
    // json, how to send, then run the request, do something with response
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order.")
            return
        }
        // now how to run request using HTTP request: GET, POST; will use POST
        // tell them also to specify MIME type: what type of data is this? (It's a JSON)
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // send this data to a test req res test server
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // handle the result
            // use JSON decoder to decode the JSON
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.orderData.quantity) x \(order.orderData.types[decodedOrder.orderData.type].lowercased()) cupcakes is on its way!"
            showingConfirmation.toggle()
            
        } catch {
            showingOrderFail.toggle()
            orderFailMessage = "Order failed to reach the server."
        }
    }
}

// notice we give CheckoutView a parameter for rendering
struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
