//
//  NotesViewController.swift
//  WanderSample
//
//  Created by Saif Chaudhary on 15/04/18.
//  Copyright © 2018 Satinder Kumar. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
import RxSwift
import RxCocoa


class NotesViewController: BaseRxViewController {
    
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var txtDesc: KMPlaceholderTextView!
    
    var note : Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    //MARK: -  setupView
    
    func setupView(){
        
        tfTitle?.text =  note?.title
        txtDesc?.text = note?.desc
        btnDelete?.isHidden = note == nil
        btnUpdate?.isHidden = btnDelete.isHidden
        btnAdd?.isHidden = !btnDelete.isHidden
        txtDesc?.layer.cornerRadius = 4
        txtDesc?.layer.borderWidth = 1
        txtDesc?.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        txtDesc?.placeholder = "Description"
        
    }
    
}

//MARK: -  IBAction

extension NotesViewController {
    
    @IBAction func actiontBtnAdd(_ sender: UIButton) {
        
        if sender.tag == 11 {
            
            note?.title = /tfTitle?.text
            note?.desc = /txtDesc?.text
            note?.updateModel()
            
        }else if sender.tag == 12 {
            note?.removeModel()
            
        }else {
            let data = Notes()
            data.title = /tfTitle?.text
            data.desc = /txtDesc?.text
            data.noteId = Int64(arc4random())
            data.saveModel()
        }
        
        self.dismissVC(completion: nil)
        
    }
    
    @IBAction func actionBtnBack(_ sender: UIButton) {
        self.dismissVC(completion: nil)
        
    }
    
}

//MARK: -  UITextViewDelegate

extension NotesViewController :UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 300
    }
    
}
