//
//  DXSearchListVc.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/18.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"
private let reuseHeader = "headCell"

class DXSearchListVc: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    var titleArray:[String] = ["查疾病","查药品","查文章","找药店","查疫苗","就医推荐","常见病症"]
    var imageArray:[String] = ["search_illness","search_drugs","search_article","search_pharmacy","search_disease","search_hospital","search_hospital",]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.alwaysBounceVertical = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DXSearchListCell
        
        cell.titleName = self.titleArray[indexPath.row] as String
        cell.imageName = self.imageArray[indexPath.row] as String
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let header = collectionView .dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeader, for: indexPath) as! DXCollectionHeader
        
        
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:screenWidth, height:screenWidth*9/16)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width:0, height:0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = screenHeight - screenWidth*9/16 - 49 - 64 - 20
        return CGSize(width: screenWidth/3 , height: height/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

}
