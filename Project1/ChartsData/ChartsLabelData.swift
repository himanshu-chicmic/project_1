//
//  StaticData.swift
//  Project1
//
//  Created by Himanshu on 3/30/23.
//

import Foundation

// data for chart labels
final class ChartsLabelData{
    // MARK: properties
    static let salary = ["0", "10k", "20k", "30k", "40k", "50k", "60k", "70k"]
    
    static let percentage = ["0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%"]
    static let month = SalaryData().initializeData().map{
        $0.month
    }
}
