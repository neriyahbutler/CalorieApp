//
//  SettingsPasswordViewController.swift
//  Calorie_App
//
//  Created by student on 11/9/21.
//

import UIKit
import FirebaseDatabase

class SettingsPasswordViewController: UIViewController {
    let ref = Database.database().reference()
    let username = "neriyahbutler"
    @IBOutlet weak var userInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if !(userInput.text!.isEmpty) {
            let userInputVar = userInput.text!
            
            ref.child("accounts").child(username).child("password").setValue(userInputVar)
            
            userInput.text = ""
            
            let alertView = UIAlertController(title: "New Password Saved", message: "Your current password has been successfully updated", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            self.present(alertView, animated: true, completion: nil)
        } else {
            let alertView = UIAlertController(title: "Missing User Input", message: "Please enter your new password", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            self.present(alertView, animated: true, completion: nil)
        }
    }
}
