//
//  P2.swift
//  UIScrollView50220
//
//  Created by leslie on 5/3/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

//Adapting the content area to a new orientation
class P2: UIViewController {

    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var pageCounter: UIPageControl!
    
    var imageViews: [UIImageView] = []
    var page: Int = 0
    var rotating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = ["spot1", "spot2", "spot3", "home1", "home2", "home3", "home4", "air1"]
        pageCounter.numberOfPages = images.count
        pageCounter.pageIndicatorTintColor = UIColor.black
        pageCounter.currentPageIndicatorTintColor = UIColor.white
        
        mainScroll.delegate = self
        mainScroll.isPagingEnabled = true
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        for img in images {
            let childScroll = UIScrollView(frame: CGRect.zero)
            childScroll.minimumZoomScale = 1.0
            childScroll.maximumZoomScale = 4.0
            childScroll.delegate = self
            
            let imgView = UIImageView(frame: CGRect.zero)
            imgView.image = UIImage(named: img)
            imgView.contentMode = .scaleAspectFit
            imgView.clipsToBounds = true
            imageViews.append(imgView)
            
            childScroll.addSubview(imgView)
            mainScroll.addSubview(childScroll)
        }
        
        updateSize()
        
    }
    
    func updateSize() {
        let scrollWidth = mainScroll.frame.size.width
        let scrollHeight = mainScroll.frame.size.height
        
        var posX: CGFloat = 0
        for imgView in imageViews {
            let scroll = imgView.superview as! UIScrollView
            scroll.frame = CGRect(x: posX, y: 0, width: scrollWidth, height: scrollHeight)
            scroll.contentSize = CGSize(width: scrollWidth, height: scrollHeight)
            imgView.frame = CGRect(x: 0, y: 0, width: scrollWidth, height: scrollHeight)
            
            posX = posX + scrollWidth
        }
        
        mainScroll.contentSize = CGSize(width: scrollWidth*CGFloat(imageViews.count), height: scrollHeight)
        
        let scrollView = imageViews[page].superview as! UIScrollView
        mainScroll.scrollRectToVisible(scrollView.frame, animated: true)
    }
    
    

}

extension P2: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !rotating {
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
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViews[page]
    }
}

extension P2 {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        rotating = true
        coordinator.animate(alongsideTransition: nil) { (context) in
            let scroll = self.imageViews[self.page].superview as! UIScrollView
            scroll.setZoomScale(1.0, animated: true)
            
            self.updateSize()
            self.rotating = false
        }
    }
}
