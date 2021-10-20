//
//  ProfileViewController.swift
//  Calorie_App
//
//  Created by student on 10/18/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var CircularProgress: CircularProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let cp = CircularProgressView(frame: CGRect(x: 10.0, y: 10.0, width: 100.0, height: 100.0))
//        cp.trackColor = UIColor.red
//        cp.progressColor = UIColor.yellow
//        cp.tag = 101
//        self.view.addSubview(cp)
//        cp.center = self.view.center
//
//        self.perform(#selector(animateProgress), with: nil, afterDelay: 2.0)
        CircularProgress.trackColor = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        CircularProgress.progressColor = UIColor(red: 157.0/255.0, green: 237.0/255.0, blue: 164.0/255.0, alpha: 1.0)
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: 0.6)
        
        percentLabel.text = String(CircularProgress.percentTextValue) + "%"
        print(percentLabel.text)
    }

    @objc func animateProgress() {
        let cp = self.view.viewWithTag(101) as! CircularProgressView
        cp.setProgressWithAnimation(duration: 1.0, value: 0.7)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
