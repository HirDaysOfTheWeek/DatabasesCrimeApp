//
//  RegisterViewController.swift
//  Hawk
//
//  Created by Tanya B on 11/11/16.
//  Copyright © 2016 HirDaysOfTheWeek. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!

    var userId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        let bgImage = UIImage(named: "NYView.png")
        bgImage?.draw(in: self.view.bounds)
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: bgImage!)
        
        let background =  UIColor.init(red: 33/255, green: 33/255, blue: 33/255, alpha: 1.0)
        //self.view.backgroundColor = background
        self.navigationController?.navigationBar.barTintColor = background
        self.usernameField.textColor = .black
        self.emailField.textColor = .black
        self.passwordField.textColor = .black
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = UserDefaults.standard
        let u = defaults.string(forKey: "userId")
        self.userId = u
        if u != nil {
            //self.performSegue(withIdentifier: "registerSuccessful", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToLogin(_ sender: Any) {
    
    }
    
    
    @IBAction func doRegister(_ sender: Any) {


        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        if username != nil && email != nil && password != nil {
            Networking.register(userId: username!, email: email!, password: password!, completionHandler: {response, error in
            let status:String = response?.value(forKey: "status") as! String
            let okayStatus = "ok"
            if status == okayStatus {
                //next screen
                self.userId = response?.value(forKey: "userId") as! String
                let defaults = UserDefaults.standard
                defaults.set(self.userId, forKey: "userId")
                self.performSegue(withIdentifier: "registerSuccessful", sender: self)
            }
            else {
                let message:String = response?.value(forKey: "message") as! String
                print("message = \(message)")
            }
        
            })
        
        }
    }

    
    //create another viewController for login
    //make the button work 
    //make the register button work (just print for now)
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerSuccessful" {
            let destination = segue.destination as! GodViewController
            destination.username = self.userId
        }
    }

}

 
