//
//  MainTVC.swift
//  EXPOSUREDIARY
//
//  Created by Ryan Belan on 7/10/20.
//  Copyright © 2020 University of Rochester. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var labelOutput: UILabel!
    @IBOutlet weak var purposeOutput: UILabel!
    @IBOutlet weak var durationOutput: UILabel!
    @IBOutlet weak var mileageOutput: UILabel!
    @IBOutlet weak var contactsOutput: UILabel!
    @IBOutlet weak var imageOutput: UIImageView!
    
}

class MainTVC: UITableViewController {

    
    
    var data: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
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
        cell.labelOutput.text = temp.value(forKeyPath: "title") as? String
        cell.purposeOutput.text = temp.value(forKeyPath: "purpose") as? String
        cell.durationOutput.text = temp.value(forKeyPath: "duration") as? String
        cell.mileageOutput.text = temp.value(forKey: "mileage") as? String
        cell.contactsOutput.text = temp.value(forKey: "contacts") as? String

        return cell
    }
    
    //MARK: - Seque unwind
    @IBAction func unwindToTVC(_ unwindSegue: UIStoryboardSegue) {
        readData()
        tableView.reloadData()
    }
    
    //MARK: - CoreData
    
    func readData() {
        let context = AppDelegate.cdContext
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Entry")
        do {
            data = try context.fetch(fetch)
        } catch _ as NSError {
            print("Could not fetch requested item.")
        }
        tableView.reloadData()
    }

}
