//
//  TimerIC.swift
//  RunningMan WatchKit Extension
//
//  Created by Velkei Miklós on 2018. 01. 14..
//  Copyright © 2018. NeonatCore. All rights reserved.
//

import WatchKit
import Foundation


class TimerIC: WKInterfaceController {
    
    @IBOutlet private var countdownTimer: WKInterfaceTimer!
    @IBOutlet private var caloriesLbl: WKInterfaceLabel!
    @IBOutlet private var playBtn: WKInterfaceButton!
    @IBOutlet private var pauseBtn: WKInterfaceButton!
    
    private var isPaused = false
    private var endTime: Date!
    private var timePointPaused: Date?
    private var calorieTimer: Timer!//a kalóriához egy saját változó
    private var calories = 0.0
    private var calorieBurn = 0.2//ennyi kalória égestése másodpercenként
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let runTime = context as? Int{
            print(runTime)
            endTime = Date(timeIntervalSinceNow: TimeInterval(runTime * 60))
            countdownTimer.setDate(endTime)
            countdownTimer.start()
        }
        playBtn.setAlpha(0.4)
        startCalorieTimer()
    }
    @IBAction func playBtnWasPressed() {
        if isPaused{
            countdownTimer.start()
            playBtn.setAlpha(0.4)
            pauseBtn.setAlpha(1.0)
            isPaused = false
            
            if let timePaused = timePointPaused{
                let durationPaused = Date().timeIntervalSince(timePaused)
                endTime = Date(timeInterval: durationPaused, since: endTime)
                countdownTimer.setDate(endTime)
                countdownTimer.start()
                startCalorieTimer()
            }
        }
        
        
    }
    
    @IBAction func pauseBtnWasPressed() {
        if !isPaused{
            countdownTimer.stop()
            calorieTimer.invalidate()//kill a timer
            playBtn.setAlpha(1.0)
            pauseBtn.setAlpha(0.4)
            isPaused = true
            timePointPaused = Date()//amikor megnyomtuk init
        }
        
    }
    
    @IBAction func cancelBtnWasPressed() {
        popToRootController()//self.dismiss..
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @objc func refreshCalories(){
        calories += calorieBurn
        caloriesLbl.setText("Calories: \(Int(calories))")
    }
    
    func startCalorieTimer() {
        calorieTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refreshCalories), userInfo: nil, repeats: true)
    }
    
}
