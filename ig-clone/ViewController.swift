//
//  ViewController.swift
//  ig-clone
//
//  Created by Chris lin on 2/4/18.
//  Copyright © 2018 Chris lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onLogin(_ sender: Any) {
    }
    
    @IBAction func toSignUpPage(_ sender: Any) {
        performSegue(withIdentifier: "signUpPageSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

