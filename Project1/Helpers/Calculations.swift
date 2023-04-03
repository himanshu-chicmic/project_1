//
//  Calculations.swift
//  Project1
//
//  Created by Himanshu on 3/30/23.
//

import Foundation

// class for data calculations
class Calculations {
    
    // MARK: methods
    func getSalaryAccordingToChartIndex(salary: Double) -> Double{
        return (salary/10_000)
    }
    
    func getIncrementAccordingToChartIndex(increment: Double, salary: Double) -> Double {
        let incrementPercentage = (increment/(salary-increment))*100
        return incrementPercentage
    }
    
    func convertToCurrencyFormat(intString: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_IN")
        formatter.numberStyle = .decimal

        let asd = formatter.string(from: NSNumber(value: intString))
        
        return asd?.trimmingCharacters(in: .whitespacesAndNewlines) ?? String(intString).trimmingCharacters(in: .whitespacesAndNewlines);
    }
    
    func getDoublePrecision2(percentage: Double) -> String {
        return String(format: "%.2f", percentage).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
