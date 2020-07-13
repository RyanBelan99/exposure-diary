//
//  MainTVC.swift
//  EXPOSUREDIARY
//
//  Created by Ryan Belan on 7/10/20.
//  Copyright © 2020 University of Rochester. All rights reserved.
//

import UIKit
import CoreData

//Main Cell Class
class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var labelOutput: UILabel!
    @IBOutlet weak var purposeOutput: UILabel!
    @IBOutlet weak var durationOutput: UILabel!
    @IBOutlet weak var mileageOutput: UILabel!
    @IBOutlet weak var contactsOutput: UILabel!
    @IBOutlet weak var imageOutput: UIImageView!
    
    
    //localization
    @IBOutlet weak var labelOutputM: UILabel!
    @IBOutlet weak var purposeOutputM: UILabel!
    @IBOutlet weak var mileageOutputM: UILabel!
    @IBOutlet weak var durationOutputM: UILabel!
    @IBOutlet weak var contactsOutputM: UILabel!
}

class MainTVC: UITableViewController {
    var data: [NSManagedObject] = []
    
    @IBOutlet weak var statsButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        statsButton.title = NSLocalizedString("str_statsButton", comment: "")
        readData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! MainTableViewCell
        let temp = data[indexPath.row]
        //loading CoreData
        cell.labelOutput.text = temp.value(forKeyPath: "title") as? String
        cell.purposeOutput.text = temp.value(forKeyPath: "purpose") as? String
        cell.durationOutput.text = temp.value(forKeyPath: "duration") as? String
        cell.mileageOutput.text = temp.value(forKey: "mileage") as? String
        cell.contactsOutput.text = temp.value(forKey: "contacts") as? String
        
        //localization
        cell.labelOutputM.text = NSLocalizedString("str_CellLabel", comment: "")
        cell.purposeOutputM.text = NSLocalizedString("str_CellPurpose", comment: "")
        cell.durationOutputM.text = NSLocalizedString("str_CellDuration", comment: "")
        cell.mileageOutputM.text = NSLocalizedString("str_CellMileage", comment: "")
        cell.contactsOutputM.text = NSLocalizedString("str_CellContacts", comment: "")
        return cell
    }
    
    //MARK: - Seque unwind
    @IBAction func unwindToTVC(_ unwindSegue: UIStoryboardSegue) {
        readData()
        tableView.reloadData()
    }
    
    //MARK: - CoreData
    
    func readData() {
        do {
            data = try AppDelegate.cdContext.fetch(NSFetchRequest<NSManagedObject>(entityName: "Entry"))
        } catch _ as NSError {
            print("Could not fetch requested item.")
        }
        tableView.reloadData()
    }

}
