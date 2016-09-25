//
//  DXHomeVC.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/19.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON


class DXHomeVC: UIViewController{
   
    @IBOutlet weak var segmentView: TransitionSegmentView!
    @IBOutlet weak var scrollContainer: UIScrollView!
    
//    var segmentView:TransitionSegmentView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.configSegment()
        
        self.configScrollview()

//        self.automaticallyAdjustsScrollViewInsets = false
        

    }


    
    func configSegment()  {
        
        let titles:[String] = ["推荐","专题","真相","两性","不孕不育","一图读懂","肿瘤","慢病","营养","母婴"]
        

        let configure = SegmentConfigure(textSelColor:UIColor.white, highlightColor:UIColor.green,titles:titles)
        
        segmentView.configure = configure
        
        segmentView?.setScrollClosure(tempClosure: { (index) in
            
            let point = CGPoint(x:CGFloat(index)*screenWidth,y:0)
            self.scrollContainer.setContentOffset(point, animated: true)
            
        })
        
    }


    func configScrollview()  {
        
        for index in 0...9 {
            
            let vc = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "DXHomeCollectionVc") as! DXHomeCollectionVc

            vc.view.backgroundColor = UIColor.red
            vc.view?.frame = CGRect(x:CGFloat(index)*screenWidth,y:0,width:scrollContainer.width,height:scrollContainer.height)

            scrollContainer.addSubview(vc.view!)
            self.addChildViewController(vc)
            
        }
        scrollContainer.contentSize = CGSize(width:10*screenWidth,height:0)
        scrollContainer.showsHorizontalScrollIndicator = true
        scrollContainer.delegate = self
        scrollContainer.isPagingEnabled = true
        scrollContainer.backgroundColor = UIColor.black
        self.automaticallyAdjustsScrollViewInsets = true
     
    }
    

}


extension DXHomeVC:UIScrollViewDelegate{
    
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

