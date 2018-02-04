//
//  ViewController.swift
//  ig-clone
//
//  Created by Chris lin on 2/4/18.
//  Copyright © 2018 Chris lin. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onLogin(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        
        Auth.auth().signIn(withEmail: email, password: password){ (user,error) in
            if user != nil{
                print("successfully signed in")
                self.performSegue(withIdentifier: "onSignInSegue", sender: nil)
            }else{
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    @IBAction func toSignUpPage(_ sender: Any) {
        performSegue(withIdentifier: "signUpPageSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

