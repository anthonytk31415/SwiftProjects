//
//  CountdownTimer.swift
//  Instafilter
//
//  Created by Anthony TK on 9/13/23.
//

import Foundation

class CountdownTimer {
    var duration: TimeInterval
    var timeRemaining: TimeInterval
    var isRunning: Bool = false
    var timer: Timer?
    var completionHandler: (() -> Void)?

    init(duration: TimeInterval) {
        self.duration = duration
        self.timeRemaining = duration
    }

    func start() {
        guard !isRunning else { return }

        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            self.timeRemaining -= 1.0

            if self.timeRemaining <= 0 {
                self.stop()
                self.completionHandler?()
            }
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    func reset() {
        stop()
        timeRemaining = duration
    }
}
