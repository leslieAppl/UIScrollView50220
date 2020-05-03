//
//  P1.swift
//  UIScrollView50220
//
//  Created by leslie on 5/3/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class P1: UIViewController {

    var imageView: UIImageView!
    var page: Int = 0
    
    let images = ["spot1", "spot2", "spot3", "home1", "home2", "home3", "home4", "home5"]
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
        scrollWidth = mainScroll.frame.size.width
        scrollHeight = mainScroll.frame.size.height
        
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
        
        if UIDevice.current.orientation.isLandscape {
//Removeing subviews from scroll view
            let subViews = mainScroll.subviews
            for subView in subViews {
                subView.removeFromSuperview()
            }
            
//Switching width and height after rotating to landscape mode
            let scrollWidth: CGFloat = self.scrollHeight
            let scrollHeight: CGFloat = self.scrollWidth
            
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
            mainScroll.scrollRectToVisible(frame, animated: false)
            pageCounter.currentPage = page

        } else {
//Removeing subviews from scroll view
            let subViews = mainScroll.subviews
            for subView in subViews {
                subView.removeFromSuperview()
            }

//Switching width and height after rotating to landscape mode
            let scrollWidth: CGFloat = self.scrollWidth
            let scrollHeight: CGFloat = self.scrollHeight

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
            mainScroll.scrollRectToVisible(frame, animated: false)
            pageCounter.currentPage = page

            }

//Return page value after reseting the page size when rotating the screen
        self.page = page
    }
        
    
}
