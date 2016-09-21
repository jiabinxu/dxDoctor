//
//  DXHomeVC.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/19.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit

class DXHomeVC: UIViewController,UIScrollViewDelegate{

    
    
    @IBOutlet weak var scrollContainer: UIScrollView!
    
    var segmentView:DXSegmentView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titles:[String] = ["推荐","专题","真相","两性","不孕不育","一图读懂","肿瘤","慢病","营养","母婴"]
        
        segmentView = DXSegmentView.init(frame: CGRect(x:0,y:64,width:screenWidth,height:35), titles: titles)
        segmentView?.textFont = 10
        
        segmentView?.backgroundColor = UIColor.yellow
        
        segmentView?.setScrollClosure(tempClosure: { (index) in
            
            let point = CGPoint(x:CGFloat(index)*screenWidth,y:0)
            self.scrollContainer.setContentOffset(point, animated: true)
//            scrollContainer.setContentOffset(CGPoint(x:float(index)*screenWidth,y:0), animated: true)
        })
        

        
        self.view.addSubview(segmentView!)
        
        
        for index in 0...9 {
            
            let vc: UIViewController = UIViewController.init()
            vc.view.frame = CGRect(x:CGFloat(index)*screenWidth,y:35,width:scrollContainer.bounds.width,height:scrollContainer.bounds.height)
            
            self.addChildViewController(vc)
            
        }
        scrollContainer.contentSize = CGSize(width:10*screenWidth,height:0)
        scrollContainer.showsHorizontalScrollIndicator = true
        scrollContainer.delegate = self
        scrollContainer.isPagingEnabled = true
        
        // Do any additional setup after loading the view.
    }


    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let point = scrollView.contentOffset

        segmentView?.segmentWillMove(point: point)

        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let point = scrollView.contentOffset
        
        segmentView?.segmentDidEndMove(point: point)
    }

    

}
