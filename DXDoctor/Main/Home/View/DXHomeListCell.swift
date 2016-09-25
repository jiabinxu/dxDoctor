//
//  DXHomeListCell.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/22.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit

import Kingfisher

class DXHomeListCell: UICollectionViewCell {
    
    
    @IBOutlet weak var coverImageview: UIImageView?
    
    @IBOutlet weak var titleLabel: UILabel?
    
    @IBOutlet weak var detailLabel: UILabel?
    
    @IBOutlet weak var tagLabel: UILabel?
    
    @IBOutlet weak var avatarView: UIImageView?
    
    @IBOutlet weak var authorLabel: UILabel?
    
    @IBOutlet weak var authDetailLabel: UILabel?
    

    var model: ListItem? {
        
        didSet{
            
            self.refreshUI()
        }

    }
    
    func refreshUI()  {
        
        
        if coverImageview == coverImageview {
            
            let coverUrl = URL(string: (model?.cover)!)
            coverImageview?.kf.setImage(with: coverUrl)
        }

        titleLabel?.text = model?.title
        detailLabel?.text = model?.content
        tagLabel?.text = model?.tagsStr
        
        if let avatar = model?.author?.avatar {
            
            let avatarUrl = URL(string:avatar)
            avatarView?.kf.setImage(with: avatarUrl)
            
        }
        
        authorLabel?.text = model?.author.name
        authDetailLabel?.text = model?.author.remarks
    }
    
    
    
}
