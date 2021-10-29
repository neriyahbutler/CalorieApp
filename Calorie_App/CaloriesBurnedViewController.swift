//
//  CaloriesBurnedViewController.swift
//  Calorie_App
//
//  Created by student on 10/26/21.
//

import UIKit
import FirebaseDatabase

struct CaloriesBurnedInfo: Codable {
    init() {
        exerciseName = ""
        caloriesRate = 0
    }
    var exerciseName: String;
    var caloriesRate: Int;
}

class CaloriesBurnedViewController: UIViewController{

    @IBOutlet weak var exerciseSearchBar: UISearchBar!
    @IBOutlet weak var caloriesBurnedLabel: UILabel!
    @IBOutlet weak var stepsTakenLabel: UILabel!
    @IBOutlet weak var exerciseTableView: UITableView!
    
    var info = [CaloriesBurnedInfo]()
    var selectedExercise = CaloriesBurnedInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        exerciseTableView.allowsSelection = true
        
        updateTable()
        // Do any additional setup after loading the view.
    }
    
    func updateTable()
    {
        let ref = Database.database().reference()
        
        ref.child("exercises").observeSingleEvent(of: .value) {(snapshot) in
            let userCaloriesList = snapshot.value as? [String:Any]
            if userCaloriesList != nil {
                userCaloriesList!.forEach { item in
                    let exerciseCalorieDict = Dictionary<String, Any>(dictionaryLiteral: item)
                    for key in exerciseCalorieDict.keys {
                        let userCalories = exerciseCalorieDict[key] as? Dictionary<String, Any>
                        var exerciseInfo = CaloriesBurnedInfo()
                        
                        exerciseInfo.exerciseName = userCalories!["exercise"] as! String
                        exerciseInfo.caloriesRate = userCalories!["caloriesRate"] as! Int
                        
                        self.info.append(exerciseInfo)
                    }
                }
                print(self.info)
                self.exerciseTableView.reloadData()
            }
        }
    }
    
    
    @IBAction func exerciseSubmit(_ sender: Any) {
    }
    
}

extension CaloriesBurnedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(info[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.exerciseTableView.dequeueReusableCell(withIdentifier: "exercise_cell", for: indexPath)
        
        let exerciseName = cell.viewWithTag(1) as! UILabel
        
        if self.info.count > 0 {
            let tempExerciseInfo = self.info[indexPath.row]
            
            exerciseName.text = tempExerciseInfo.exerciseName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.info.count
    }

}
