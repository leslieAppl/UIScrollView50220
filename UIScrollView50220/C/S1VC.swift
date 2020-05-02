//
//  ViewController.swift
//  UIScrollView50220
//
//  Created by leslie on 5/2/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class S1VC: UIViewController {
    
    @IBOutlet weak var mainScroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgView = UIImageView(image: UIImage(named: "doll"))

        mainScroll.contentSize = imgView.frame.size
        mainScroll.addSubview(imgView)

        let logoView = UIImageView(frame: CGRect(x: 25, y: 25, width: 50, height: 50))
        logoView.image = UIImage(named: "logo")
        mainScroll.addSubview(logoView)



    }





}

