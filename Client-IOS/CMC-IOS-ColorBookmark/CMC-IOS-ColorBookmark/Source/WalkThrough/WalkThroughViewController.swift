//
//  WalkThroughViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/10/31.
//

import UIKit

class WalkThroughViewController: UIViewController {

    @IBOutlet weak var collectionview: UICollectionView!
    var walkthroughList = [UIImage(named: "walkthrough1.png"), UIImage(named: "walkthrough2.png"), UIImage(named: "walkthrough3.png"), UIImage(named: "walkthrough4.png")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.dataSource = self
        collectionview.delegate = self

        // Do any additional setup after loading the view.
    }

}

extension WalkThroughViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return walkthroughList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkthroughCell", for: indexPath) as? WalkthroughCell else {return UICollectionViewCell()}
        cell.walkthroughImg.image = walkthroughList[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let height = view.bounds.height
        return CGSize(width: width, height: height)
    }
    
}



class WalkthroughCell: UICollectionViewCell{
    
    @IBOutlet weak var walkthroughImg: UIImageView!
    
}
