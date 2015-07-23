//
//  ViewController.swift
//  json_display_in_table
//
//  Created by Christopher Nixon on 7/20/15.
//  Copyright (c) 2015 Christopher Nixon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tableView: UITableView!
    var items: [String] = []
    
    @IBOutlet weak var nav: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = []
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        loadTableItems()
    }
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        println("You selected cell #\(indexPath.row)!")
//    }
    
    func loadTableItems() {
        
        DataManager.getDeparturesFromStopIdWithSuccess{ (data) -> Void in
        //DataManager.getTopAppsDataFromItunesWithSuccess { (data) -> Void in
            // Get #1 app name using SwiftyJSON
            let json = JSON(data: data)
            let count = json["data"]["entry"]["arrivalsAndDepartures"].count
            for index in 0...count - 1 {
                let tripHeadsign = json["data"]["entry"]["arrivalsAndDepartures"][index]["tripHeadsign"].string
                let predictedDepartureTime = json["data"]["entry"]["arrivalsAndDepartures"][index]["predictedDepartureTime"].double
                
                let date = NSDate(timeIntervalSince1970: predictedDepartureTime!)
                let currentTime = NSDate().timeIntervalSince1970
                let currentTime2 = NSDate(timeIntervalSince1970: currentTime)
                //let localTime = NSDate.date()


                let date2 = NSDate()
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
                let hour = components.hour
                let minutes = components.minute
                
                //let timediff = predictedDepartureTime - currentTimeNumber
                
                
                var timeToDeparture = date.timeIntervalSinceDate(currentTime2)
                timeToDeparture = timeToDeparture / 60
                var b:String = String(stringInterpolationSegment: timeToDeparture)
                
                    let dateFormatter = NSDateFormatter()//3
                    
                    var theDateFormat = NSDateFormatterStyle.ShortStyle //5
                    let theTimeFormat = NSDateFormatterStyle.ShortStyle//6
                    
                    //dateFormatter.dateStyle = theDateFormat//8
                    dateFormatter.timeStyle = theTimeFormat//9
                    
                    let niceDate = dateFormatter.stringFromDate(date)//11
                
                var pdt:String = String(stringInterpolationSegment: predictedDepartureTime)

                
let hi = " - "
                let appName2 = tripHeadsign! + hi + niceDate
                self.items.append(appName2)
            }
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })
        }
    }
    
    
}
