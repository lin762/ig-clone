//
//  HomeViewController.swift
//  ig-clone
//
//  Created by Chris lin on 2/4/18.
//  Copyright © 2018 Chris lin. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        // Do any additional setup after loading the view.
    }

    func addNavBarImage(){
        let navController = navigationController
        let image = #imageLiteral(resourceName: "logo")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = (navController?.navigationBar.frame.size.width)!/2
        let bannerHeight = navController?.navigationBar.frame.size.height
        
        let bannerX = bannerWidth/2 - image.size.width/2
        let bannerY = bannerHeight!/2 - image.size.height/2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight!)
        imageView.contentMode = .left
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
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
