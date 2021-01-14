//
//  MainViewRouter.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewRouterProtocol {
    var mainViewController: MainViewController? { get set }
    func openEditor(with notices: Notices?)
}

class MainViewRouter: MainViewRouterProtocol {
    weak var mainViewController: MainViewController?
    
    func openEditor(with notices: Notices? = nil) {
        guard let viewController = EditorViewBuilder.build(with: notices) else { return }
        mainViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
