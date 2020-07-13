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
    
    //Picker view array choices
    let activities: [String] = ["str_Errands","str_Work","str_Vacation","str_Travel","str_Exercise","str_Visit","str_Outdoors","str_Other"]
    
    
    @IBOutlet weak var addTitle: UILabel!
    @IBOutlet weak var addPurpose: UILabel!
    @IBOutlet weak var addMileage: UILabel!
    @IBOutlet weak var addDuration: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactTitle: UILabel!
    
    @IBOutlet weak var titlefield: UITextField!
    @IBOutlet weak var purposePicker: UIPickerView!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var mileageField: UITextField!
    
   
    @IBOutlet weak var topLeftButton: UIBarButtonItem!
    @IBOutlet weak var ContactStepper: UIStepper!
    
    //updates UIStepper label
    //@Author - Arthur Roolfs
    var contact = 0 {
        willSet{
            contactLabel?.text = newValue.description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactStepper.value = 0
        titlefield.becomeFirstResponder()
        
        addTitle.text = NSLocalizedString("str_addTitle", comment: "")
        addPurpose.text = NSLocalizedString("str_addPurpose", comment: "")
        addMileage.text = NSLocalizedString("str_addMileage", comment: "")
        addDuration.text = NSLocalizedString("str_addDuration", comment: "")
        contactTitle.text = NSLocalizedString("str_contactLabel", comment: "")
        topLeftButton.title = NSLocalizedString("str_topLeftButton", comment: "")
    }
    
    //When stepper is activated label goes up or down
    @IBAction func stepperRecon(_ sender: UIStepper) {
        contact = Int(sender.value)
    }
    @IBAction func onAdd(_ sender: UIBarButtonItem) {
        
        //Alerts user when title is missing and prevents the add
        if(titlefield.text == ""){
            alertInput()
            return
        }
        
        //Adding new entry to CoreData
        let context = AppDelegate.cdContext
        if let entry = NSEntityDescription.entity(forEntityName: "Entry", in: context) {
            let data = NSManagedObject(entity: entry, insertInto: context)
            data.setValue(titlefield.text, forKey: "title")
            data.setValue(NSLocalizedString(activities[purposePicker.selectedRow(inComponent: 0)], comment: "") as String, forKey: "purpose")
            data.setValue(durationField.text ?? 0, forKey: "duration")
            data.setValue(mileageField.text ?? 0, forKey: "mileage")
            data.setValue(String(ContactStepper.value), forKey: "contacts")
            do {
                try context.save()
            }catch _ as NSError {
                print("Could not save the item.")
            }
            
        }
        //Segues back to UITableViewController
        performSegue(withIdentifier: "exitAddTC", sender: sender)
        presentingViewController?.dismiss(animated: true)
    }
    
    //MARK: - Alerts
    //Missing entry alert
    func alertInput(){
        let alert = UIAlertController(title: NSLocalizedString("str_alertTitle", comment: ""), message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("str_ok", comment: ""), style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    //Keyboard recon
    @IBAction func tapRecon(_ sender: UITapGestureRecognizer) {
        resignFirstResponder()
    }
    
    
}

//MARK: - UIPickerView

extension AddVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return NSLocalizedString(activities[row], comment: "")
    }
   
}
