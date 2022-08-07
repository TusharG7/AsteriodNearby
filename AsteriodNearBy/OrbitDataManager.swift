//
//  OrbitDataManager.swift
//  AsteriodNearBy
//
//  Created by Admin on 06/08/22.
//

import Foundation
import Charts

class OrbitDataManager {
    
    var astros = [String: [Astro]]()
    var rangeOfDays: Int = 0
    
    let urlApi = "https://api.nasa.gov/neo/rest/v1/feed?api_key=fl8cJQrkncvWj2wEhnMG6dBWuVV10Sh9TxaBe1Sd"
    
    func getData(from: String?, to: String?) {
        if let from = from, let to = to {
            let url = "\(urlApi)&start_date=\(from)&end_date=\(to)"
//            print(url)
            performRequest(with: url)
        }
    }
    
    func performRequest(with url: String){
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let asteriods = try decoder.decode(OrbitData.self, from: safeData) as OrbitData
                                print(asteriods.element_count)
                            DispatchQueue.main.async {
                                self.rangeOfDays = asteriods.near_earth_objects.count
                                self.astros =  asteriods.near_earth_objects
                            }

                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func setData(with chartData: [ChartDataEntry],lineChartView: LineChartView) {
        let set1 = LineChartDataSet(entries: chartData, label: "Nearby Earth Objects")
        let data = LineChartData(dataSet: set1)
        lineChartView.data = data
        DispatchQueue.main.async {
            lineChartView.reloadInputViews()
            lineChartView.animate(xAxisDuration: 1.2)
        }
        
    }
    
    func createData(with chartData: [ChartDataEntry]) -> [ChartDataEntry] {
        var safeChartData = chartData
        for i in 0..<rangeOfDays {
            lazy var noOfObjectsOnSpecificDay = Array(astros)[i].value.count
            for i in 0..<noOfObjectsOnSpecificDay {
                lazy var objectName = Array(astros)[i].value[i].name
                var entry =  ChartDataEntry(x: i.doubleValue, y: noOfObjectsOnSpecificDay.doubleValue, data: objectName)
                safeChartData.append(entry)
            }
        }; return safeChartData
    }
    
}
