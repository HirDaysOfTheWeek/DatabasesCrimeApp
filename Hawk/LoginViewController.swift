//
//  LoginViewController.swift
//  Hawk
//
//  Created by Tanya B on 11/23/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    var userId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let background =  UIColor.init(red: 125/255, green: 77/255, blue: 255/255, alpha: 1.0)
        self.view.backgroundColor = background
        self.navigationController?.navigationBar.barTintColor = background
        
        //self.view.backgroundColor = [UIColor b];
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = UserDefaults.standard
        let u = defaults.string(forKey: "userId")
        self.userId = u
        if u != nil {
            self.performSegue(withIdentifier: "loginSuccessful", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doLogin(_ sender: Any) {
        let username = usernameField.text
        let password = passwordField.text
        if username != nil && password != nil {
            Networking.login(userId: username!, password: password!, completionHandler: {response, error in
                let status:String = response?.value(forKey: "status") as! String
                let okayStatus = "ok"
                if status == okayStatus {
                    //next screen
                    self.userId = response?.value(forKey: "userId") as! String
                    let defaults = UserDefaults.standard
                    defaults.set(self.userId, forKey: "userId")
                    self.performSegue(withIdentifier: "loginSuccessful", sender: self)
                }
                else {
                    let message:String = response?.value(forKey: "message") as! String
                    let alert = UIAlertController(title: "Whoops", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }

    }
  
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccessful" {
        print("woohoo")
        let destination = segue.destination as! GodViewController
        destination.username = self.userId
        }
    }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

}


