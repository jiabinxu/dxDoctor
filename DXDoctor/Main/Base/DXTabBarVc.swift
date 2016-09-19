//
//  DXTabBarVc.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/18.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit

class DXTabBarVc: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        //设置item 的文字选中和非选中颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray], for: UIControlState())
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.green], for: UIControlState.selected)
        
        //取消item 图片选中和非选中的默认渲染模式
        for item in self.tabBar.items! {
            
            item.image = item.image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            
            item.selectedImage = item.selectedImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
}
