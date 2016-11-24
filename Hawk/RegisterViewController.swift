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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToLogin(_ sender: Any) {
    
    
    }
    
    
    @IBAction func doRegister(_ sender: Any) {
    
    
    }
    
    //create another viewController for login
    //make the button work 
    //make the register button work (just print for now)
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
    }
    

}
