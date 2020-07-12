//
//  AddVC.swift
//  EXPOSUREDIARY
//
//  Created by Ryan Belan on 7/11/20.
//  Copyright © 2020 University of Rochester. All rights reserved.
//

import UIKit
import CoreData
class AddVC: UIViewController {
    
    let activities: [String] = ["Errands","Work","Vacation","Travel","Exercise","Visit","Outdoors","Other"]
    @IBOutlet weak var titlefield: UITextField!
    @IBOutlet weak var purposePicker: UIPickerView!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var mileageField: UITextField!
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var ContactStepper: UIStepper!
    
    var contact = 0 {
        willSet{
            contactLabel?.text = newValue.description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactStepper.value = 0
        titlefield.becomeFirstResponder()
    }
    
    @IBAction func stepperRecon(_ sender: UIStepper) {
        contact = Int(sender.value)
    }
    @IBAction func onAdd(_ sender: UIBarButtonItem) {
        let context = AppDelegate.cdContext
        if let entry = NSEntityDescription.entity(forEntityName: "Entry", in: context) {
            let data = NSManagedObject(entity: entry, insertInto: context)
            data.setValue(titlefield.text ?? "_", forKey: "title")
            data.setValue(activities[purposePicker.selectedRow(inComponent: 0)] as String, forKey: "purpose")
            data.setValue(durationField.text ?? 0, forKey: "duration")
            data.setValue(mileageField.text ?? 0, forKey: "mileage")
            data.setValue(String(ContactStepper.value), forKey: "contacts")
            do {
                try context.save()
            }catch _ as NSError {
                print("Could not save the item.")
            }
            
        }
        print("Done")
        performSegue(withIdentifier: "exitAddTC", sender: sender)
        presentingViewController?.dismiss(animated: true)
    }
}

extension AddVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activities[row]
    }
   
}
