//
//  Z1VC.swift
//  UIScrollView50220
//
//  Created by leslie on 5/2/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class Z1VC: UIViewController {

    @IBOutlet weak var mainScroll: UIScrollView!
    var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScroll.delegate = self
        
        imgView = UIImageView(image: UIImage(named: "doll"))
        
        mainScroll.contentSize = imgView.frame.size
        mainScroll.minimumZoomScale = 0.1
        mainScroll.maximumZoomScale = 10
        mainScroll.addSubview(imgView)
    }
    
    

}

extension Z1VC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
}





