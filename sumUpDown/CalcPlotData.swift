//
//  CalcPlotData.swift
//  sumUpDown
//
//  Created by PHYS 440 Rachelle on 2/2/24.
//


import Foundation
import SwiftUI
import Observation


@Observable class CalculatePlotData {
    
    var plotDataModel: PlotDataClass? = nil
    var theText = ""
    var sumsModel = sumUpDown()
    

    /// Set the Plot Parameters
    /// - Parameters:
    ///   - color: Color of the Plotted Data
    ///   - xLabel: x Axis Label
    ///   - yLabel: y Axis Label
    ///   - title: Title of the Plot
    ///   - xMin: Minimum value of x Axis
    ///   - xMax: Maximum value of x Axis
    ///   - yMin: Minimum value of y Axis
    ///   - yMax: Maximum value of y Axis
    @MainActor func setThePlotParameters(color: String, xLabel: String, yLabel: String, title: String, xMin: Double, xMax: Double, yMin:Double, yMax:Double) {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = yMax
        plotDataModel!.changingPlotParameters.yMin = yMin
        plotDataModel!.changingPlotParameters.xMax = xMax
        plotDataModel!.changingPlotParameters.xMin = xMin
        plotDataModel!.changingPlotParameters.xLabel = xLabel
        plotDataModel!.changingPlotParameters.yLabel = yLabel
        
        if color == "Red"{
            plotDataModel!.changingPlotParameters.lineColor = Color.red
        }
        else{
            
            plotDataModel!.changingPlotParameters.lineColor = Color.blue
        }
        plotDataModel!.changingPlotParameters.title = title
        
        plotDataModel!.zeroData()
    }
    
    /// This appends data to be plotted to the plot array
    /// - Parameter plotData: Array of (x, y) points to be added to the plot
    @MainActor func appendDataToPlot(plotData: [(x: Double, y: Double)]) {
        plotDataModel!.appendData(dataPoint: plotData)
    }
    
    func plotYEqualsX() async
    {
        
        theText = "y = x\n"
        
        await resetCalculatedTextOnMainThread()
        
        
        var plotData :[(x: Double, y: Double)] =  []
        
        let bob: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        for N in bob  {
             
            
           
            //create x values here
            let x = log10(Double(N))

        //create y values here
            let sumUp = await sumsModel.getSumUp(N: N)
            let sumDown = await sumsModel.getSumDown(N: N)
            //let quotient = abs(sumUp-sumDown)/(sumUp+sumDown)
            let dif = sumUp-sumDown
            let y = dif


            let dataPoint: (x: Double, y: Double) = (x: x, y: y)
            plotData.append(contentsOf: [dataPoint])
            theText += "x = \(x), y = \(y)\n"
        
        }
        
        await setThePlotParameters(color: "Red", xLabel: "x", yLabel: "y", title: "y = x", xMin: -4.0, xMax: 24.0, yMin: -4.0, yMax: 24.0)
        
        await appendDataToPlot(plotData: plotData)
        await updateCalculatedTextOnMainThread(theText: theText)
        
        
    }
    
    
    func ploteToTheMinusX() async
    {
        
        
        
        await resetCalculatedTextOnMainThread()
        
        theText = "y = exp(-x)\n"
        
        var plotData :[(x: Double, y: Double)] =  []
        for i in 0 ..< 60 {

            //create x values here
            let x = -2.0 + Double(i) * 0.2

        //create y values here
        let y = exp(-x)
            
            let dataPoint: (x: Double, y: Double) = (x: x, y: y)
            plotData.append(contentsOf: [dataPoint])
            theText += "x = \(x), y = \(y)\n"
        }
        
        //set the Plot Parameters
        await setThePlotParameters(color: "Blue", xLabel: "x", yLabel: "y = exp(-x)", title: "y = exp(-x)", xMin: -4.0, xMax: 12.0, yMin: -1.0, yMax: 8)
        
        await appendDataToPlot(plotData: plotData)
        await updateCalculatedTextOnMainThread(theText: theText)
        
        return
    }
    
    
    /// Resets the Calculated Text to ""
        @MainActor func resetCalculatedTextOnMainThread() {
            //Print Header
            plotDataModel!.calculatedText = ""
    
        }
    
    
    /// Adds the passed text to the display in the main window
    /// - Parameter theText: Text Passed To Add To Display
        @MainActor func updateCalculatedTextOnMainThread(theText: String) {
            //Print Header
            plotDataModel!.calculatedText += theText
        }
    
}
