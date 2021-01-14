//
//  MainViewPresenter.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewInput: class {
    var notices: [Notices] { get set }
    func itemsChanged()
}

protocol MainViewOutput: class {
    var router: MainViewRouterProtocol { get }
    var interactor: MainViewInteractorProtocol { get }
    
    func didViewReady()
    func didItemsLoaded(items: [Notices]?)
    func didSelectNotice(_ notice: Notices?)
    func didRemoveNotice(_ notice: Notices?)
    func addNoticeClicked()
}

class MainViewPresenter {
    let router: MainViewRouterProtocol
    let interactor: MainViewInteractorProtocol
    var viewInput: (UIViewController & MainViewInput)?
    
    init(interactor: MainViewInteractorProtocol, router: MainViewRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MainViewPresenter: MainViewOutput {
    func didViewReady() {
        self.interactor.loadNotices()
    }
    
    func didItemsLoaded(items: [Notices]?) {
        self.viewInput?.notices = items ?? []
        self.viewInput?.itemsChanged()
    }
    
    func didRemoveNotice(_ notice: Notices?) {
        guard let notice = notice else { return }
        self.interactor.remove(notice)
    }
    
    func didSelectNotice(_ notice: Notices?) {
        router.openEditor(with: notice)
    }
    
    func addNoticeClicked() {
        router.openEditor(with: nil)
    }
}
