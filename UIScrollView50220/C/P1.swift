//
//  P1.swift
//  UIScrollView50220
//
//  Created by leslie on 5/3/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class P1: UIViewController {
    
    let images = ["spot1", "spot2", "spot3", "home1", "home2", "home3", "home4", "air1"]
    var imageView: UIImageView!
    var page: Int = 0
    var scrollWidth: CGFloat!
    var scrollHeight: CGFloat!

    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var pageCounter: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageCounter.numberOfPages = images.count
        pageCounter.pageIndicatorTintColor = .orange
        pageCounter.currentPageIndicatorTintColor = .white
        
        mainScroll.delegate = self
        mainScroll.isPagingEnabled = true
        
        view.setNeedsLayout()
        view.layoutIfNeeded()

        let width = mainScroll.frame.size.width
        let height = mainScroll.frame.size.height
        detectOrientation(withWidth: width, height: height)

        organizeContentView()
    }
    
    //detecting scrollWidth and scrollHeight
    func detectOrientation(withWidth width: CGFloat, height: CGFloat) {
        switch UIDevice.current.orientation {
        case .portrait:
            self.scrollWidth = width
            self.scrollHeight = height
        case .portraitUpsideDown:
            self.scrollWidth = width
            self.scrollHeight = height
        case .landscapeLeft:
            self.scrollWidth = width
            self.scrollHeight = height
        case .landscapeRight:
            self.scrollWidth = width
            self.scrollHeight = height
        default:
            self.scrollWidth = width
            self.scrollHeight = height
        }
    }

    //reversing scrollWidth and scrollHeight
    func reverseOrientation(withWidth width: CGFloat, height: CGFloat) {
        switch UIDevice.current.orientation {
        case .portrait:
            self.scrollWidth = height
            self.scrollHeight = width
        case .portraitUpsideDown:
            self.scrollWidth = height
            self.scrollHeight = width
        case .landscapeLeft:
            self.scrollWidth = height
            self.scrollHeight = width
        case .landscapeRight:
            self.scrollWidth = height
            self.scrollHeight = width
        default:
            self.scrollWidth = height
            self.scrollHeight = width
        }
    }

    //Removeing subviews from scroll view
    func removeSubViews() {
        let subViews = mainScroll.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
    }
    
    //Organizing the content area in pages
    func organizeContentView() {
        var posX: CGFloat = 0
        
        for img in images {
            imageView = UIImageView(frame: CGRect(x: posX, y: 0, width: scrollWidth, height: scrollHeight))
            imageView.image = UIImage(named: img)
            imageView.contentMode = .scaleAspectFit
//            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            mainScroll.addSubview(imageView)
            mainScroll.contentSize = CGSize(width: scrollWidth*CGFloat(images.count), height: scrollHeight)
            posX = posX + scrollWidth
        }
    }
    
    //Scroll to page
    func scrollToPage(_ page: Int) {
        let x = scrollWidth*CGFloat(page)
        let offset = CGPoint(x: x, y: 0)
        mainScroll.setContentOffset(offset, animated: true)
    }
    
    //Calculating the page
    func calculatePage() {
        let pageWidth = mainScroll.frame.size.width
        let getPage = round(mainScroll.contentOffset.x/pageWidth)
        let currentPage = Int(getPage)
        page = currentPage
        pageCounter.currentPage = page
    }
}

//MARK: - Calculating the page
extension P1: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        calculatePage()
    }
}

//MARK: - reset the scroll view page size after rotating the screen
extension P1 {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//Catch page value before calling UIScrollViewDelegate.scrollViewDidScroll() method
//Because, rotating the screen led to change to size of scroll view.
//Mean while automatically to trigger the scrollViewDidScroll() method to distract the value of page property
        let page = self.page
        pageCounter.currentPage = page  //Reset page counter to current page
        
        let top = view.safeAreaInsets.top
        let bottom = view.safeAreaInsets.bottom
        let left = view.safeAreaInsets.left
        let right = view.safeAreaInsets.right
        print("top: \(top)")
        print("bottom: \(bottom)")
        print("left: \(left)")
        print("right: \(right)")

        let width = view.frame.size.width - (top + bottom)
        let height = view.frame.size.height
        reverseOrientation(withWidth: width, height: height)
        
        removeSubViews()
        
        organizeContentView()
        
        scrollToPage(page)
    }
}
