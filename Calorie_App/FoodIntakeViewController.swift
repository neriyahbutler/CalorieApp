//
//  FoodIntakeViewController.swift
//  Calorie_App
//
//  Created by student on 10/23/21.
//

import UIKit
import FirebaseDatabase

struct CalorieIntakeInfo: Codable {
    init() {
        foodName = ""
        calories = 0
    }
    var foodName: String;
    var calories: Int
}

class FoodIntakeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var info = [CalorieIntakeInfo]()
    
    @IBOutlet weak var foodSearchBar: UISearchBar!
    @IBOutlet weak var targetCalories: UILabel!
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var historyTableView: UITableView!
    
    let userTargetCalories = 3000
    let ref = Database.database().reference()
    
    var username: String = "neriyahbutler"
    var currentUserCalories = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [self.view .bringSubviewToFront(self.historyTableView)]
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        self.updateTable()
        loadFoodIntake()
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        let profileTab = self.tabBarController?.children[0] as! ProfileViewController
//        profileTab.currentUserIntake = currentUserCalories
//    }
    
    func loadFoodIntake() {
        ref.child("accounts").child(self.username).observe(.value, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                self.targetCalories.text = "\(dictionary["foodIntake"] as! Int) Cal"
                self.currentUserCalories = dictionary["foodIntake"] as! Int
            }
        })
    }
    
    func insertToTable()
    {
        let foodName = self.foodSearchBar!.text
        let foodCalories = 90
        
        ref.child("dailycalorieintake").child(self.username).childByAutoId().setValue(["food": foodName, "calories":foodCalories])
        
        self.currentUserCalories += foodCalories
        ref.child("accounts").child(self.username).child("foodIntake").setValue(self.currentUserCalories)
        
        updateTable()
    }
    
    func updateTable()
    {
        currentUserCalories = 0
        
        ref.child("dailycalorieintake").child(self.username).observeSingleEvent(of: .value) {(snapshot) in
            let userCaloriesList = snapshot.value as? [String:Any]
            if userCaloriesList != nil {
                userCaloriesList!.forEach { item in
                    let userCalorieDict = Dictionary<String, Any>(dictionaryLiteral: item)
                    for key in userCalorieDict.keys {
                        let userCalories = userCalorieDict[key] as? Dictionary<String, Any>
                        var calorieInfo = CalorieIntakeInfo()
                        
                        calorieInfo.foodName = userCalories!["food"] as! String
                        calorieInfo.calories = userCalories!["calories"] as! Int
                                        
                        self.info.append(calorieInfo)
                    }
                }
                self.historyTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.historyTableView.dequeueReusableCell(withIdentifier: "food_cell", for: indexPath)
        
        let foodName = cell.viewWithTag(1) as! UILabel
        let calorieAmount = cell.viewWithTag(2) as! UILabel

        if self.info.count > 0 {
            let tempCalorieInfo = self.info[indexPath.row]
            foodName.text = tempCalorieInfo.foodName
            calorieAmount.text = String(tempCalorieInfo.calories)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.info.count
    }
    
    @IBAction func foodSubmit(_ sender: Any) {
        insertToTable()
        loadFoodIntake()
    }
}
