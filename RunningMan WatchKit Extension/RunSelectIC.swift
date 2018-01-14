//
//  InterfaceController.swift
//  RunningMan WatchKit Extension
//
//  Created by Velkei Miklós on 2018. 01. 14..
//  Copyright © 2018. NeonatCore. All rights reserved.
//

import WatchKit
import Foundation


class RunSelectIC: WKInterfaceController {

    
    //Outlets

    @IBOutlet var runPicker: WKInterfacePicker!
    @IBOutlet private var startBtn: WKInterfaceButton!
    //Variables
    private var selectedRunTime = 5 //5 perces futás
    private var runItems: [WKPickerItem] = []
    private var runTimes = [Int]()
    
    //viewDidLoad
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        for i in 0...16{
            
        }
        
    }
    
    @IBAction func runTimeChanged(_ value: Float) {
        selectedRunTime = Int(value)
        startBtn.setTitle("Start \(selectedRunTime) min run")
    }
    
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        if segueIdentifier == "toTimer"{
            return selectedRunTime
        }
        return nil
    }
    
    @IBAction func runPicked(_ value: Int) {
        
    }
    
}
