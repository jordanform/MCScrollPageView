//
//  MCScrollPageItemViewController.swift
//  MCScrollPageView
//
//  Created by Mick on 2016/6/1.
//  Copyright © 2016年 Mick Chen. All rights reserved.
//


import Foundation
import UIKit
import SnapKit

/// View controller for the About Tab
class MCScrollPageItemViewController: UIViewController {
    
    /// View fields
    private var imgBackground = UIImageView()
    
    // Variable for page view control
    var itemIndex: Int = 0
    var imageName: String = ""
    
    /// View loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        makeConstraints()
    }
    
    /// Create UI components
    private func createUI() {
        // View first
        view.backgroundColor = UIColor.clearColor()
        
        // Background
        let backgroundImage = UIImage(named: imageName)        
        imgBackground.image = backgroundImage
        imgBackground.contentMode = .ScaleAspectFit
        
        // Add components
        view.addSubview(imgBackground)
    }
    
    /// Make UI constraints
    private func makeConstraints() {
        imgBackground.snp_makeConstraints{ [unowned self] make in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view.frame.height / 4)
            make.height.equalTo(self.view.frame.height / 3)
        }        
    }
}
