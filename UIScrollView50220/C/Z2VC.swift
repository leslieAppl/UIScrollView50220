//
//  Z2VC.swift
//  UIScrollView50220
//
//  Created by leslie on 5/2/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class Z2VC: UIViewController {

    @IBOutlet weak var mainScroll: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScroll.delegate = self
    
//To force the system to update the layout value when we need them
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        imageView = UIImageView(image: UIImage(named: "doll"))
        
//Cauculating the minimum and maximum scales to zoom out enough to see the whole image on the screen.
        let imgWidth = imageView.frame.size.width
        let imgHeight = imageView.frame.size.height
        let scrollWidth = mainScroll.frame.size.width
        let scrollHeight = mainScroll.frame.size.height
        
        let minScale = min(scrollWidth/imgWidth, scrollHeight/imgHeight)
        let maxScale = max(minScale*10, 1)
        mainScroll.minimumZoomScale = minScale
        mainScroll.maximumZoomScale = maxScale

//Adding subview to the scroll view
        mainScroll.contentSize = imageView.frame.size
        mainScroll.addSubview(imageView)
    }
    
    
    
}

extension Z2VC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
