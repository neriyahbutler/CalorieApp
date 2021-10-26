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
    var currentUserCalories = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [self.view .bringSubviewToFront(self.historyTableView)]
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        self.updateTable(username: "test")
        
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
//        ref.child("dailycalorieintake").child("neriyahbutler").childByAutoId().setValue(["food":"Pizza","calories":0])
        // Do any additional setup after loading the view.
    }
    
    func insertToTable(username: String)
    {
        let ref = Database.database().reference()
        
        let foodName = self.foodSearchBar!.text
        let foodCalories = 90
        
        ref.child("dailycalorieintake").child(username).childByAutoId().setValue(["food": foodName, "calories":foodCalories])
        
        self.currentUserCalories += foodCalories
        self.targetCalories.text = "\(String(self.currentUserCalories))/\(self.userTargetCalories)"
        updateTable(username: username)
    }
    
    func updateTable(username: String)
    {
        let ref = Database.database().reference()
        
        ref.child("dailycalorieintake").child(username).observeSingleEvent(of: .value) {(snapshot) in
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.historyTableView.dequeueReusableCell(withIdentifier: "food_cell", for: indexPath)
        
        let foodName = cell.viewWithTag(1) as! UILabel
        let calorieAmount = cell.viewWithTag(2) as! UILabel
//
        if self.info.count > 0 {
            let tempCalorieInfo = self.info[indexPath.row]
    //
            foodName.text = tempCalorieInfo.foodName
            calorieAmount.text = String(tempCalorieInfo.calories)
    //        cell.textLabel?.text = self.x[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("The length of info is \(self.info.count)")
        return self.info.count
    }
    
    @IBAction func foodSubmit(_ sender: Any) {
        insertToTable(username: "test")
    }
}
