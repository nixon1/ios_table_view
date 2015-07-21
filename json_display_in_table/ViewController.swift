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
    var items: [String] = ["We"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableItems()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
        DataManager.getTopAppsDataFromFileWithSuccess { (data) -> Void in
            // Get #1 app name using SwiftyJSON
            let json = JSON(data: data)
            /*if let appName = json["feed"]["entry"][0]["im:name"]["label"].string {
            println("SwiftyJSON: \(appName)")
            self.items = ["\(appName)", "yo", "Whatsup"]
            }
            */
            for index in 0...8 {
                let appName2 = json["feed"]["entry"][index]["im:name"]["label"].string
                self.items.append(appName2!)
            }
            self.tableView.reloadData()
        }
    }
    
    
}
