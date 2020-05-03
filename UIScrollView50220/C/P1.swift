//
//  P1.swift
//  UIScrollView50220
//
//  Created by leslie on 5/3/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class P1: UIViewController {

    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var pageCounter: UIPageControl!
    var imageView: UIImageView!
    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images = ["spot1", "spot2", "spot3", "home1", "home2", "home3", "home4", "home5"]
        pageCounter.numberOfPages = images.count
        pageCounter.pageIndicatorTintColor = .black
        pageCounter.currentPageIndicatorTintColor = .white
        
        mainScroll.delegate = self
        mainScroll.isPagingEnabled = true
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        let scrollWidth = mainScroll.frame.size.width
        let scrollHeight = mainScroll.frame.size.height

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

extension P1: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//Calculating the page
        let pageWidth = mainScroll.frame.size.width
        let getPage = round(mainScroll.contentOffset.x/pageWidth)
        let currentPage = Int(getPage)
        page = currentPage
        pageCounter.currentPage = page
    }
}
