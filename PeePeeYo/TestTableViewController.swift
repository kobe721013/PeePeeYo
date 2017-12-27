//
//  TestTableViewController.swift
//  PeePeeYo
//
//  Created by kobe on 2017/12/16.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit

extension Date {
    func formatDate2String(by format:String) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let someDateTime = formatter.string(from: self)
        return someDateTime
    }
}

class TestTableViewController: UITableViewController {

    //var dayCCArray = [DayCC]()//[String:[EachCC]]()
    var eachCCArray = [EachCC]()
    var daysCC:[DayCC]!
    
    var dateIndex=[String:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("App start Date=\(Date().formatDate2String(by :"yyyy/MM/dd HH:mm:ss"))")
       //loda data file
        if let daysCC = DayCC.readDaysCCFromFile() {
            //load data
            self.daysCC = daysCC
            var index = 0
            for dayCC in daysCC {
                dateIndex[dayCC.date] = index
                index += 1
            }
        }
        else {
            //no data exist
            self.daysCC = [DayCC]()
        }
    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return daysCC.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("session=\(section), count=\(daysCC[section].eachCCArray.count)")
        return daysCC[section].eachCCArray.count
    }

    @IBAction func eachCCRecordCome(for segue: UIStoryboardSegue){
        print("each CC come")
        
        let ccController = segue.source as! RecordCCViewController
        let eachCC = ccController.currentCC!//EachCC(time: Date(), cc: Float(ccController.ccTextField.text!))
        //let dateFormater = DateFormatter()
        //dateFormater.dateFormat = "yyyy/MM/dd"
        
        let dateString = eachCC.time.formatDate2String(by: "yyyy/MM/dd")//dateFormater.string(from: (eachCC?.time)!)
        print("dateString = \(String(describing: dateString))")
        
        var section = 0
        var row = 0
        if let index = dateIndex[dateString] {
            //day already has record.
            section = index
            var daycc = daysCC[index]
            daycc.eachCCArray.insert(eachCC, at: 0)//append(eachCC!)
            daysCC[index] = daycc
            print("already exist. count = \(daycc.eachCCArray.count)")
        }
        else {
            //day no any record, new section create
            section = dateIndex.count
            dateIndex[dateString] = dateIndex.count
            
            var daycc = DayCC()
            daycc.date = dateString
            daycc.eachCCArray.insert(eachCC, at:0)
            daysCC.append(daycc)
            print("daysCC count = \(daysCC.count)")
        }
        print("section = \(section), row = \(row)")
        
        //UI insert one row
        tableView.beginUpdates()
        print("numberOfSections=\(self.tableView.numberOfSections)")
        if self.tableView.numberOfSections < section + 1 {
            let indexset = IndexSet(integer: section)
            self.tableView.insertSections(indexset , with: .automatic) //insertSections(IndexSet(index: section), with: .Automatic)
        } else {
            //self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            tableView.insertRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        tableView.endUpdates()
      
        //save
        DayCC.saveToFile(daysCC: daysCC)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ccCell", for: indexPath) as! CCTableViewCell
        // Configure the cell...
        configure(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func configure(cell:CCTableViewCell, indexPath:IndexPath) {
        
        let eachCC =  daysCC[indexPath.section].eachCCArray[indexPath.row]//eachCCArray[indexPath.row]
        let time = eachCC.time.formatDate2String(by: "HH:mm")
        
        cell.timeLabel.text = time
        cell.highPLabel.text = eachCC.highP
        cell.lowPLabel.text = eachCC.lowP
        cell.bodyTemperatureLabel.text = eachCC.bodyTemperature
        cell.breatheLabel.text = eachCC.breathe
        cell.heartRateLabel.text = eachCC.heartRate
    }
    
 override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    {
        print("session title = \(daysCC[section].date)")
        return daysCC[section].date
    }
    
    override public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        if let headerView = view as? UITableViewHeaderFooterView {
            print("setting header label center")
            headerView.textLabel?.textAlignment = .center
            //headerView.add
        }
    
    }
    /*
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textAlignment = .Center
        }
    }
    */
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
