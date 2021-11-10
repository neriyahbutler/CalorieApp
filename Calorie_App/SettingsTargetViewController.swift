//
//  SettingsTargetViewController.swift
//  Calorie_App
//
//  Created by student on 11/9/21.
//

import UIKit
import FirebaseDatabase

class SettingsTargetViewController: UIViewController {
    let ref = Database.database().reference()
    @IBOutlet weak var userInput: UITextField!
    let username = "neriyahbutler"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
    }
 
    @IBAction func saveButton(_ sender: Any) {
        if !(userInput.text!.isEmpty) {
            let intUserInput = Int(userInput.text!)
            
            if intUserInput != nil {
                ref.child("accounts").child(username).child("targetDeficit").setValue(intUserInput)
                
                userInput.text = ""
                
                let alertView = UIAlertController(title: "Target Caloric Deficit Saved", message: "Your target caloric deficit has been successfully updated", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
                
                self.present(alertView, animated: true, completion: nil)
            } else {
                let alertView = UIAlertController(title: "Invalid User Input", message: "Please only enter numbers as your input", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
                
                self.present(alertView, animated: true, completion: nil)
            }
        } else {
            let alertView = UIAlertController(title: "Missing User Input", message: "Please enter your target caloric deficit", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
}
