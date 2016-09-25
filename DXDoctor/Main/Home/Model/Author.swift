//
//  Author.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/22.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit
import SwiftyJSON

class Author: NSObject {
    
    var avatar : String!
    var id : Int!
    var name : String!
    var remarks : String!
    var url : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        avatar = json["avatar"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        remarks = json["remarks"].stringValue
        url = json["url"].stringValue
    }
    


    
}
