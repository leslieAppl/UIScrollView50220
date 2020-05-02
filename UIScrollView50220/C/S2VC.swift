//
//  S2VC.swift
//  UIScrollView50220
//
//  Created by leslie on 5/2/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class S2VC: UIViewController {

    @IBOutlet weak var mainScroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imgView = UIImageView(image: UIImage(named: "doll"))
        mainScroll.contentSize = imgView.frame.size
        mainScroll.addSubview(imgView)

        let logoView = UIImageView(image: UIImage(named: "logo"))
        mainScroll.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        logoView.topAnchor.constraint(equalTo: mainScroll.frameLayoutGuide.topAnchor, constant: 25).isActive = true
        logoView.leadingAnchor.constraint(equalTo: mainScroll.frameLayoutGuide.leadingAnchor, constant: 25).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
}
