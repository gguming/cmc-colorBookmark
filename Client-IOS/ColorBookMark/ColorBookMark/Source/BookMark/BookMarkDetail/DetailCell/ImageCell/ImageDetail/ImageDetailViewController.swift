//
//  ImageDetailViewController.swift
//  ColorBookMark
//
//  Created by SUN on 2022/01/08.
//

import UIKit
import Kingfisher
import SnapKit

class ImageDetailViewController: UIViewController {
    
    var addImg: [DiaryImgUrl]?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ModifyAddedImgCollectionViewCell.self, forCellWithReuseIdentifier: "ModifyAddedImgCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "arrow.backward")
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismissBtn), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        // Do any additional setup after loading the view.
        
        setUI()
    }
    
    func setUI() {
        [collectionView, backButton]
            .forEach { view.addSubview($0)}
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(20)
            $0.width.equalTo(backButton.snp.height)
            
        }
        
        collectionView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(collectionView.snp.width)
        }
    }
    
    @objc func dismissBtn() {
        self.dismiss(animated: true)
    }
  

}

extension ImageDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addImg?.count ?? 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModifyAddedImgCollectionViewCell", for: indexPath) as? ModifyAddedImgCollectionViewCell else {return UICollectionViewCell()}
        let url = URL(string: addImg?[indexPath.item].diaryImgUrl ?? "")
        cell.deleteBtn.isHidden = true
        cell.imgView.kf.setImage(with:url)
        return cell
    }
    
    
    
}

extension ImageDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
