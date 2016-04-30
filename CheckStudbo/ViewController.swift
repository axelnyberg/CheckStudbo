//
//  ViewController.swift
//  CheckStudbo
//
//  Created by Axel Nyberg on 14/03/16.
//  Copyright © 2016 Axel Nyberg. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    
    @IBOutlet var Label: UILabel!
    @IBOutlet var GoStudbo: UIButton!
    var change: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "update", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func GoStud(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string:"http://www.studbo.se/HSS/Object/object_list.aspx?cmguid=dee9b16d-7b30-470d-a80a-50857e4c0c61&objectgroup=1")!)
        
    }
    
    func update() {
        
        
        
        
        let myURLString = "http://www.studbo.se/HSS/Object/object_list.aspx?cmguid=dee9b16d-7b30-470d-a80a-50857e4c0c61&objectgroup=1"
        
        let myURL = NSURL(string: myURLString)
        do{
            
            let htmlstring = try NSString(contentsOfURL: myURL!, encoding: NSWindowsCP1252StringEncoding) as String!
            let range = htmlstring.rangeOfString("poster")!
            let startindex = range.startIndex.advancedBy(8)
            let amount1 = htmlstring.substringFromIndex(startindex)
            let amount2 = amount1[amount1.startIndex]
            
            if(change != String(amount2))
            {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                change = String(amount2)
                Label.text = "Antal lägenheter: \(change)"
                let alertController = UIAlertController(title: "Status", message:
                    "Studbo has changed", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            else{
                change = String(amount2)
                print(change)
                
                Label.text = "Antal lägenheter: \(change)"
            }
            
        }
        catch {
            print(error)
        }
        
    }


}

