//
//  DataSet.swift
//  PeePeeYo
//
//  Created by kobe on 2017/12/16.
//  Copyright © 2017年 kobe. All rights reserved.
//

import Foundation
struct EachCC : Codable{
    var time:Date!
    //var cc:Float!
    var highP:Int?
    var lowP:Int?
    var bodyTemperature:Float?
    var heartRate:Int?
    var breathe:Int?
}

struct DayCC : Codable {
    var date:String!
    var eachCCArray:[EachCC] = []
    
    static let doucumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static func saveToFile(daysCC:[DayCC]) {
        let propertyEncorder = PropertyListEncoder()
        if let data = try? propertyEncorder.encode(daysCC) {
            let url = DayCC.doucumentDirectory.appendingPathComponent("DayCC")
            try? data.write(to: url)
        }
    }
    
    static func readDaysCCFromFile() -> [DayCC]? {
        let propertyDecoder = PropertyListDecoder()
        let url = DayCC.doucumentDirectory.appendingPathComponent("DayCC")
        if let data = try? Data(contentsOf: url), let daysCC = try? propertyDecoder.decode([DayCC].self, from: data) {
            return daysCC
        } else {
            return nil
        }
    }
}
