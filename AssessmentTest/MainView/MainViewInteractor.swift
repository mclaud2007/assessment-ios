//
//  MainViewInteractor.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewInteractorProtocol {
    var intercatorOutput: MainViewOutput? { get set }
    
    func loadNotices()
    func remove(_ notice: Notices)
}

final class MainViewInteractor: MainViewInteractorProtocol {
    weak var intercatorOutput: MainViewOutput?
    let dataSercice = CoreDataService()
    
    func remove(_ notice: Notices) {
        self.dataSercice.delete(notice)
        self.loadNotices()
    }
    
    func loadNotices() {
        let result = self.dataSercice.fetch(entity: "Notices", as: Notices.self)
        self.intercatorOutput?.didItemsLoaded(items: result)
    }
}
