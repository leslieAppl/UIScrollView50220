//
//  P2.swift
//  UIScrollView50220
//
//  Created by leslie on 5/3/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class P2: UIViewController {

    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var pageCounter: UIPageControl!
    
    var imageViews: [UIImageView] = []
    var page: Int = 0
    let images = ["spot1", "spot2", "spot3", "home1", "home2", "home3", "home4", "air1"]
    
    var scrollWidth: CGFloat!
    var scrollHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageCounter.numberOfPages = images.count
        pageCounter.pageIndicatorTintColor = UIColor.black
        pageCounter.currentPageIndicatorTintColor = UIColor.white
        
        mainScroll.delegate = self
        mainScroll.isPagingEnabled = true
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        let width = mainScroll.frame.size.width
        let height = mainScroll.frame.size.height
        detectOrientation(withWidth: width, height: height)

        organizeContentView()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViews[page]
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
            let childScroll = UIScrollView(frame: CGRect(x: posX, y: 0, width: scrollWidth, height: scrollHeight))
            childScroll.contentSize = CGSize(width: scrollWidth, height: scrollHeight)
            childScroll.minimumZoomScale = 1.0
            childScroll.maximumZoomScale = 4.0
            childScroll.delegate = self
            
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollWidth, height: scrollHeight))
            imgView.image = UIImage(named: img)
            //            imgView.contentMode = .scaleAspectFill
            //            imgView.clipsToBounds = true
            imgView.contentMode = .scaleAspectFit
            imageViews.append(imgView)
            
            childScroll.addSubview(imgView)
            mainScroll.addSubview(childScroll)
            mainScroll.contentSize = CGSize(width: scrollWidth*CGFloat(imageViews.count), height: scrollHeight)
            
            posX = posX + scrollWidth
        }
    }
    
    //Scroll to page
    func scrollToPage(_ page: Int) {
        let x = scrollWidth*CGFloat(page)
        let offset = CGPoint(x: x, y: 0)
        mainScroll.setContentOffset(offset, animated: true)
    }

}

extension P2: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = mainScroll.frame.size.width
        let getPage = round(mainScroll.contentOffset.x/pageWidth)
        
        let currentPage = Int(getPage)
        if currentPage != page {
            let scroll = imageViews[page].superview as! UIScrollView
            scroll.setZoomScale(1.0, animated: true)
            page = Int(currentPage)
            pageCounter.currentPage = page
        }
    }
    
}

//MARK: - reset the scroll view page size after rotating the screen
extension P2 {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//Catch page value before calling UIScrollViewDelegate.scrollViewDidScroll() method
//Because, rotating the screen led to change to size of scroll view.
//Mean while automatically to trigger the scrollViewDidScroll() method to distract the value of page property
        let page = self.page
        pageCounter.currentPage = page  //Reset page counter to current page
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        reverseOrientation(withWidth: width, height: height)
        
        removeSubViews()
        
        //re-organize contentView
        var posX: CGFloat = 0
        
        for i in 0...images.count-1 {
            let childScroll = UIScrollView(frame: CGRect(x: posX, y: 0, width: scrollWidth, height: scrollHeight))
            childScroll.contentSize = CGSize(width: scrollWidth, height: scrollHeight)
            childScroll.minimumZoomScale = 1.0
            childScroll.maximumZoomScale = 4.0
            childScroll.delegate = self
            childScroll.addSubview(imageViews[i])
            
            mainScroll.addSubview(childScroll)
            mainScroll.contentSize = CGSize(width: scrollWidth*CGFloat(imageViews.count), height: scrollHeight)
            
            posX = posX + scrollWidth
        }

        
        scrollToPage(page)
    }
}
