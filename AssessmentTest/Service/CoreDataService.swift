//
//  CoreDataService.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class CoreDataService {
    let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    func insert(for entityName: String, title: String, content: String) -> Notices? {
        guard let context = container?.viewContext else {
            return nil
        }
        
        guard let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? Notices else {
            return nil
        }
        
        entity.noticeText = content
        entity.noticeTitle = title
        
        try? context.save()
        return entity
    }
    
    func fetch<T>(entity name: String, as: T.Type) -> [T]? {
        guard let context = container?.viewContext else {
            return nil
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let result = try? context.fetch(request)
        return result?.compactMap { $0 as? T }        
    }
    
    func delete(_ item: NSManagedObject) {
        guard let context = container?.viewContext else {
            return
        }
        
        context.delete(item)
        try? context.save()
    }
}
