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
    
    //stat var
    var tmileage: Int = 0
    var tdistance: Int = 0
    var tcontacts: Int = 0
    var tPlaces: Int = 0
    var longestDistance: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        calculateTrip()
        
        //localization
        totalMileage.text = NSLocalizedString("str_totalMileage", comment: "")
        totalDuration.text = NSLocalizedString("str_totalDuration", comment: "")
        totalContacts.text = NSLocalizedString("str_totalContacts", comment: "")
        totalPlaces.text = NSLocalizedString("str_totalPlaces", comment: "")
        totalDistance.text = NSLocalizedString("str_totalDistance", comment: "")
        mainTitle.text = NSLocalizedString("str_mainTitle", comment: "")
            
        //display stat results
        totalMileage.text = String(tmileage)
        totalDuration.text = String(tdistance)
        totalContacts.text = String(tcontacts)
        totalPlaces.text = String(tPlaces)
        totalDistance.text = longestDistance
        
        //Warns(Alert) user when in contact with to many people
        if(tcontacts > 10){
            alertContacts()
        }
    }
   
    @IBOutlet weak var totalMileage: UILabel!
    @IBOutlet weak var totalDuration: UILabel!
    @IBOutlet weak var totalContacts: UILabel!
    @IBOutlet weak var totalPlaces: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    
    
    //This method calculates the results from CoreData 
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
    
    //MARK: - Alert
    func alertContacts(){
        let alert = UIAlertController(title: NSLocalizedString("str_alertWarning", comment: ""), message: NSLocalizedString("str_alertMessage", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
