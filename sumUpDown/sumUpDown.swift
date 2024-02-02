//
//  sumUpDown.swift
//  sumUpDown
//
//  Created by PHYS 440 Rachelle on 2/1/24.
//

import Foundation

@Observable class sumUpDown {
    
    var sumUp = 0.0
    var sumDown = 0.0
    var enableButton = true
    
    func initSumUpdown() -> Bool{
        return true
    }
    
    func getSumUp(N: Int) async -> Double {
        sumUp = 0.0
        for n in 1...N {
            sumUp = sumUp + Double(1/n)
        }
        return sumUp
    }
    
    func getSumDown(N: Int) async -> Double {
        sumDown = 0.0
        for n in (1...N).reversed() {
            sumDown = sumDown + Double(1/n)
        }
        return sumDown
    }
    
    @MainActor func setButtonEnable(state: Bool){
        if state {
            Task.init {
                await MainActor.run {
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                await MainActor.run {
                    self.enableButton = false
                }
            }
        }
    }
    
    
    @MainActor func setSumUp(sumUp: Double){
        self.sumUp = sumUp
    }
    
    @MainActor func setSumDown(sumDown: Double){
        self.sumDown = sumDown
    }
    
}
