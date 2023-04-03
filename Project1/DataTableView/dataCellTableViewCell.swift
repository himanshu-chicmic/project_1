//
//  dataCellTableViewCell.swift
//  Project1
//
//  Created by Himanshu on 3/31/23.
//

import UIKit

class dataCellTableViewCell: UITableViewCell {
    
    // MARK: properties
    let calculations = Calculations()

    // MARK: outlets
    @IBOutlet weak var monthLable: UILabel!
    
    @IBOutlet weak var bandLabel: UILabel!
    
    @IBOutlet weak var designationLabel: UILabel!
    
    @IBOutlet weak var salaryLabel: UILabel!
    
    @IBOutlet weak var incrementLabel: UILabel!
    
    
    func setData(data: SalaryData) {
        monthLable.text = data.month
        
        let percentage = Calculations().getIncrementAccordingToChartIndex(increment: data.increment, salary: data.salary)
        
        bandLabel.text = calculations.getDoublePrecision2(percentage: percentage)
        designationLabel.text = data.designation
        salaryLabel.text = calculations.convertToCurrencyFormat(intString: Int(data.salary))
        incrementLabel.text = calculations.convertToCurrencyFormat(intString: Int(data.increment))
    }
    
    func setForegroundColor(color: UIColor) {
        monthLable.textColor = color
        bandLabel.textColor = color
        designationLabel.textColor = color
        salaryLabel.textColor = color
        incrementLabel.textColor = color
    }
}
