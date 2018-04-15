//
//  NotesListViewController.swift
//  WanderSample
//
//  Created by Saif Chaudhary on 15/04/18.
//  Copyright © 2018 Satinder Kumar. All rights reserved.
//

import UIKit
import UIKit
import RxSwift
import RxCocoa


class NotesListViewController: BaseRxViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let notesListVM = NotesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onViewDidLoad()
    }
    
    func onViewDidLoad() {
        tableView.contentInset.top = 20
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesListVM.getList()
    }
    
    
    //MARK: -  bindings
    
    override func bindings()
    {
        
        notesListVM.arrayOfNotesList
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier:"NoteListCell" , cellType: UITableViewCell.self)) { (row,element,cell) in
                cell.textLabel?.text = (element as? Notes)?.title
                cell.detailTextLabel?.text = (element as? Notes)?.desc
            }<bag
        
        
        tableView.rx.setDelegate(self)<bag
    }
    
}

//MARK: -  UITableViewDelegate

extension NotesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc =  storyboard?.instantiateViewController(withIdentifier:"NotesViewController") as? NotesViewController
        vc?.note = notesListVM.arrayOfNotesList.value[indexPath.row] as? Notes
        present(vc!, animated: true, completion: nil)
        
    }
}

