import UIKit

var greeting = "Hello, playground"

// Checkpoint 7 Exercise
class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("whine!")
    }
}

class Cat: Animal {
    var isTame: Bool
    func speak() {
        print("meow purrr")
    }
    
    init(isTame: Bool, legs: Int) {
        self.isTame = isTame
        super.init(legs: legs)
    }
}

class Corgi: Dog {
    override func speak() {
        print("wiggly bark!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("I have curly hair")
    }
}

class Persion: Cat {
    override func speak() {
        print("peeerrrrrrsian")
    }
}

class Lion: Cat {
    override func speak() {
        print("mother fucker im the king of the jungle")
    }
}
let myAnimal = Animal(legs: 2)
print(myAnimal.legs)

let damon = Dog(legs: 4)
damon.speak()

let harry = Cat(isTame: true, legs: 4)
harry.speak()


let simba = Lion(isTame: false, legs: 4)
simba.speak()


//Checkpoint 6 Exercise

struct Car {
    private let model: String
    private let numSeats: Int
    private var curGear = 1
    
    init(model: String, numSeats: Int) {
        self.model = model
        self.numSeats = numSeats
    }
    
    func carInfo() {
        print("model = \(model), numSeats = \(numSeats), gear = \(curGear)")
    }
    
    mutating func changeGearUp() {
        if curGear < 6 {
            curGear += 1
        }
    }
    mutating func changeGearDown() {
        if curGear > 1 {
            curGear -= 1
        }
    }
    
}

var myCar = Car(model: "Prius", numSeats: 5)
for _ in 1...9 {
    myCar.changeGearUp()
}
myCar.carInfo()


for _ in 0...7 {
    myCar.changeGearDown()
}
myCar.carInfo()


// Checkpoint 5 Exercise

var luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
let lgad = luckyNumbers
    .filter { number in
        return number % 2 == 1}
    .sorted(by: { (a, b) in
        return a < b})
    .map{number in return "this is a lucky number \(number)"}


for x in lgad {
    print(x)
}

// Checkpoint 4 Exercise

// write square root of an integer from 1 to 10000

// returns the closest integer square root of the number x rounded down (i.e. so sqrt(8) wouuld be 2 and sqrt(10) = 3
// does this is log n time
func mySqrt(_ x: Int) -> Int {
    var left = 1
    var right = x
    while left <= right {
        let mid = Int(floor((Double(left) + Double(right))/2))
        let mid_sq = mid * mid
        if mid_sq == x {
            return mid
        } else if mid_sq > x {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return right
}

print(mySqrt(10))
