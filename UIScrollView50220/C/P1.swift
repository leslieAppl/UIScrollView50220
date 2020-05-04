//
//  P1.swift
//  UIScrollView50220
//
//  Created by leslie on 5/3/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class P1: UIViewController {
    
    let images = ["spot1", "spot2", "spot3", "home1", "home2", "home3", "home4", "home5"]
    var imageView: UIImageView!
    var page: Int = 0
    var scrollWidth: CGFloat!
    var scrollHeight: CGFloat!

    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var pageCounter: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageCounter.numberOfPages = images.count
        pageCounter.pageIndicatorTintColor = .black
        pageCounter.currentPageIndicatorTintColor = .white
        
        mainScroll.delegate = self
        mainScroll.isPagingEnabled = true
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
//detecting scrollWidth and scrollHeight
        switch UIDevice.current.orientation {
        case .portrait:
            self.scrollWidth = mainScroll.frame.size.width
            self.scrollHeight = mainScroll.frame.size.height
        case .portraitUpsideDown:
            self.scrollWidth = mainScroll.frame.size.width
            self.scrollHeight = mainScroll.frame.size.height
        case .landscapeLeft:
            self.scrollWidth = mainScroll.frame.size.width
            self.scrollHeight = mainScroll.frame.size.height
        case .landscapeRight:
            self.scrollWidth = mainScroll.frame.size.width
            self.scrollHeight = mainScroll.frame.size.height
        default:
            self.scrollWidth = mainScroll.frame.size.width
            self.scrollHeight = mainScroll.frame.size.height
        }
        
//Organizing the content area in pages
        var posX: CGFloat = 0
        
        for img in images {
            imageView = UIImageView(frame: CGRect(x: posX, y: 0, width: scrollWidth, height: scrollHeight))
            imageView.image = UIImage(named: img)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            mainScroll.addSubview(imageView)
            mainScroll.contentSize = CGSize(width: scrollWidth*CGFloat(images.count), height: scrollHeight)

            posX = posX + scrollWidth
        }
    }
}

//MARK: - Calculating the page
extension P1: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = mainScroll.frame.size.width
        let getPage = round(mainScroll.contentOffset.x/pageWidth)
        let currentPage = Int(getPage)
        page = currentPage
        pageCounter.currentPage = page
    }
}

//MARK: - reset the page size when rotating the screen
extension P1 {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//Catch page value before calling UIScrollViewDelegate.scrollViewDidScroll() method
//Because, rotating the screen led to change to size of scroll view.
//Mean while automatically to trigger the scrollViewDidScroll() method to distract the value of page property
        let page = self.page
        
//reversing scrollWidth and scrollHeight
        view.setNeedsLayout()
        view.layoutIfNeeded()
        switch UIDevice.current.orientation {
        case .portrait:
            print("rotated to portrait")
            self.scrollWidth = view.frame.size.height
            self.scrollHeight = view.frame.size.width
        case .portraitUpsideDown:
            print("rotated to portraitUpsideDown")
            self.scrollWidth = view.frame.size.height
            self.scrollHeight = view.frame.size.width
        case .landscapeLeft:
            print("rotated to landscapeLeft")
            self.scrollWidth = view.frame.size.height
            self.scrollHeight = view.frame.size.width
        case .landscapeRight:
            print("rotated to landscapeRight")
            self.scrollWidth = view.frame.size.height
            self.scrollHeight = view.frame.size.width
        default:
            print("rotated to other")
            self.scrollWidth = view.frame.size.height
            self.scrollHeight = view.frame.size.width
        }
        
//Removeing subviews from scroll view
        let subViews = mainScroll.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
        
//Organizing the content area in pages
        var posX: CGFloat = 0
        
        for img in images {
            
            imageView = UIImageView(frame: CGRect(x: posX, y: 0, width: scrollWidth, height: scrollHeight))
            imageView.image = UIImage(named: img)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            mainScroll.addSubview(imageView)
            mainScroll.contentSize = CGSize(width: scrollWidth*CGFloat(images.count), height: scrollHeight)
            
            posX = posX + scrollWidth
        }
        
//Scroll to page after resizing the page
        var frame = mainScroll.frame
        frame.origin.x = scrollWidth*CGFloat(page)
        mainScroll.scrollRectToVisible(frame, animated: true)
        pageCounter.currentPage = page
    }
}
