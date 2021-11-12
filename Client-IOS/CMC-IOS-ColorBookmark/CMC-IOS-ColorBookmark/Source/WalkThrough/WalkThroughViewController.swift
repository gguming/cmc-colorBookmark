//
//  WalkThroughViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/10/31.
//

import UIKit

class WalkThroughViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
  
    @IBAction func startBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController")
        changeRootViewController(vc)
    }
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var walkthroughList = [UIImage(named: "walkthrough1.png"), UIImage(named: "walkthrough2.png"), UIImage(named: "walkthrough3.png"), UIImage(named: "walkthrough4.png")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.dataSource = self
        collectionview.delegate = self
        startBtn.backgroundColor = UIColor.mainPink
        startBtn.isHidden = true
        pageControl.numberOfPages = walkthroughList.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .mainPink
        collectionview.isPagingEnabled = true
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

extension WalkThroughViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        if pageControl.currentPage == 3 {
            startBtn.isHidden = false
        } else {
            startBtn.isHidden = true
        }
    }
}



class WalkthroughCell: UICollectionViewCell{
    
    @IBOutlet weak var walkthroughImg: UIImageView!
    
}
