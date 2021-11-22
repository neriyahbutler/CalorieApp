//
//  CalBurnViewController.swift
//  Calorie_App
//
//  Created by student on 10/27/21.
//

import UIKit
import FirebaseDatabase

struct CalBurnInfo: Codable {
    init() {
        exerciseName = ""
        caloriesRate = 0
    }
    var exerciseName: String
    var caloriesRate: Int
}

class CalBurnViewController: UIViewController, CustomAlertDelegate {
    
    var info = [CalBurnInfo]()
    var selectedExercise = CalBurnInfo()
    var username = "neriyahbutler"
    
    var userCaloriesBurned = 0
    var userTargetCalories = 0
        
    @IBOutlet weak var caloriesBurnedLabel: UILabel!
    @IBOutlet weak var exerciseSearch: UISearchBar!
    let ref = Database.database().reference()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadCaloriesBurned(username: username)
        updateTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadCaloriesBurned(username: "neriyahbutler")
    }
    
    @IBAction func exerciseSearchButtton(_ sender: Any) {
        let exerciseInput = self.exerciseSearch.text
        if exerciseInput != nil {
            for i in 0...self.info.count - 1 {
                if self.info[i].exerciseName == exerciseInput {
                    let indexPath = NSIndexPath(row: i, section: 0)
                    self.tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
                }
            }
        }
    }
    
    func loadCaloriesBurned(username: String) {
        ref.child("accounts").child(username).observe(.value, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                self.caloriesBurnedLabel.text = "\(dictionary["caloriesBurned"] as! Int) Cal"
            }
        })
    }

    func okButton(title: String, message: String, weightInput: String, repInput: String, setInput: String) {
        if let weight = Int(weightInput) {
            if let reps = Int(repInput) {
                if let sets = Int(setInput) {
                    
                    // This is a dummy calculation, not a legitimate one
                    let caloriesBurned = weight * reps * sets
                    ref.child("accounts").child(username).child("caloriesBurned").setValue(self.userCaloriesBurned + caloriesBurned)
                }
            }
        }
    }

    func cancelButton() {
        print("Cancel")
    }
}

extension CalBurnViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedExercise = self.info[indexPath.row]
        
        let customAlert = self.storyboard?.instantiateViewController(identifier: "CustomAlertViewController") as! CustomAlertViewController
        customAlert.delegate = self
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalTransitionStyle = .crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let exerciseName = cell.viewWithTag(1) as! UILabel
        exerciseName.text = self.info[indexPath.row].exerciseName
        return cell
    }
    
    func updateTable() {
        let ref = Database.database().reference()
        
        ref.child("exercises").observeSingleEvent(of: .value) {(snapshot) in
            let userCaloriesList = snapshot.value as? [String:Any]
            if userCaloriesList != nil {
                userCaloriesList!.forEach { item in
                    let exerciseCalorieDict = Dictionary<String, Any>(dictionaryLiteral: item)
                    for key in exerciseCalorieDict.keys {
                        let userCalories = exerciseCalorieDict[key] as? Dictionary<String, Any>
                        var exerciseInfo = CalBurnInfo()
                        
                        exerciseInfo.exerciseName = userCalories!["exercise"] as! String
                        exerciseInfo.caloriesRate = userCalories!["caloriesRate"] as! Int
                        
                        self.info.append(exerciseInfo)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
}
