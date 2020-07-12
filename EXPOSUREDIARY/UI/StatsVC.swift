//
//  StatsVC.swift
//  EXPOSUREDIARY
//
//  Created by Ryan Belan on 7/10/20.
//  Copyright © 2020 University of Rochester. All rights reserved.
//

import UIKit
import CoreData

class StatsVC: UIViewController {
    
    
    var tmileage: Int = 0
    var tdistance: Int = 0
    var tcontacts: Int = 0
    var tPlaces: Int = 0
    var longestDistance: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        calculateTrip()
        totalMileage.text = String(tmileage)
        totalDuration.text = String(tdistance)
        totalContacts.text = String(tcontacts)
        totalPlaces.text = String(tPlaces)
        totalDistance.text = longestDistance
    }
   
    @IBOutlet weak var totalMileage: UILabel!
    @IBOutlet weak var totalDuration: UILabel!
    @IBOutlet weak var totalContacts: UILabel!
    @IBOutlet weak var totalPlaces: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    
    
    
    func calculateTrip(){
        do{
            let data: [NSManagedObject] = try AppDelegate.cdContext.fetch(NSFetchRequest<NSManagedObject>(entityName: "Entry"))
            var tempD: Int = 0
            for temp in data {
                tmileage += (temp.value(forKeyPath: "mileage") as? NSString)!.integerValue
                tdistance += (temp.value(forKeyPath: "duration")as? NSString)!.integerValue
                tcontacts += (temp.value(forKeyPath: "contacts") as? NSString)!.integerValue
                tPlaces += 1
                if((temp.value(forKeyPath: "mileage") as? NSString)!.integerValue > tempD){
                    longestDistance = temp.value(forKeyPath: "title") as! String
                    tempD = (temp.value(forKeyPath: "mileage") as? NSString)!.integerValue
                }
            }
        }catch _ as NSError {
            print("Couldn't read data")
        }
        
    }
}
