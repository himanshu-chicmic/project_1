//
//  ChartCustomizations.swift
//  Project1
//
//  Created by Himanshu on 3/30/23.
//

import Foundation
import Charts

// class for chart customizations
class ChartCustomizations{
    
    // MARK: methods
    func setYAxisLabels(labels: YAxis, value: [String]) {
        labels.valueFormatter = IndexAxisValueFormatter(values: value)
        labels.axisMinimum = 0
        labels.axisMaximum = Double(value.count) - 0.75
        labels.labelCount = value.count - 1
        labels.drawGridLinesEnabled = false
        labels.drawAxisLineEnabled = false
    }
    
    func setXAxisLabels(labels: XAxis, value: [String], data: BarChartData){
        labels.valueFormatter = IndexAxisValueFormatter(values: value)
        labels.labelCount = value.count
        labels.labelPosition = .bottom
        labels.drawGridLinesEnabled = false
        labels.axisMaximum = data.xMax + 0.3
        labels.axisMinimum = data.xMin - 0.3
    }
}
