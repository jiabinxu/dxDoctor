//
//  DXSearchListCell.swift
//  dxy
//
//  Created by wuliupai on 16/9/16.
//  Copyright © 2016年 wuliupai. All rights reserved.
//

import UIKit

class DXSearchListCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var title : String!
    var image : String!
    
    
    var titleName: String {
        get {
            return self.title
        }
        set {
            self.title = newValue
            titleLabel.text = newValue as String

        }
    }
    
    var imageName : String{
        get{
            return self.image
        }
        set{
            self.image = newValue
            iconView.image  = UIImage.init(named: newValue as String)
        }
    }
    
//    override func awakeFromNib() {
//        
//        iconView.backgroundColor = UIColor.yellow
//        
//        titleLabel.text = "周边药店"
//    }
    

    
    
}
