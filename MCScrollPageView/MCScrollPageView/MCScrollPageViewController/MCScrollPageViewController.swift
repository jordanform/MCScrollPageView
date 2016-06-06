//
//  MCScrollPageViewController.swift
//  MCScrollPageView
//
//  Created by Mick on 2016/6/1.
//  Copyright © 2016年 Mick Chen. All rights reserved.
//

import UIKit

/// The view controller for the about tab content
class MCScrollPageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    private var currentIndex: Int = 0
    
    // MARK: - View field
    private lazy var pageControl = UIPageControl()
    private var imgBackground = UIView()
    var contentImages = [String]()
    var lblTitle = UILabel()
    var lblMotto = UILabel()
    var lblDescription = UILabel()
    var delayTime: Double?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        createPageViewController()
        makeConstraints()
        setupPageControl()
    }
    
    /// Create UI components
    private func createUI() {
        // Set view first
        view.backgroundColor = UIColor.blackColor()
        
        // Background
        imgBackground.backgroundColor = UIColor.clearColor()
        if contentImages.count == 0 {
            contentImages = ["iPhone4",
                             "iPhone5",
                             "iPhone6",
                             "iPhone6S"]
        }
        
        // Labels
        if let titleText = lblTitle.text {
            lblTitle.text = titleText
        } else {
            lblTitle.text = "Top Title"
        }
        if let mottoText = lblMotto.text {
            lblMotto.text = mottoText
        } else {
            lblMotto.text = "Here is the Motto"
        }
        if let descriotionText = lblDescription.text {
            lblDescription.text = descriotionText
        } else {
            lblDescription.text = "Configure you description"
        }
        
        lblDescription.numberOfLines = 0
        
        lblTitle.textColor = UIColor.whiteColor()
        lblMotto.textColor = UIColor.blueColor()
        lblDescription.textColor = UIColor.whiteColor()
        
        let descriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptorNameAttribute: "Arial-BoldMT"])
        lblTitle.font = UIFont(descriptor: descriptor, size: 28)
        lblMotto.font = UIFont(descriptor: descriptor, size: 18)
        lblDescription.font = UIFont(descriptor: descriptor, size: 18)
        
        lblTitle.textAlignment = .Center
        lblMotto.textAlignment = .Center
        lblDescription.textAlignment = .Center
        
        // Add components
        view.addSubview(imgBackground)
        view.addSubview(pageControl)
        view.addSubview(lblTitle)
        view.addSubview(lblMotto)
        view.addSubview(lblDescription)
    }
    
    private func createPageViewController() {
        
        let pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        pageViewController?.delegate = self
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
        // Add timer to switch page
        if let delayTimer = delayTime {
            NSTimer.scheduledTimerWithTimeInterval(delayTimer, target: self, selector: #selector(switchPage), userInfo: nil, repeats: true)
        } else {
            NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(switchPage), userInfo: nil, repeats: true)
        }
    }
    
    /// Make UI constraints
    private func makeConstraints() {
        imgBackground.snp_makeConstraints{ [unowned self] make in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            //            make.top.equalTo(self.view)
            make.top.equalTo(self.view.frame.height / 4)
            make.height.equalTo(self.view.frame.height / 3)
            //            make.bottom.equalTo(self.view).offset(-49)
        }
        pageControl.snp_makeConstraints{ [unowned self] make in
            make.centerX.equalTo(self.view)
            make.height.equalTo(20)
            make.top.equalTo(self.imgBackground.snp_bottom).offset(-20)
        }
        lblTitle.snp_makeConstraints{ [unowned self] make in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.lblMotto.snp_top).offset(-10)
        }
        lblMotto.snp_makeConstraints{ [unowned self] make in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.imgBackground.snp_top).offset(-10)
        }
        lblDescription.snp_makeConstraints{ [unowned self] make in
            make.left.equalTo(self.view.snp_left).offset(30)
            make.right.equalTo(self.view.snp_right).offset(-30)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.imgBackground.snp_bottom).offset(10)
        }
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = contentImages.count
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
    }
    
    // MARK: - Auto switch page
    
    func switchPage() {                
        if currentIndex+1 < contentImages.count {
            currentIndex += 1
        }
        else {
            currentIndex = 0
        }
        
        let firstController = getItemController(currentIndex)!
        let startingViewControllers: NSArray = [firstController]
        pageViewController!.setViewControllers(startingViewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: { (Bool) in
            self.pageControl.currentPage = self.currentIndex
        })
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! MCScrollPageItemViewController
        
        if itemController.itemIndex > 0 {
            currentIndex = itemController.itemIndex - 1
            pageControl.currentPage = currentIndex
            return getItemController(itemController.itemIndex - 1)
        }
        else if itemController.itemIndex <= 0 {
            currentIndex = contentImages.count - 1
            pageControl.currentPage = currentIndex
            return getItemController(contentImages.count - 1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! MCScrollPageItemViewController
        
        if itemController.itemIndex+1 < contentImages.count {
            currentIndex = itemController.itemIndex + 1
            pageControl.currentPage = currentIndex
            return getItemController(itemController.itemIndex + 1)
        }
        else if itemController.itemIndex+1 >= contentImages.count {
            currentIndex = 0
            pageControl.currentPage = currentIndex
            return getItemController(0)
        }
        
        return nil
    }
    
    // MARK: - Get page content 
    
    private func getItemController(itemIndex: Int) -> MCScrollPageItemViewController? {
        
        if itemIndex < contentImages.count {
            let pageItemController = MCScrollPageItemViewController()
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        pageControl.currentPage = currentIndex
    }
}
