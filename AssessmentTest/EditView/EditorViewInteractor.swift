//
//  EditorViewInteractor.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol EditorViewInteractorProtocol {
    var interactorOutput: EditorViewOutput? { get set }
    
    func loadNotice()
    func createOrUpdateNotice(with title: String, and content: String, onDone: @escaping () -> Void, onError: @escaping () -> Void)
}

final class EditorViewInteractor: EditorViewInteractorProtocol {
    weak var interactorOutput: EditorViewOutput?
    
    let networkService = NetworkService()
    let dataService = CoreDataService()
    var notice: Notices?
    
    init(notice: Notices?) {
        self.notice = notice
    }
    
    func loadNotice() {
        self.interactorOutput?.didItemLoaded(item: self.notice)
    }
        
    func createOrUpdateNotice(with title: String, and content: String, onDone: @escaping () -> Void, onError: @escaping () -> Void) {        
        guard var urlComponent = URLComponents(string: "https://www.purgomalum.com/service/plain") else {
            return
        }
        
        let queryItem = URLQueryItem(name: "text", value: content)
        urlComponent.queryItems = [queryItem]
        
        networkService.query(on: urlComponent) { [weak self] data in
            guard let self = self, let data = data else {
                onError()
                return
            }
            
            let contentString = String(data: data, encoding: .utf8)
            
            if self.notice != nil {
                self.notice?.noticeTitle = title
                self.notice?.noticeText = contentString
            } else {
                let result = self.dataService.insert(for: "Notices", title: title, content: content)
                self.notice = result
            }
            
            onDone()
        } onError: { _ in
            onError()
        }
    }
}
