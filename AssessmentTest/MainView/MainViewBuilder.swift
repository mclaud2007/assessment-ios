//
//  MainViewBuilder.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewBuilderProtocol {
    static func build() -> (UIViewController & MainViewInput)
}

final class MainViewBuilder: MainViewBuilderProtocol {
    static func build() -> (UIViewController & MainViewInput) {
        let router = MainViewRouter()
        let interactor = MainViewInteractor()
        let presenter = MainViewPresenter(interactor: interactor, router: router)
        interactor.intercatorOutput = presenter
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = mainSB.instantiateViewController(identifier: "MainViewController") as? MainViewController else {
            preconditionFailure()
        }
        
        viewController.presenter = presenter
        presenter.viewInput = viewController
        router.mainViewController = viewController
                
        return viewController
    }
}
