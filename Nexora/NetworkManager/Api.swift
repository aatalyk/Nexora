//
//  PhotoApi.swift
//  Nexora
//
//  Created by Mac on 1/13/19.
//  Copyright © 2019 aatalyk. All rights reserved.
//

import Foundation
import Moya

enum Api {
    case photos
}

extension Api: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "http://jsonplaceholder.typicode.com") else { fatalError("baseURL can not configured")}
        return url
    }
    
    var path: String {
        switch self {
        case .photos:
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .photos:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .photos:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .photos:
            return stubbedResponse("Photos")
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject {}
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: ".json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}
