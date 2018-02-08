//
//  addPhotoViewController.swift
//  ig-clone
//
//  Created by Chris lin on 2/7/18.
//  Copyright © 2018 Chris lin. All rights reserved.
//

import UIKit
import Firebase

class addPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let emptyAlertController = UIAlertController(title: "Error", message: "Please select a photo", preferredStyle: .alert)

    @IBOutlet weak var uploadPhotoView: UIImageView!
    @IBOutlet weak var captionView: UITextField!
    @IBOutlet weak var add1Label: UILabel!
    @IBOutlet weak var add2Label: UILabel!
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addPhotoViewController.handleUploadPhoto))
        uploadPhotoView.clipsToBounds = true;
        uploadPhotoView.addGestureRecognizer(tapGesture)
        uploadPhotoView.isUserInteractionEnabled = true
        emptyAlertController.addAction(OKAction)
        captionView.textAlignment = .left
        captionView.contentVerticalAlignment = .top

        // Do any additional setup after loading the view.
    }
    
    
    @objc func handleUploadPhoto(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController,animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let infoPhoto = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            uploadPhotoView.image = infoPhoto
            selectedImage = infoPhoto
            add1Label.isHidden = true;
            add2Label.isHidden = true;

        }
    }
    
    @IBAction func onSubmitPost(_ sender: Any) {
        if uploadPhotoView.image == nil{
            present(emptyAlertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        if let postImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(postImg, 0.5){
            let photoIdString = NSUUID().uuidString.lowercased()
            let storageRef = Storage.storage().reference(forURL: "gs://ig-clone-55cad.appspot.com/").child("posts").child(photoIdString)
            storageRef.putData(imageData, metadata: nil, completion: {(metadata,error) in
                if error != nil{
                    return
                }
                let photoUrl = metadata?.downloadURL()?.absoluteString
                self.sendDataToDatabase(photoUrl: photoUrl!)
            })
        }
    }
    
    func sendDataToDatabase(photoUrl: String){
        let ref = Database.database().reference()
        let postRef = ref.child("posts")
        let newPostId = postRef.childByAutoId().key
        let newPostReference = postRef.child(newPostId)
        newPostReference.setValue(["photoUrl": photoUrl, "caption": captionView.text!], withCompletionBlock: {
            (error, ref) in
            if error != nil{
                //add alert
                return
            }
            self.captionView.text = ""
            self.uploadPhotoView.image = nil
            self.add1Label.isHidden = false;
            self.add2Label.isHidden = false;
            self.tabBarController?.selectedIndex = 0

            
        })
        
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
