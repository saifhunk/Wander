//
//  NotificationsViewModel.swift
//  Connect
//
//  Created by OSX on 26/12/17.
//  Copyright © 2017 OSX. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import Foundation


class NotesListViewModel: BaseRxViewModal {
    
    var arrayOfNotesList = Variable<[Any]>([])
    
    func getList() {
       
        arrayOfNotesList.value =  Notes().retriveModel(type: Notes.self).reversed()
    }
    
}
