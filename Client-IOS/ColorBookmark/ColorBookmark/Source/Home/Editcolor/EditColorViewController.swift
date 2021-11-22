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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetBtnTapped(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.register(UINib(nibName: "ColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCollectionViewCell")
        collectionview.register(UINib(nibName: "EditColorBtnCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EditColorBtnCollectionViewCell")

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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditColorBtnCollectionViewCell", for: indexPath) as? EditColorBtnCollectionViewCell else {return UICollectionViewCell()}
            cell.delegate = self
            return cell
        case 1...5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell else {return UICollectionViewCell()}
            cell.setUI()
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104.0, height: 148.0)
    }
    
    
}

extension EditColorViewController: ClickEditBtn {
    func presentColorPicker() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ColorPickerMainViewController") as? ColorPickerMainViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    
}


