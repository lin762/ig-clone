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
    
    let emptyAlertController = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: .alert)
    let credentialAlertController = UIAlertController(title: "Error", message: "Incorrect e-mail or password", preferredStyle: .alert)
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emptyAlertController.addAction(OKAction)
        credentialAlertController.addAction(OKAction)
        if Auth.auth().currentUser != nil{
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {(timer) in
                self.performSegue(withIdentifier: "onSignInSegue", sender: nil)
            })
        }
    }

    @IBAction func onLogin(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        if ((emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)!){
            present(emptyAlertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        
        Auth.auth().signIn(withEmail: email, password: password){ (user,error) in
            if user != nil{
                print("successfully signed in")
                self.emailField.text = ""
                self.passwordField.text = ""
                self.performSegue(withIdentifier: "onSignInSegue", sender: nil)
            }else{
                print("Error: \(error!.localizedDescription)")
                self.present(self.credentialAlertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
        }
    }
    
    @IBAction func toSignUpPage(_ sender: Any) {
        performSegue(withIdentifier: "signUpPageSegue", sender: nil)
    }
    
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        // handle response here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

