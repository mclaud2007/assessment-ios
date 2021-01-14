//
//  NetworkService.swift
//  AssessmentTest
//
//  Created by Григорий Мартюшин on 14.01.2021.
//  Copyright © 2021 Михаил Юранов. All rights reserved.
//

import Foundation

final class NetworkService {
    func query(on destination: URLComponents, onDone: @escaping ((Data?) -> Void), onError: @escaping ((Error?) -> Void)) {
        guard let url = destination.url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                onError(error)
                return
            }            
            onDone(data)
        }.resume()
    }
}
