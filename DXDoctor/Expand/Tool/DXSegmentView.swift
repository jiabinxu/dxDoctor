//
//  DXSegmentView.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/19.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit

class DXSegmentView: UIView,UIScrollViewDelegate{

    
    var scrollview:UIScrollView?
    
    var highlightView:UIView?
    
    var topLabelView:UIScrollView?
    
    var selectIndex:Int?
    
    var titleArray:[String]
    
    
    
     init(frame:CGRect, titleArray:[String]) {
        
        self.titleArray = titleArray
        self.scrollview = UIScrollView.init(frame: CGRect(x:0,y:0,width:frame.width,height:frame.height))
        self.scrollview?.contentSize = CGSize(width:2*frame.width, height:0)
        self.scrollview?.showsHorizontalScrollIndicator = false
        
        
        super.init(frame: frame)
        
        self.createBottomLabels(view: self.scrollview!, titleArray: titleArray,isHighlight:false)
        
        self.highlightView = UIView.init(frame: CGRect(x:0,y:0,width:100,height:self.frame.height))
        self.highlightView?.layer.masksToBounds = true
        highlightView?.backgroundColor = UIColor.green
        self.topLabelView = UIScrollView.init(frame: CGRect(x:0,y:0,width:frame.width,height:frame.height))
        self.topLabelView?.contentSize = CGSize(width:0, height:0)
        self.topLabelView?.showsHorizontalScrollIndicator = false
        
        self.createBottomLabels(view: self.topLabelView!, titleArray: titleArray,isHighlight:true)
        self.addSubview(scrollview!)
        scrollview?.addSubview(self.highlightView!)
        self.highlightView?.addSubview(self.topLabelView!)
        self.scrollview?.delegate = self
        self.topLabelView?.delegate = self
        
        self.selectIndex = 0
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func createBottomLabels(view:UIScrollView,titleArray:[String],isHighlight:Bool) {
        
        var firstX:CGFloat = 0
        
        for i in 0..<titleArray.count{
            let title:NSString? = titleArray[i] as NSString?
            let dict = [NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
            
            let itemWidth:CGFloat = (title?.size(attributes: dict).width)! + 20
            
            let rect = CGRect(x:firstX,y:0,width:itemWidth,height:self.frame.height)
            let label:UILabel = UILabel.init(frame: rect)
            label.text = titleArray[i]
            label.font = UIFont.systemFont(ofSize: 14)
            
            label.textAlignment = NSTextAlignment.center
            firstX += itemWidth
            view.addSubview(label)
            
            if isHighlight {
                label.textColor = UIColor.red
                
            }else{
                
                label.textColor = UIColor.black
                label.isUserInteractionEnabled = true
                label.tag = i+100;
                
                let gesture = UITapGestureRecognizer.init(target: self, action: #selector(tap))
                label.addGestureRecognizer(gesture)
                view.contentSize = CGSize(width:firstX,height:0)
            }
        }
    }
    
    
    func tap(sender:UITapGestureRecognizer) {
        
        
        let item:UILabel = sender.view as! UILabel
        let index = item.tag
        
        for view in (scrollview?.subviews)! {
            
            if index == view.tag {
                highlightView?.frame = item.frame
                
                topLabelView?.contentOffset = CGPoint(x:item.frame.origin.x, y:0)
            }
        }
    }
    
    func segmentWillMove(point:CGPoint) {
        
        let index = Int(point.x/screenWidth)
        let remind = point.x/screenWidth - CGFloat(index)
        

        for view in (scrollview?.subviews)! {
            
            if index == view.tag {
                highlightView?.frame = view.frame
                highlightView?.frame.origin.x = view.frame.origin.x + view.frame.width*remind
                
                topLabelView?.contentOffset = CGPoint(x:view.frame.origin.x, y:0)
            }
        }
        
    }
    

    
    

}
