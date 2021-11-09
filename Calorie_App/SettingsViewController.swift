//
//  SettingsViewController.swift
//  Calorie_App
//
//  Created by student on 11/8/21.
//

import UIKit

class SettingsViewController: UIViewController, CustomAlertSettingsHistoryDelegate {

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
        print("help me")
    }

    func cancelButton() {
        print("it hurts so much")
    }
}
