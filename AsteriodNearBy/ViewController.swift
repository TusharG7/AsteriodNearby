//
//  ViewController.swift
//  AsteriodNearBy
//
//  Created by Admin on 04/08/22.
//

import UIKit
import Charts
import TinyConstraints

class ViewController: UIViewController {
    
    var orbitManager = OrbitDataManager()
    
    let dateFormatter = DateFormatter()
    

    @IBOutlet weak var pickerFrom: UIDatePicker!
    
    @IBOutlet weak var pickerTo: UIDatePicker!
    
    lazy var noOfAstrosInDouble: Double = orbitManager.rangeOfDays.doubleValue
    lazy var noOfAstrosInt: Int = orbitManager.rangeOfDays
    
    var chartData: [ChartDataEntry] = []
    
    
//    let values: [ChartDataEntry] = [
//        ChartDataEntry(x: 1.0, y: 1.0, data: "Astro1"),
//        ChartDataEntry(x: 2.0, y: 2.0, data: "Astro2")
//
//    ]
    
    var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        chartView.leftAxis.enabled = false
       
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(10, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .black
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.labelTextColor = .black
        
        return chartView
    }()
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        makeDataReq()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        lineChartView.reloadInputViews()
        
    }

}

//MARK: - ChartView Handler

extension ViewController {
    func makeDataReq() {
        let fromDate = dateFormatter.string(from: pickerFrom.date)
        let toDate = dateFormatter.string(from: pickerTo.date)

        
        orbitManager.getData(from: fromDate, to: toDate)
        
        self.chartData = orbitManager.createData(with: chartData)
        orbitManager.setData(with: chartData, lineChartView: lineChartView)
        
        
    }
    
}

//MARK: - Config

extension Int {
    var doubleValue: Double {
        return Double(self)
    }
}


