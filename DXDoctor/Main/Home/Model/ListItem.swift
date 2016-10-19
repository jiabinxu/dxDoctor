//
//  ListItem.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/22.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit
import SwiftyJSON


protocol ListItem {
    
}

class FeedItem: ListItem {

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


class SpecialItem:ListItem{
    
    var cover : String!
    var coverSmall : String!
    var createTime : String!
    var desc : String!
    var id : Int!
    var modifyTime : String!
    var name : String!
    var type : Int!
    var typeName : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        cover = json["cover"].stringValue
        coverSmall = json["cover_small"].stringValue
        createTime = json["create_time"].stringValue
        desc = json["desc"].stringValue
        id = json["id"].intValue
        modifyTime = json["modify_time"].stringValue
        name = json["name"].stringValue
        type = json["type"].intValue
        typeName = json["type_name"].stringValue
    }
    
}


class TruthItem:ListItem{
    
    var cover : String!
    var coverSmall : String!
    var id : Int!
    var specialId : Int!
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        cover = json["cover"].stringValue
        coverSmall = json["cover_small"].stringValue
        id = json["id"].intValue
        specialId = json["special_id"].intValue
        title = json["title"].stringValue
    }
    
}

class ArticleItem: ListItem{
    
    var author : String!
    var authorAvatar : String!
    var authorId : Int!
    var authorRemarks : String!
    var authorUrl : String!
    var authorUserId : Int!
    var cover : String!
    var coverSmall : String!
    var editors : [Editor]!
    var id : Int!
    var publishTime : String!
    var specialId : Int!
    var specialName : String!
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        author = json["author"].stringValue
        authorAvatar = json["author_avatar"].stringValue
        authorId = json["author_id"].intValue
        authorRemarks = json["author_remarks"].stringValue
        authorUrl = json["author_url"].stringValue
        authorUserId = json["author_user_id"].intValue
        cover = json["cover"].stringValue
        coverSmall = json["cover_small"].stringValue
        editors = [Editor]()
        let editorsArray = json["editors"].arrayValue
        for editorsJson in editorsArray{
            let value = Editor(fromJson: editorsJson)
            editors.append(value)
        }
        id = json["id"].intValue
        publishTime = json["publish_time"].stringValue
        specialId = json["special_id"].intValue
        specialName = json["special_name"].stringValue
        title = json["title"].stringValue
    }
    
}



class Author {
    
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




class Editor{
    
    var avatar : String!
    var id : Int!
    var nickName : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        avatar = json["avatar"].stringValue
        id = json["id"].intValue
        nickName = json["nick_name"].stringValue
    }
    
}



