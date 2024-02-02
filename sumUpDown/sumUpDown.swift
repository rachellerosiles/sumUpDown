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
    var N = 0
    var enableButton = true
    
    func initSumUpdown(N: Int) -> Bool{
        self.N = N
        
        return true
    }
    
    func getSumUp() async -> (Type: String, StringToDisplay: String, Value: Double) {
        for n in 1...N {
            sumUp = sumUp + Double(1/n)
        }
        let sumUpText = "\(sumUp.formatted(.number.precision(.fractionLength(7))))"
        return (Type: "Sum (up)", StringToDisplay: sumUpText, Value: sumUp)
    }
    
    func getSumDown() async -> (Type: String, StringToDisplay: String, Value: Double) {
        for n in N...1{
            sumDown = sumDown + Double(1/n)
        }
        let sumDownText = "\(sumDown.formatted(.number.precision(.fractionLength(7))))"
        return (Type: "Sum (down)", StringToDisplay: sumDownText, Value: sumDown)
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
