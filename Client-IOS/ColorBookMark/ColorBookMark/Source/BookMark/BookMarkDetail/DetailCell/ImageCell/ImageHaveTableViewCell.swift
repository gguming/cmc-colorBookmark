//
//  ImageHaveTableViewCell.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/03.
//

import UIKit
import Kingfisher
import SwiftUI

class ImageHaveTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgHaveCollectionview: UICollectionView!
    
    var modifyMode: Bool?
    var addImg: [DiaryImgUrl]?
    var pickedImg: [UIImage]?
    var delegateForDelete: DeleteModifyImg?
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 8
        // Initialization code
        imgHaveCollectionview.register(UINib(nibName: "ModifyImgBtnCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ModifyImgBtnCollectionViewCell")
        
        imgHaveCollectionview.register(UINib(nibName: "ModifyImgCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ModifyImgCollectionViewCell")
        imgHaveCollectionview.register(UINib(nibName: "ModifyAddedImgCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ModifyAddedImgCollectionViewCell")
        imgHaveCollectionview.dataSource = self
        imgHaveCollectionview.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ImageHaveTableViewCell: DeleteModifyImg{
    func deleteModifyImg(index: Int) {
        delegateForDelete?.deleteModifyImg(index: index)
    }
    
    
}

extension ImageHaveTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + (addImg?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if modifyMode == true {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModifyAddedImgCollectionViewCell", for: indexPath) as? ModifyAddedImgCollectionViewCell else {return UICollectionViewCell()}
           //
            cell.deleteBtn.isHidden = false
            let url = URL(string: addImg?[indexPath.item].diaryImgUrl ?? "")
            cell.imgView.kf.indicatorType = .activity
            cell.imgView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
            cell.index = indexPath.item
            cell.delegate = self
            


            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModifyAddedImgCollectionViewCell", for: indexPath) as? ModifyAddedImgCollectionViewCell else {return UICollectionViewCell()}
           //
            cell.deleteBtn.isHidden = true
            let url = URL(string: addImg?[indexPath.item].diaryImgUrl ?? "")
            cell.imgView.kf.indicatorType = .activity
            cell.imgView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
            cell.index = indexPath.item
            cell.delegate = self
            return cell
        }
    }
}
