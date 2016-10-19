//
//  DXHomeCollectionVc.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/23.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public enum TagName:String {
    case feed = "feed"
    case special = "special"
    case truth = "truth"
    case article = "article"
}


struct RequestPara {
    
    let url:String!
    let parameters:Parameters
    let tag:TagName?
    
}

class DXHomeCollectionVc: UICollectionViewController {
    
    var dataArray:[ListItem] = []
    
    var requestPara :RequestPara?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        self.configData()
        
        self.collectionView?.backgroundColor = UIColor.white

        self.automaticallyAdjustsScrollViewInsets = false
        
    }


    func configData() {

        
        Alamofire.request((requestPara?.url)!, method: HTTPMethod.get, parameters: requestPara?.parameters).responseJSON { response in
            
            switch response.result{
                
            case .success(let value):
                let json = JSON(value)
                let items = json["data"]["items"]
                
                let row = self.requestPara?.tag
                
                switch row!{
                    
                case .feed :
                    
                    for (_,item):(String, JSON) in items {
                        let model = FeedItem.init(fromJson: item)
                        self.dataArray .append(model)
                    }
                   
                    
                case .special :
                    
                    for (_,item):(String, JSON) in items {
                        let model = SpecialItem.init(fromJson: item)
                        self.dataArray .append(model)
                    }
                
                case .truth :
                    
                    for (_,item):(String, JSON) in items {
                        let model = TruthItem.init(fromJson: item)
                        self.dataArray .append(model)
                    }
                    
                case .article:
                    
                    for (_,item):(String, JSON) in items {
                        let model = ArticleItem.init(fromJson: item)
                        self.dataArray .append(model)
                    }
                 
                }
              
                print("请求成功")
                
                self.collectionView?.reloadData()
                
            case .failure(let error):
                print(error)
            }
            
        }
    }

    //MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return dataArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let reuseIdentifier:String
        
        let item  = dataArray[indexPath.row]
        
        if let model = item as? FeedItem {
            switch model.showType {
            case 1:
                reuseIdentifier = "cell1"
            case 2:
                reuseIdentifier = "cell2"
            case 8:
                reuseIdentifier = "cell8"
            default:
                reuseIdentifier = "cell1"
            }
            
        }else if item is SpecialItem{
            reuseIdentifier = "cell3"
            
        }else{
            reuseIdentifier = "cell10"
        }
        
        print(reuseIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DXHomeListCell
        
        
        cell.model = item
        cell.backgroundColor = UIColor.white
        
        return cell

    }

}

extension DXHomeCollectionVc :UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item  = dataArray[indexPath.row]
        
        if let model = item as? FeedItem {
            if model.showType == 8{
                return CGSize(width:screenWidth/2,height:screenWidth*9/16)
            }else{
                return CGSize(width:screenWidth,height:screenWidth*9/16)
            }
        }else if item is SpecialItem {
            
            return CGSize(width:screenWidth,height:screenWidth*9/16)
        }else{
            return CGSize(width:screenWidth,height:88)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        let row = self.requestPara?.tag
        if row == .special {
            return 5
        }else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
}


