//
//  PhotoHaveTableViewCell.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/24.
//

import UIKit

class PhotoHaveTableViewCell: UITableViewCell {
    var delegate: AddPhotoDelegate?
    var deletePhoto: DeletePhotoDelegate?
    var photos: [UIImage]?

    @IBOutlet weak var photoCollectionview: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoCollectionview.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        photoCollectionview.register(UINib(nibName: "PhotoBtnCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoBtnCollectionViewCell")
        photoCollectionview.dataSource = self
        photoCollectionview.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
}

extension PhotoHaveTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + (photos?.count ?? 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoBtnCollectionViewCell", for: indexPath) as? PhotoBtnCollectionViewCell else {return UICollectionViewCell()}
            cell.delegate = self
            
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
            cell.deleteBtnDelegate = self
            cell.img.image = photos?[indexPath.item-1]
            cell.index = indexPath.item-1
            cell.contentView.layer.cornerRadius = 15
            cell.contentView.clipsToBounds = true
           
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90.0, height: 100.0)
    }
    
    
    
    
}



extension PhotoHaveTableViewCell: PhotoAddDelegate, DeleteBtnDelegate {
    func deleteBtn(index: Int) {
        deletePhoto?.deletePhoto(index: index)
    }
    
    func appendPhoto() {
        delegate?.addPhoto()
    }
    
    
}

protocol AddPhotoDelegate {
    func addPhoto()
}

protocol DeletePhotoDelegate {
    func deletePhoto(index: Int)
}

