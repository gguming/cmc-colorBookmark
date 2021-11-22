//
//  EditColorViewController.swift
//  CMC-IOS-ColorBookmark
//
//  Created by SUN on 2021/11/17.
//

import UIKit

class EditColorViewController: UIViewController {

    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBAction func confirmBtnTapped(_ sender: Any) {
    }
    
    @IBAction func resetBtnTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.dataSource = self
        collectionview.delegate = self
        setUI()
    }
    
    private func setUI() {
        resetBtn.clipsToBounds = true
        confirmBtn.clipsToBounds = true
        resetBtn.layer.cornerRadius = 13
        confirmBtn.layer.cornerRadius = 15
    }
    

    
}

extension EditColorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell else {return UICollectionViewCell()}
        cell.setUI()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104.0, height: 148.0)
    }
    
    
}


