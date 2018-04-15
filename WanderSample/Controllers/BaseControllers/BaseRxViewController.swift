//
//  BaseRxViewController.swift
//  WanderSample

//  Created by Saif Chaudhary on 15/04/18.
//  Copyright © 2018 Satinder Kumar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import EZSwiftExtensions

class BaseRxViewController: UIViewController {

    var bag = DisposeBag()
    var apiBarrier = false

    @IBOutlet weak var btnBack : UIButton!
    @IBOutlet weak var backView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingClicks()
        bindings()
    }
    
    /** Binding Back Button **/
    func bindingClicks(){
        
        let backSignal = btnBack?.rx.tap
        backSignal?.asDriver().drive(onNext: { [unowned self]() in
            self.popVC()
            self.dismissVC(completion: nil)
        }).disposed(by: bag)
        
        if let background = self.backView {
            background.addTapGesture { (_) in
                self.view.endEditing(true)
            }
        }
        
    }
    
    /** Binding with View Model **/
    func bindings() {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}


extension BaseRxViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
}
