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


//private let reuseIdentifier = "cell1"

class DXHomeCollectionVc: UICollectionViewController {

    var dataArray:[ListItem] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        self.configData()
        
        self.collectionView?.backgroundColor = UIColor.yellow

        self.automaticallyAdjustsScrollViewInsets = false
        
    }

    func configData() {
        let url = "http://dxy.com/app/i/feed/index/list"
        let parameters: Parameters = ["appuid":"1473731789496977265",
                                      "vc":"5.3.4",
                                      "noncestr":"62A2B56043704D259FE36BE91EC783C6",
                                      "mc":"21fd21fb81cb94dad73c55cf0d0e37ddd2e0bc39",
                                      "hardName":"iPhone",
                                      "vs":"10.0",
                                      "timestamp":"1473950071",
                                      "appsign":"162888ae95c583af44edf78707c558bd",
                                      "deviceName":"%E5%BE%90%E4%BD%B3%E6%96%8C%E7%9A%84%20iPhone",
                                      "ac":"1d6c96d5-9a53-4fe1-9537-85a33de916f1"]
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameters).responseJSON { response in
            
            switch response.result{
                
            case .success(let value):
                let json = JSON(value)
                let items = json["data"]["items"]
                for (_,item):(String, JSON) in items {
                    let model = ListItem.init(fromJson: item)
                    self.dataArray .append(model)
                }
                print("请求成功")
                
                self.collectionView?.reloadData()
                
            case .failure(let error):
                print(error)
            }
            
            
        }
    }

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = dataArray[indexPath.row] as ListItem
        
        let reuseIdentifier:String
        
        
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DXHomeListCell

        cell.backgroundColor = UIColor.white
        
        cell.model = model
        
        return cell
    }

}

extension DXHomeCollectionVc :UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        let model = dataArray[indexPath.row] as ListItem
        if model.showType == 8 {
            return CGSize(width:screenWidth/2-0.5,height:screenWidth*9/16)
        }else{
            return CGSize(width:screenWidth,height:screenWidth*9/16)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
//        let model = dataArray[indexPath.row] as ListItem
//        if model.showType == 8 {
        return 1
    }
    
}


