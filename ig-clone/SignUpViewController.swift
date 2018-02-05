//
//  SignUpViewController.swift
//  ig-clone
//
//  Created by Chris lin on 2/4/18.
//  Copyright © 2018 Chris lin. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    let emptyAlertController = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: .alert)
    let credentialAlertController = UIAlertController(title: "Error", message: "Incorrect password or e-mail", preferredStyle: .alert)
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emptyAlertController.addAction(OKAction)
        credentialAlertController.addAction(OKAction)

    }

    @IBAction func onSignUp(_ sender: Any) {
        let username = usernameField.text!
        let email = emailField.text!
        let password = passwordField.text!
        if ((emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! || (usernameField.text?.isEmpty)!){
            present(emptyAlertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        
        
        Auth.auth().createUser(withEmail: email, password: password){ user, error in
            if error == nil && user != nil {
                print("User created")
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges{ error in
                    if error == nil{
                        print("User display name changed")
                    }
                }
                self.usernameField.text = ""
                self.emailField.text = ""
                self.passwordField.text = ""
                self.dismiss(animated: true, completion: nil)
            }else{
                print("Error: \(error!.localizedDescription)")
            }
            
        }
    }
    
    @IBAction func backToSignIn(_ sender: Any) {
        //performSegue(withIdentifier: "toSignInSegue", sender: nil)
        dismiss(animated: true, completion: nil)
    }
    
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        // handle response here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
