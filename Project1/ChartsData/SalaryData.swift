//
//  ChartsData.swift
//  Project1
//
//  Created by Himanshu on 3/30/23.
//

import Foundation

// model class for salary data
class SalaryData {
    
    // MARK: properties
    let salary: Double
    let increment: Double
    let designation: String
    let band: Double
    let month: String
    
    // MARK: initializers
    init(salary: Double, increment: Double, designation: String, band: Double, month: String) {
        self.salary = salary
        self.increment = increment
        self.designation = designation
        self.band = band
        self.month = month
    }
    
    // used for special case
    init(){
        self.salary = 0
        self.increment = 0
        self.designation = ""
        self.band = 0
        self.month = ""
    }
    
    // MARK: methods
    func initializeData() -> [SalaryData] {
        var salaryData: [SalaryData] = []
        
        
        salaryData.append(SalaryData(salary: 20_500, increment: 0.0, designation: "Jr. UI UX", band: 7, month: "Jan 15"))
        
        salaryData.append(SalaryData(salary: 23_000, increment: 2_500, designation: "Jr. UI UX", band: 7, month: "Aug 17"))
        
        salaryData.append(SalaryData(salary: 28_000, increment: 5_000, designation: "Sr. UI UX", band: 6, month: "Sep 18"))
        
        salaryData.append(SalaryData(salary: 36_400, increment: 8_400, designation: "Pr. UI UX", band: 6, month: "Jun 19"))
        
        salaryData.append(SalaryData(salary: 43_000, increment: 3_680, designation: "UX Analyst", band: 5.2, month: "Oct 20"))
        
        salaryData.append(SalaryData(salary: 60_000, increment: 3_600, designation: "UX Analyst", band: 5.2, month: "Oct 20"))
        
        salaryData.append(SalaryData(salary: 40_000, increment: 2_600, designation: "UX Analyst", band: 5.2, month: "Oct 20"))
        
        salaryData.append(SalaryData(salary: 10_000, increment: 3_600, designation: "UX Analyst", band: 5.2, month: "Oct 20"))
        
        salaryData.append(SalaryData(salary: 20_000, increment: 1_600, designation: "UX Analyst", band: 5.2, month: "Oct 20"))
        
        salaryData.append(SalaryData(salary: 30_000, increment: 7_600, designation: "UX Analyst", band: 5.2, month: "Oct 20"))

        
        
        
        return salaryData
    }
}
