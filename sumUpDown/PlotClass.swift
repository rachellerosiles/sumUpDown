//
//  PlotClass.swift
//  sumUpDown
//
//  Created by PHYS 440 Rachelle on 2/2/24.
//

import Foundation
import Observation

@Observable class PlotClass {
    
    var plotArray = [PlotDataClass.init(fromLine: true)]
    
    init() {
        self.plotArray = [PlotDataClass.init(fromLine: true)]
        self.plotArray.append(contentsOf: [PlotDataClass.init(fromLine: true)])
            
        }

    
}
