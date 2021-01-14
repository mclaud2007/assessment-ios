//
//  EditViewRouter.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation
import UIKit

protocol EditViewRouterProtocol {
    var editorViewController: UIViewController? { get set }
    
    func goBack()
    func validateError()
}

class EditorViewRouter: EditViewRouterProtocol {
    weak var editorViewController: UIViewController?
    
    func goBack() {
        editorViewController?.navigationController?.popViewController(animated: true)
    }
    
    func validateError() {
        let ac = UIAlertController(title: "Ошибка", message: "Ошибка валидации данных", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.goBack()
        }
        ac.addAction(action)
        editorViewController?.present(ac, animated: true, completion: nil)
    }
}
