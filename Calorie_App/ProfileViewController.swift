//
//  ProfileViewController.swift
//  Calorie_App
//
//  Created by student on 10/18/21.
//

import UIKit
import FirebaseDatabase

class ProfileViewController: UIViewController, CustomAlertSettingsDelegate {
    let ref = Database.database().reference()
    
    var percentProgress: Float = 0.7
    var currentUserBurned: Int = 0
    var currentUserIntake: Int = 0
    var userTargetDeficit: Int = 0
    
    var username: String = "neriyahbutler"
    
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var CircularProgress: CircularProgressView!
    @IBOutlet weak var foodIntakeLabel: UILabel!
    @IBOutlet weak var caloriesBurnedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUserDetails()
        
        handlePercentColor()
        
        CircularProgress.trackColor = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: Float(self.percentProgress))
        
        percentLabel.text = String(self.percentProgress * 100) + "%"
        percentLabel.layer.zPosition = 2
    }

    override func viewDidAppear(_ animated: Bool) {
        loadUserDetails()
        animateProgress()
    }
    
    func handlePercentColor() {
        if self.percentProgress < 0.5 {
            CircularProgress.progressColor = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        } else {
            CircularProgress.progressColor = UIColor(red: 157.0/255.0, green: 237.0/255.0, blue: 164.0/255.0, alpha: 1.0)
        }
    }
    
    func okButton(targetDeficitInput: Int) {
        ref.child("accounts").child(self.username).child("targetDeficit").setValue(targetDeficitInput)
        print(targetDeficitInput, "was the value inputted")
        
        self.userTargetDeficit = targetDeficitInput
        
        loadUserDetails()
        animateProgress()
    }
    
    func cancelButton() {
        print("ok")
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        let customAlert = self.storyboard?.instantiateViewController(identifier: "CustomAlertSettingsViewController") as! CustomAlertSettingsViewController
        customAlert.delegate = self
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalTransitionStyle = .crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    }
    
    
    func loadUserDetails() {
        ref.child("accounts").child(self.username).observe(.value, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                self.currentUserIntake = dictionary["foodIntake"] as! Int
                self.currentUserBurned = dictionary["caloriesBurned"] as! Int
                self.userTargetDeficit = dictionary["targetDeficit"] as! Int
                print("Target is", self.userTargetDeficit)
            }
        })
        
        self.foodIntakeLabel.text = "\(String(self.currentUserIntake)) Cal"
        self.caloriesBurnedLabel.text = "\(String(self.currentUserBurned)) Cal"
        
        if self.userTargetDeficit != 0 {
            self.percentProgress = Float((currentUserIntake - currentUserBurned))/Float((userTargetDeficit))
            self.percentProgress = round(self.percentProgress * 10.0) / 10.0
        } else {
            self.percentProgress = 0
        }
        handlePercentColor()
    }
    
    @objc func animateProgress() {
        let cp = self.view.viewWithTag(101) as! CircularProgressView
        cp.setProgressWithAnimation(duration: 1.0, value: self.percentProgress)
        
        percentLabel.text = String(self.percentProgress * 100) + "%"
        percentLabel.layer.zPosition = 2
    }

}
