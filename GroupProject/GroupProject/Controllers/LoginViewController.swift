//
//  LoginViewController.swift
//  GroupProject
//
//  Created by Joseph Wong on 6/24/19.
//  Copyright © 2019 Kinaar Desai. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        if (PFUser.current() != nil) {
            self.performSegue(withIdentifier: "loginToWatch", sender: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginToWatch", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
                self.errorLabel.text = error?.localizedDescription
                
            }
        }
        
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginToWatch", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
                self.errorLabel.text = error?.localizedDescription
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

}
