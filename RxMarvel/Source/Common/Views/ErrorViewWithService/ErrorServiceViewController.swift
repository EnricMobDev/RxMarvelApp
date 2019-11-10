//
//  ErrorServiceViewController.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 10/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import UIKit

protocol ErrorServiceVCDelegate : AnyObject {
    func retryButton()
}

class ErrorServiceViewController: UIViewController {

    weak var delegate: ErrorServiceVCDelegate?
    
    @IBAction func retryAction(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.delegate?.retryButton()
        })
    }
}



