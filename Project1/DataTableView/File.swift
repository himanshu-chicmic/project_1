//
//  File.swift
//  Project1
//
//  Created by Himanshu on 3/31/23.
//

import Foundation
import UIKit

extension SalaryChartViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCellsVisible ?  salaryDataArray.count : 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == 0{
            dataCellsVisible.toggle()
            tableView.reloadSections([indexPath.section], with: .none)
            
            setContentViewHeight()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as? dataCellTableViewCell else {
            fatalError("no data")
        }
        
        if indexPath.row != 0 {
            cell.setData(data: salaryDataArray[salaryDataArray.count - indexPath.row - 1])
            
            cell.setForegroundColor(color: .label)
            
            if indexPath.row.isMultiple(of: 2){
                cell.backgroundColor = UIColor(hex: "#3080EA26")
            }else {
                cell.backgroundColor = UIColor(hex: "#3080EA1A")
            }
        } else {
            cell.monthLable.text = "Month"
            cell.bandLabel.text = "Band"
            cell.designationLabel.text = "Designation"
            cell.salaryLabel.text = "Salary"
            cell.incrementLabel.text = "Increment"
            
            cell.backgroundColor = UIColor(hex: "#0CA2FBFF")
            
            cell.setForegroundColor(color: .white)
        }
        
        return cell
    }
    
    
    
    
}
