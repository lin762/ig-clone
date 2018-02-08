//
//  Posts.swift
//  ig-clone
//
//  Created by Chris lin on 2/8/18.
//  Copyright © 2018 Chris lin. All rights reserved.
//

import Foundation
class Posts: NSObject{
    var photo: String?
    var caption: String?
    //var user: String?
    var date: String?
    
    init(captionText: String, photoUrl: String, dateStr: String){
        photo = photoUrl
        caption = captionText
        //user = userID
        date = dateStr
    }
}