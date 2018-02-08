//
//  HomeViewController.swift
//  ig-clone
//
//  Created by Chris lin on 2/4/18.
//  Copyright © 2018 Chris lin. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var postTableView: UITableView!
    var posts: [Posts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.delegate = self
        postTableView.dataSource = self
        addNavBarImage()
        loadPost()
        postTableView.rowHeight = 400
        // Do any additional setup after loading the view.
        
    }
    
    func loadPost(){
        Database.database().reference().child("posts").observe(.childAdded){(snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any]{
                let captionText = dict["caption"] as! String
                let photoUrlString = dict["photoUrl"] as! String
                let post = Posts(captionText: captionText, photoUrl: photoUrlString)
                self.posts.append(post)
                print(self.posts[0].caption!)
                self.postTableView.reloadData()
            }
        }
        
    }

    func addNavBarImage(){
        let navController = navigationController
        let image = #imageLiteral(resourceName: "logo")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController?.navigationBar.frame.size.width
        let bannerHeight = navController?.navigationBar.frame.size.height
        
        let bannerX = bannerWidth!/2 - image.size.width/2
        let bannerY = bannerHeight!/2 - image.size.height/2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth!, height: bannerHeight!)
        imageView.contentMode = .left
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let p = posts[indexPath.row]
        cell.captionLabel.text = p.caption!
        return cell
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
