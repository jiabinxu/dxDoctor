//
//  VC1.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/24.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit
import IBAnimatable

class VC1: UIViewController {

    @IBOutlet weak var view1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view1.backgroundColor = UIColor.red
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
