//
//  EditorViewBuilder.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation
import UIKit

protocol EditorViewBuilderProtocol {
    static func build(with notices: Notices?) -> UIViewController
}

class EditorViewBuilder {
    static func build(with notice: Notices?) -> EditViewController? {
        let router = EditorViewRouter()
        let interactor = EditorViewInteractor(notice: notice)        
        let presenter = EditorViewPresenter(interactor: interactor, router: router)
        interactor.interactorOutput = presenter
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = mainSB
                .instantiateViewController(identifier: "EditViewController") as? EditViewController else { return nil }
        
        viewController.presenter = presenter
        presenter.viewInput = viewController
        router.editorViewController = viewController
        
        return viewController
    }
}
