//
//  OriginalColorPickerMainViewController.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/05.
//

import UIKit

class OriginalColorPickerMainViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    weak var colorCollectionviewDelegate: ColorReloadDelegate?
    lazy var editColorDataManager: PostMyColorDataManager = PostMyColorDataManager()
    lazy var colorDataManager: GetMyColorDataManager = GetMyColorDataManager()
    var currentColorId = 0
    
    @available(iOS 14.0, *)
    @IBAction func saveBtnTapped(_ sender: Any) {
        let colorInfo = ColorPickerInfo.shared.color
        print(colorInfo)
        print(currentColorId)
        let request = PostMyColorRequest(color: colorInfo!, myColorId: currentColorId)
        editColorDataManager.editMyColor(request, delegate: self)
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension OriginalColorPickerMainViewController {
    func didSuccessEditColors(_ result: PostMyColorResponse) {
        print("------>\(result)")
        presentBottomAlert(message: result.message ?? "")
        self.dismiss(animated: true, completion: nil)
        self.colorCollectionviewDelegate?.reloadColorCollectionView()
        //여기서 델리겟 패턴으로 editVC collectionview reload
    }
    
    func failedToEditColors(message: String) {
        print("------>>>>\(message)")
        presentBottomAlert(message: message)
        self.dismiss(animated: true, completion: nil)
        
    }
}
