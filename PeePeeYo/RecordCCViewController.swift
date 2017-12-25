//
//  RecordCCViewController.swift
//  PeePeeYo
//
//  Created by kobe on 2017/12/16.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit

class RecordCCViewController: UITableViewController {

    @IBOutlet weak var ccTextField: UITextField!
    var currentCC:EachCC!
    @IBOutlet weak var bodyTemperature: UITextField!
    @IBOutlet weak var highP: UITextField!
    @IBOutlet weak var lowP: UITextField!
    @IBOutlet weak var heartRate: UITextField!
    @IBOutlet weak var breath: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ccTextField.becomeFirstResponder()
        ccTextField.keyboardType = .decimalPad
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let date = Date()
        /*
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
 */
        
        //if let ccFloat = Float(ccTextField.text!) {
        
        print("EachCC data ok.")
            //currentCC = EachCC(time:date, cc:Float(bodyTemperature), )
        currentCC = EachCC(time: date, HighP: Int(highP.text!), LowP: Int(lowP.text!), bodyTemperature: Float(bodyTemperature.text!), heartRate: Int(heartRate.text!), breathe: Int(breath.text!))
        //}
      
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
