//
//  BookmarkTableViewCell.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/19.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var firstItem: UIImageView!
    @IBOutlet weak var secondItem: UIImageView!
    @IBOutlet weak var thirdItem: UIImageView!
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var contentCollectionview: UICollectionView!
    
    var contents: [String]?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentCollectionview.dataSource = self
        contentCollectionview.delegate = self
        contentCollectionview.register(UINib(nibName: "BookMarkContentsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookMarkContentsCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    func setupLayout() {
        
    }
    
}

extension BookmarkTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookMarkContentsCollectionViewCell", for: indexPath) as? BookMarkContentsCollectionViewCell else {return UICollectionViewCell()}
    
        cell.contentImg.image = UIImage(named: "\(contents?[indexPath.item] ?? "").png")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = contentCollectionview.bounds.height
        let width = height
        return CGSize(width: width, height: height)
    }
    
    
}
