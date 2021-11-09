//
//  SettingsViewController.swift
//  Calorie_App
//
//  Created by student on 11/8/21.
//

import UIKit
import FirebaseDatabase

class SettingsViewController: UIViewController, CustomAlertSettingsHistoryDelegate {
    let ref = Database.database().reference()
    let username = "neriyahbutler"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeFirstName(_ sender: Any) {
        performSegue(withIdentifier: "settingsToName", sender: self)
    }
    
    @IBAction func changeTarget(_ sender: Any) {
        performSegue(withIdentifier: "settingsToTarget", sender: self)
    }
    
    @IBAction func clearHistory(_ sender: Any) {
        let customAlert = self.storyboard?.instantiateViewController(identifier: "CustomAlertSettingsHistoryViewController") as! CustomAlertSettingsHistoryViewController
        customAlert.delegate = self
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalTransitionStyle = .crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    }
    
    @IBAction func changePassword(_ sender: Any) {
        performSegue(withIdentifier: "settingsToPassword", sender: self)
    }
    
    @IBAction func logout(_ sender: Any) {
    }
    
    func okButton() {
        ref.child("accounts").child(username).child("caloriesBurned").setValue(0)
        ref.child("accounts").child(username).child("foodIntake").setValue(0)
        ref.child("accounts").child(username).child("targetDeficit").setValue(0)
        
        ref.child("dailycalorieintake").child(username).setValue([])
    }

    func cancelButton() {
        print("it hurts so much")
    }
}
