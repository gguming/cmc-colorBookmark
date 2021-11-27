//
//  EditColorPanelLayout.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/23.
//

import FloatingPanel

class EditColorPanelLayout: FloatingPanelLayout{
    var position: FloatingPanelPosition {
        return .bottom
    }
    
    var initialState: FloatingPanelState{
        return .tip
    }
    
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [.tip: FloatingPanelLayoutAnchor(absoluteInset: 280, edge: .bottom, referenceGuide: .safeArea)]
    
    
}
