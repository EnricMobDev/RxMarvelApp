//
//  URLRequest+extension.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 05/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                    let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
        }.map { response, data -> T in
            
            if 200 ..< 300 ~= response.statusCode {
                return try JSONDecoder().decode(T.self, from: data)
            } else {
                throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
            }
        }.asObservable()
    }
}
