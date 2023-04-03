//
//  ViewController.swift
//  Project1
//
//  Created by Himanshu on 3/30/23.
//

import UIKit
import Charts

class SalaryChartViewController: UIViewController, ChartViewDelegate {
    
    // MARK: properties
    private let calculations = Calculations()
    private let chartCutomizatioins = ChartCustomizations()
    let salaryData = SalaryData()
    var salaryDataArray: [SalaryData] = []
    var dataCellsVisible = true
    
    // MARK: outlets
    @IBOutlet weak var contenViewHeight: NSLayoutConstraint!
    @IBOutlet weak var salaryChart: CombinedChartView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        salaryChart.delegate = self
        
        salaryDataArray = salaryData.initializeData()
        
        tableView.layer.cornerRadius = 8
        
        // set the chart
        /// initialize and create combinedChart
        setChart()
        
        setContentViewHeight()
    }

    // MARK: methods
    func setContentViewHeight() {
        let chartHeight = salaryChart.frame.height + 24
        let tableHeight = dataCellsVisible ? tableView.rowHeight * CGFloat(salaryDataArray.count) : tableView.rowHeight + 32
        contenViewHeight.constant = chartHeight + tableHeight + tableView.rowHeight
    }
    
    func setChart() {
        // when no data in present in the chart
        // noDataText is shown as placeholder
        salaryChart.noDataText = "No Data Available."
        
        salaryChart.setScaleEnabled(false)
        
        // initializing data for combined charts
        let data = CombinedChartData()
        
        // set barData for CombinedChartData
        data.barData = generateBarData()
        data.lineData = generateLineData()
       
        // setting labels for y axis left
        chartCutomizatioins.setYAxisLabels(labels: salaryChart.getAxis(.left), value: ChartsLabelData.salary)
        
        // setting labels for y axis right
        chartCutomizatioins.setYAxisLabels(labels: salaryChart.getAxis(.right), value: ChartsLabelData.percentage)
        
        // setting labels for x axis bottom
        chartCutomizatioins.setXAxisLabels(labels: salaryChart.xAxis, value: ChartsLabelData.month, data: data.barData)
        
        // animate chart
        salaryChart.animate(xAxisDuration: 0.5)
        salaryChart.animate(yAxisDuration: 0.5)
        
        // disable marks for data set names
        salaryChart.legend.enabled = false
        
        // bubble when clicked on bar item
        let marker: BalloonMarker = BalloonMarker(color: UIColor.white, font: .systemFont(ofSize: 12, weight: .bold), textColor: .label, insets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 30.0, right: 16.0))
        marker.minimumSize = CGSize(width: 140, height: 100)
        salaryChart.marker = marker
        
        // shadow for bars in bar chart
        salaryChart.drawBarShadowEnabled = true
        
        // scroll chart view
        salaryChart.setVisibleXRangeMaximum(5)
        
        // set data to chart
        salaryChart.data = data
        
    }
    
}

// MARK: extension for bar chart data
extension SalaryChartViewController {
    func generateBarData() -> BarChartData {
        
        let entries = (0..<salaryDataArray.count).map { i -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: calculations.getSalaryAccordingToChartIndex(salary: salaryDataArray[i].salary))
        }
        
        let set = BarChartDataSet(entries: entries, label: "Bar Data Set")
        
        set.setColor(UIColor(hex: "#8676FFFF")?.withAlphaComponent(0.5) ?? .systemPurple.withAlphaComponent(0.5))
        set.axisDependency = .left
//        set.highlightEnabled = false
        
        set.highlightColor = UIColor(hex: "#8676FFFF") ?? .systemPurple
        set.drawValuesEnabled = false

        let data: BarChartData = [set]
        let barWidth = 0.15
        data.barWidth = barWidth
       
        return data
    }
}

// MARK: extension for line chart data
extension SalaryChartViewController {
    func generateLineData() -> LineChartData {
        
        let entries = (0..<salaryDataArray.count).map { (i) -> ChartDataEntry in
            
            let increment = salaryDataArray[i].increment
            let salary = salaryDataArray[i].salary
            
            return ChartDataEntry(x: Double(i), y: calculations.getIncrementAccordingToChartIndex(increment: increment, salary: salary)/10)
        }
        
        let set = LineChartDataSet(entries: entries, label: "Line Data Set")
        
        let color1 = UIColor(hex: "#FEC472FF") ?? .systemOrange
        let color2 = UIColor(hex: "#01BC5CFF") ?? .systemGreen
        
        set.setCircleColors(color1, color2)
        set.circleHoleRadius = 0
        set.circleRadius = 6
        
        set.setColor(color1)
        set.axisDependency = .right
        set.highlightLineWidth = 0
        set.drawValuesEnabled = false
        
        return LineChartData(dataSet: set)
    }
}
