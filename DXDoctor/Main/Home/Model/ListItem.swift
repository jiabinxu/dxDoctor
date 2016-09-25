//
//  ListItem.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/22.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListItem: NSObject {

    var author : Author!
    var content : String!
    var cover : String!
    var from : String!
    var showType : Int!
    var tagsStr : String!
    var title : String!
    var url : String!
    

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        let authorJson = json["author"]
        if authorJson != JSON.null{
            author = Author(fromJson: authorJson)
        }
        content = json["content"].stringValue
        cover = json["cover"].stringValue
        from = json["from"].stringValue
        showType = json["show_type"].intValue
        tagsStr = json["tags_str"].stringValue
        title = json["title"].stringValue
        url = json["url"].stringValue
    }

    
}
