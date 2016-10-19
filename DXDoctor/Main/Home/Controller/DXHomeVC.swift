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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.configSegment()
        
        self.configScrollview()


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
        
        let tags:[TagName] = [.feed,.special,.truth,.article,.article,.article,.article,.article,.article,.article]
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        let urls:[String] = ["http://dxy.com/app/i/feed/index/list",
                    "http://dxy.com/app/i/columns/special/list",
                    "http://dxy.com/app/i/columns/truth/article/list?",
                    "http://dxy.com/app/i/columns/article/list",
                    "http://dxy.com/app/i/columns/article/list",
                    "http://dxy.com/app/i/columns/article/list",
                    "http://dxy.com/app/i/columns/article/list",
                    "http://dxy.com/app/i/columns/article/list",
                    "http://dxy.com/app/i/columns/article/list",
                    "http://dxy.com/app/i/columns/article/list"]
        
        let parameters:[Parameters] = [Parameters(),
                          ["items_per_page":"10","page_index":"1"],
                          ["items_per_page":"10","page_index":"1","order":"publishTime"],
                          ["items_per_page":"10","page_index":"1","order":"publishTime","channel_id":"13"],
                          ["items_per_page":"10","page_index":"1","order":"publishTime","channel_id":"12"],
                          ["items_per_page":"10","page_index":"1","order":"publishTime","channel_id":"10"],
                          ["items_per_page":"10","page_index":"1","order":"publishTime","channel_id":"8"],
                          ["items_per_page":"10","page_index":"1","order":"publishTime","channel_id":"7"],
                          ["items_per_page":"10","page_index":"1","order":"publishTime","channel_id":"6"],
                          ["items_per_page":"10","page_index":"1","order":"publishTime","channel_id":"5"],
                          ]
        
        
        let basePara: Parameters = ["appuid":"1473731789496977265",
                                      "vc":"5.3.4",
                                      "noncestr":"62A2B56043704D259FE36BE91EC783C6",
                                      "mc":"21fd21fb81cb94dad73c55cf0d0e37ddd2e0bc39",
                                      "hardName":"iPhone",
                                      "vs":"10.0",
                                      "timestamp":"1473950071",
                                      "appsign":"162888ae95c583af44edf78707c558bd",
                                      "deviceName":"%E5%BE%90%E4%BD%B3%E6%96%8C%E7%9A%84%20iPhone",
                                      "ac":"1d6c96d5-9a53-4fe1-9537-85a33de916f1"]
        
        for index in 0...9 {
            
            let vc = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "DXHomeCollectionVc") as! DXHomeCollectionVc
            let url = urls[index]
            let tag = tags[index]
            var params:Parameters = parameters[index]
            params += basePara
            vc.requestPara = RequestPara(url:url,parameters:params,tag:tag);
            
//            vc.view.backgroundColor = UIColor.red
//            vc.view?.frame = CGRect(x:CGFloat(index)*screenWidth,y:0,width:scrollContainer.width,height:scrollContainer.height)
//            scrollContainer.addSubview(vc.view!)
            self.addChildViewController(vc)
            
        }
        
        let vcOne = self.childViewControllers.first
        vcOne?.view.frame = scrollContainer.bounds
        scrollContainer.addSubview((vcOne?.view)!)
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
        
        let index = Int(point.x/scrollView.width)
        
        let vc = self.childViewControllers[index]
        
        
        if (vc.view.superview) == nil {
            vc.view.frame = scrollView.bounds
            scrollView.addSubview(vc.view)
        }
        
        
    }
}



func += <KeyType, ValueType> ( left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

