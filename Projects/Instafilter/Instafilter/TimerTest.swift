//
//  TimerTest.swift
//  Instafilter
//
//  Created by Anthony TK on 9/13/23.
//


// things to implement; countdown
//

import SwiftUI

class Stop_Watch: ObservableObject {
    
    @Published var counter: Int = 0
    var timer = Timer()
    
    func start() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01,
                                                   repeats: true) { _ in
            self.counter += 1
        }
    }
    func stop() {
        self.timer.invalidate()
    }
    func reset() {
        stop()
        self.counter = 0
        self.timer.invalidate()
    }
}

struct TimerTest: View {
    
    @ObservedObject var stopWatch = Stop_Watch()
    
    var body: some View {
        
        let hours = String(format: "%02d", stopWatch.counter / 360000)
        let minutes = String(format: "%02d", stopWatch.counter / 6000 % 60)
        let seconds = String(format: "%02d", stopWatch.counter / 100 % 60 )
        let centiseconds = String(format: "%2.2d", (stopWatch.counter) % 100)
//        let union = minutes + ":" + seconds + ":" + centiseconds
//        let union = "00" + ":" + "00" + ":" + centiseconds
        let union = hours + ":" + minutes + ":" + seconds + ":" + centiseconds
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Button("Start") { stopWatch.start() }
                        .foregroundColor(.purple)
                    Button("Stop") { stopWatch.stop() }
                        .foregroundColor(.orange)
                    Button("Reset") { stopWatch.reset() }
                        .foregroundColor(.yellow)
                }
                Spacer()
                Text("\(union)")
                    .foregroundColor(.teal)
                    .font(.custom("", size: 50))
                Spacer()
            }
        }
    }
}

struct TimerTest_Previews: PreviewProvider {
    static var previews: some View {
        TimerTest()
    }
}
