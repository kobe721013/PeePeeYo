//
//  TestTableViewController.swift
//  PeePeeYo
//
//  Created by kobe on 2017/12/16.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit


class TestTableViewController: UITableViewController {

    //var dayCCArray = [DayCC]()//[String:[EachCC]]()
    var eachCCArray = [EachCC]()
    var daysCC:[DayCC]!
    
    var dateIndex=[String:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let someDateTime = formatter.string(from: date)
        print("testDate=\(someDateTime)")
        
        /*
        let countryCodes = ["BR": "Brazil", "GH": "Ghana", "JP": "Japan"]
        let index = countryCodes.index(forKey: "JP")
        let firstKey = Array(countryCodes.keys)[0] // or .first
        print("firstKey=\(firstKey)")
        print("Country code for \(countryCodes[index!].value): '\(countryCodes[index!].key)'.")
        */
        
        if let daysCC = DayCC.readDaysCCFromFile() {
            self.daysCC = daysCC
            var index = 0
            for dayCC in daysCC {
                dateIndex[dayCC.date] = index
                index += 1
            }
        }
        else {
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
        let eachCC = EachCC(time: Date(), cc: Float(ccController.ccTextField.text!))
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd"
        
        let dateString = dateFormater.string(from: eachCC.time)
        print("dateString = \(dateString)")
        
        var section = 0
        var row = 0
        if let index = dateIndex[dateString] {
           
            section = index
            var daycc = daysCC[index]
            daycc.eachCCArray.append(eachCC)
            daysCC[index] = daycc
            row = daycc.eachCCArray.count - 1
             print("already exist. count = \(daycc.eachCCArray.count)")
        }
        else {
            section = dateIndex.count
            dateIndex[dateString] = dateIndex.count
            
            var daycc = DayCC()
            daycc.date = dateString
            daycc.eachCCArray.append(eachCC)
            daysCC.append(daycc)
            print("daysCC count = \(daysCC.count)")
        }
        print("section = \(section), row = \(row)")
        //let indexPath = IndexPath(row: row, section: section)
        
        tableView.beginUpdates()
        print("numberOfSections=\(self.tableView.numberOfSections)")
        if self.tableView.numberOfSections < section + 1 {
            let indexset = IndexSet(integer: section)
            self.tableView.insertSections(indexset , with: .automatic) //insertSections(IndexSet(index: section), with: .Automatic)
        } else {
            //self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            tableView.insertRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        //tableView.insertRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        
        tableView.endUpdates()
      
        
        /*
        eachCCArray.insert(ccController.currentCC, at: 0)//(ccController.currentCC)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        */
        
        /*
        let dateTime = ccController.currentCC.time
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_hh:mm"
        let date = formatter.string(from: dateTime)
        */
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ccCell", for: indexPath) as! CCTableViewCell
        
        let eachCC =  daysCC[indexPath.section].eachCCArray[indexPath.row]//eachCCArray[indexPath.row]
        let dateTime = eachCC.time
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let time = formatter.string(from: dateTime)
        
        cell.ccLabel.text = String(eachCC.cc)
        cell.timeLabel.text = time
        // Configure the cell...
        
        return cell
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
