//
//  ImageHaveTableViewCell.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/03.
//

import UIKit

class ImageHaveTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgHaveCollectionview: UICollectionView!
    
    var modifyMode: Bool?
    var addImg: [DiaryImgUrl]?
    var pickedImg: [UIImage]?
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 8
        // Initialization code
        imgHaveCollectionview.register(UINib(nibName: "ModifyImgBtnCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ModifyImgBtnCollectionViewCell")
        imgHaveCollectionview.dataSource = self
        imgHaveCollectionview.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ImageHaveTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + (addImg?.count ?? 0) + (pickedImg?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModifyImgBtnCollectionViewCell", for: indexPath) as? ModifyImgBtnCollectionViewCell else {return UICollectionViewCell()}
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    
}
