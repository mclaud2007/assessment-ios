//
//  AppManager.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation
import UIKit

final class AppManager {
    static let shared = AppManager()
    
    func start(with window: UIWindow?) {
        let mainView = MainViewBuilder.build()
        let navigationController = UINavigationController(rootViewController: mainView)
        
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }
}
