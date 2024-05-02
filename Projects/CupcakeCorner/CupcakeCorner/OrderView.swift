//
//  SwiftUIView.swift
//  CupcakeCorner
//
//  Created by Anthony TK on 8/30/23.
//

import SwiftUI

// will use a class to carry the data
// need to add codable. steps:
//  - enum coding keys
//  - func encode
//  - decode with required init
//  - add init() {} empty


// recall:
// @published allows vars to be "listened to" from other structs
// that class instance is passed to child views (structs
// @observedObject is called in the child struct view to call on that class instance

//


// initially, we started with the Order class and housed all the variables there
// and made that clas Codable. This was heavy because we had a lot of variables to then
// enum and encode and decode.
// We then made a struct that housed all the data, called OrderData and made that codable
// via a struct. Then we made in instance of OrderData in Order that is @Published. This
// makes management way cleaner.

struct OrderData: Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }

    let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0     // usually probably want a dict to lock items in an array
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {            // cool setting: bool == false, then others are false
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    func isAllSpaces(_ str: String) -> Bool {
        if str.isEmpty {
            return true
        }
        for x in str {
            if x != " " {
                return false
            }
        }
        return true
    }
 
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        for field in [name, streetAddress, city, zip] {
            if isAllSpaces(field) {
                return false
            }
        }
        return true
    }

    // this builds the cost and uses hardcoded values for the price
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        if extraFrosting {
            cost += Double(quantity)
        }
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
}


class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case orderData
    }

    @Published var orderData = OrderData()
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(orderData, forKey: .orderData)
    }

    // this is the decode init that allows us to decode from the Codable json or whatever format
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderData = try container.decode(OrderData.self, forKey: .orderData)
    }
}


struct OrderView: View {
    @StateObject var order = Order()        // this is the only place where it calls the object
    
    var body: some View {
        Group {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderData.type) {
                        ForEach(order.orderData.types.indices, id: \.self) {
                            Text(order.orderData.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.orderData.quantity)", value:
                                $order.orderData.quantity, in: 3...20)
                }
                
                Section{
                    Toggle("Any special requests?", isOn: $order.orderData.specialRequestEnabled.animation())
                    
                    if order.orderData.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.orderData.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.orderData.addSprinkles)
                    }
                
                }
                Section {
                    NavigationLink("Delivery Details", destination: AddressView(order: order))        // reinitiate
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
