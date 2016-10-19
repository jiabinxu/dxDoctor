//
//  DXHomeListCell.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/22.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit


import IBAnimatable

import Kingfisher

class DXHomeListCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView?

    
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
        
        if model is FeedItem {
            refreshUI(feedModel: model as! FeedItem)
        }else if model is SpecialItem{
            refreshUI(specialModel: model as! SpecialItem)
        }else if model is TruthItem{
            refreshUI(truthModel: model as!TruthItem)
        }else{
            refreshUI(acticalModel: model as! ArticleItem)
        }
    }
    
    
    
    
    func refreshUI(feedModel model:FeedItem)  {
        
        
        if let coverImageView = coverImageView {
            
            let coverUrl = URL(string: (model.cover)!)
            coverImageView.kf.setImage(with: coverUrl)
            addGradientLayer(imageView: coverImageView)
        }
        
        titleLabel?.text = model.title
        detailLabel?.text = model.content
        tagLabel?.text = model.tagsStr
        
        if let avatar = model.author?.avatar {
            let avatarUrl = URL(string:avatar)
            avatarView?.layer.masksToBounds = true
            avatarView?.layer.cornerRadius = (avatarView?.width)!/2
            avatarView?.kf.setImage(with: avatarUrl)
        }else{
            contentView.layer.borderColor = UIColor.lightGray.cgColor
            contentView.layer.borderWidth = 0.5
        }
        
        authorLabel?.text = model.author.name
        authDetailLabel?.text = model.author.remarks
        
//        let tagStr = model.tagsStr
//        if  !(tagStr?.isEmpty)! {
//            tagLabel?.text = tagStr
//            creatTagLabel(label: &tagLabel!, color: UIColor.gray)
//        }
        
        if var tagLabel = tagLabel {
            tagLabel.text = model.tagsStr
            creatTagLabel(label: &tagLabel, color: UIColor.gray)
        }
        
    }
    
    
    func refreshUI(specialModel model:SpecialItem) {
        let coverUrl = URL(string:model.cover)
        addGradientLayer(imageView: coverImageView!)
        coverImageView?.kf.setImage(with: coverUrl)
        
        titleLabel?.text = model.name
            
    }
    
    func refreshUI(truthModel model:TruthItem)  {
        let coverUrl = URL(string:model.coverSmall)
        coverImageView?.kf.setImage(with: coverUrl)
        
        titleLabel?.text = model.title
    }
    
    func refreshUI(acticalModel model:ArticleItem)  {
        let coverUrl = URL(string:model.coverSmall)
        coverImageView?.kf.setImage(with: coverUrl)
        titleLabel?.text = model.title
    }
    
    
    func addGradientLayer(imageView:UIImageView)  {
        
        let  blackcolor = UIColor.init(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        let whitecolor = UIColor.init(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.4).cgColor
        
        let shadow = CAGradientLayer()
        shadow.frame = imageView.bounds
        
        shadow.colors = [blackcolor,whitecolor,blackcolor];
        shadow.locations = [(0.0),(0.5),(1.0)]
        
        shadow.startPoint = CGPoint(x:0,y:0)
        shadow.endPoint = CGPoint(x:0,y:1)
        imageView.layer.sublayers?.removeAll()
        imageView.layer.addSublayer(shadow)
        
    }
    
    private func creatTagLabel( label:inout UILabel, color:UIColor){
        
        let text = label.text!
        
        let dict = [NSFontAttributeName:UIFont.systemFont(ofSize: label.font.pointSize)]
        
        let size = text.size(attributes: dict)
        label.width = size.width + 150
        label.height = size.height + 100
//        label.frame = CGRect(x:label.x,y:label.y,width:size.width+50,height:size.height+10)
        label.backgroundColor = color
        label.font = UIFont.systemFont(ofSize: 12.0)
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4.0
        
        print("no1")
        
    }
    
    
    override func layoutSubviews() {
        
        if var tagLabel = tagLabel {
            
        }
        
    }
   
}
