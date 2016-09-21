//
//  DXSegmentView.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/19.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit

let widthAddition:CGFloat = 20.0
let heightAddtion:CGFloat = 16.0
let cornerRadius:CGFloat = 6.0

let tagAddition = 100


struct DXSegmentConfigure {
    
    var textSelColor:UIColor
    
    var highlightColor:UIColor
    
    var titleArray:[String]?
}


class DXSegmentView: UIView,UIScrollViewDelegate{
    
    
    typealias SegmentClosureType = (Int)->Void
    //
    public var scrollClosure:SegmentClosureType?
    
    //字体非选中状态颜色
    public var textNorColor:UIColor = UIColor.black
    
    //字体选中状态颜色
    public var textSelColor:UIColor = UIColor.white
    
    //高亮区域颜色
    public var highlightColor:UIColor = UIColor.green
    
    //标题数组
    public var titleArray:[String]?
    
    //字体大小
    public var textFont:CGFloat = 14.0 {
        willSet{
            
            self.textFont = newValue
        }
        didSet{
            
            self.configUI()
        }
        
    }
    
 
    //底部scrollview容器
    private var bottomContainer:UIScrollView?
    
    //高亮区域
    private var highlightView:UIView?
    
    //顶部scrollView容器
    private var topContainer:UIScrollView?
    
    
    
    
    init(frame:CGRect, titles:[String]) {
        
        super.init(frame:frame)
        
        titleArray = titles
        
        self.configUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //初始化UI
    func configUI() {
        
        let rect = CGRect(x:0,y:0,width:frame.width,height:frame.height)
        
        bottomContainer = UIScrollView.init(frame:rect)
        topContainer = UIScrollView.init(frame: rect)
        highlightView = UIView.init()
        highlightView?.layer.masksToBounds = true
        
        self.configScrollView()
        
        self.addSubview(bottomContainer!)
        bottomContainer?.addSubview(highlightView!)
        highlightView?.addSubview(topContainer!)
        
    }
    
    //初始化scrollview容器
    func configScrollView()  {
        

        for view in (bottomContainer?.subviews)! {
            
            if view .isEqual(highlightView) {
                return
            }else{
                view .removeFromSuperview()
            }
        }
        
        for view in (topContainer?.subviews)! {
            view .removeFromSuperview()
        }
        
        highlightView?.backgroundColor = highlightColor
        self.createBottomLabels(scrollView: bottomContainer!, titleArray: titleArray!,isHighlight:false)
        self.createBottomLabels(scrollView: topContainer!, titleArray: titleArray!,isHighlight:true)
        
        
        
    }
    
    //对scrollview容器进行设置
    func createBottomLabels(scrollView:UIScrollView,titleArray:[String],isHighlight:Bool) {
        
        var firstX:CGFloat = 0
        scrollView.showsHorizontalScrollIndicator = false
        
        for index in 0..<titleArray.count{
            
            let title:NSString = titleArray[index] as NSString
        
            let dict = [NSFontAttributeName:UIFont.systemFont(ofSize: textFont)]
            //富文本自己算label宽度和高度
            let itemWidth = title.size(attributes: dict).width + widthAddition

            let label = UILabel.init()
            label.frame = CGRect(x:firstX,y:0,width:itemWidth,height:self.frame.height)
            label.text = title as String
            label.textAlignment = NSTextAlignment.center
            
            if isHighlight {

                label.font = UIFont.systemFont(ofSize:textFont+1)
                label.textColor = UIColor.white
                
            }else{
                
                label.font = UIFont.systemFont(ofSize:textFont)
                label.textColor = UIColor.black
                label.isUserInteractionEnabled = true
                label.tag = index + tagAddition;
                
                let gesture = UITapGestureRecognizer.init(target: self, action: #selector(tap))
                label.addGestureRecognizer(gesture)
                
                
            }
            
            firstX += itemWidth
            scrollView.contentSize = CGSize(width:firstX,height:0)
            scrollView.addSubview(label)
            
        }
    }
    
    //设置闭包
    func setScrollClosure(tempClosure:@escaping SegmentClosureType) {
        
        self.scrollClosure = tempClosure
        
    }
    
    //点击手势方法
    func tap(sender:UITapGestureRecognizer) {
        
        let item:UILabel = sender.view as! UILabel
        let index = item.tag
        
        self.scrollClosure!(Int(index-100))
        
    }
    
    //scrollViewDidScroll调用
    func segmentWillMove(point:CGPoint) {
        
        let index = Int(point.x/screenWidth)
        let remind = point.x/screenWidth - CGFloat(index)
        
        for view in (bottomContainer?.subviews)! {
            
            if index == (view.tag - tagAddition) {
                
                
                // 判断bottomContainer 是否需要移动
                var offsetx = view.center.x - screenWidth/2
                
                let offsetMax = (bottomContainer?.contentSize.width)! - screenWidth
                
                if offsetx < 0 {
                    offsetx = 0
                }else if offsetx > offsetMax{
                    
                    offsetx = offsetMax
                }
                let bottomPoint = CGPoint(x:offsetx,y:0)

                bottomContainer?.setContentOffset(bottomPoint, animated: false)
                
                
                //调整高亮区域的frame
                highlightView?.frame = view.frame
                highlightView?.frame.origin.x = view.frame.origin.x + view.frame.width*remind
                
                //裁剪高亮区域
                self.clipView(view: highlightView!)
                
                let topPoint = CGPoint(x:((highlightView?.frame.minX)!), y:0)
                
                //移动topContainer
                topContainer?.setContentOffset(topPoint, animated: false)
                
            }
        }
    }
    

    

    //scrollViewDidEndScrollingAnimation方法调用
    func segmentDidEndMove(point:CGPoint)  {
        //四舍五入
        let index = lroundf(Float(point.x/screenWidth))
    
        for view in (bottomContainer?.subviews)! {
            
            if index == (view.tag - 100) {
                
                //调整高亮区域的frame
                highlightView?.frame = view.frame
                
                //移动topContainer
                topContainer?.contentOffset = CGPoint(x:((highlightView?.frame.minX)!), y:0)
            
                
                // 判断bottomContainer 是否需要移动
                var offsetx = view.center.x - screenWidth/2
                
                let offsetMax = (bottomContainer?.contentSize.width)! - screenWidth
                
                if offsetx < 0 {
                    offsetx = 0
                }else if offsetx > offsetMax{
                    
                    offsetx = offsetMax
                }
                let bottomPoint = CGPoint(x:offsetx,y:0)
                
                bottomContainer?.setContentOffset(bottomPoint, animated: true)
                
            }
        }

    }
    
    //切割高亮区域
    func clipView(view:UIView)  {
        
        let rect = CGRect(x:widthAddition/4,y:heightAddtion/4,width:view.width-widthAddition/2,height:view.height-heightAddtion/2)
        
        let bezierPath = UIBezierPath.init(roundedRect: rect, cornerRadius: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.path = bezierPath.cgPath
        view.layer.mask = maskLayer
        
        
    }

    

}
