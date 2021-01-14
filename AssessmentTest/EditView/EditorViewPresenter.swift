//
//  EditorViewPresenter.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation
import UIKit

protocol EditorViewInput: class {
    func viewIsReady(notice: Notices?)
}

protocol EditorViewOutput: class {
    func didViewReady()
    func didItemLoaded(item: Notices?)
    func didAddButtonClicked(with title: String, and content: String)
}

class EditorViewPresenter {
    let router: EditViewRouterProtocol
    let interactor: EditorViewInteractorProtocol
    var viewInput: (UIViewController & EditorViewInput)?
    
    init(interactor: EditorViewInteractorProtocol, router: EditViewRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension EditorViewPresenter: EditorViewOutput {
    func didViewReady() {
        self.interactor.loadNotice()
    }
    
    func didItemLoaded(item: Notices?) {
        self.viewInput?.viewIsReady(notice: item)
    }
    
    func didAddButtonClicked(with title: String, and content: String) {
        self.interactor.createOrUpdateNotice(with: title, and: content, onDone: { [weak self = self] in
            DispatchQueue.main.async {
                self?.router.goBack()
            }
        }, onError: { [weak self] in
            DispatchQueue.main.async {
                self?.router.validateError()
            }
        })
    }
}
