//
//  DetailViewController.swift
//  ig-clone
//
//  Created by Chris lin on 2/8/18.
//  Copyright © 2018 Chris lin. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    var post: Any = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let postReal = post as! Posts
        captionLabel.text = postReal.caption!
        let storageRef = Storage.storage().reference(forURL: postReal.photo!)
        storageRef.getData(maxSize: 1*1024*1024){(data,error) -> Void in
            let pic = UIImage(data: data!)
            self.postImageView.image = pic
        }
        timestampLabel.text = postReal.date!
        // Do any additional setup after loading the view.
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
