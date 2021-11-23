//
//  EditDiaryPanelLayout.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/23.
//

import FloatingPanel

class EditDiaryPanelLayout: FloatingPanelLayout{
    var position: FloatingPanelPosition{
        return .bottom
    }
    
    var initialState: FloatingPanelState{
        return .full
    }
    
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [.full: FloatingPanelLayoutAnchor(absoluteInset: 100, edge: .top, referenceGuide: .superview)]
    
    
    
}
