//
//  P3.swift
//  UIScrollView50220
//
//  Created by leslie on 5/11/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class P3: UIViewController {

    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign self location to the delegate
        descriptionView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        descriptionView.endEditing(true)
    }
}

extension P3: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let height = descriptionView.frame.origin.y + (descriptionView.frame.height / 2)
        mainScroll.setContentOffset(CGPoint(x: 0, y: height), animated: true)
    }
}
