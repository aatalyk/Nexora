//
//  NetworkManager.swift
//  Nexora
//
//  Created by Mac on 1/13/19.
//  Copyright © 2019 aatalyk. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RealmSwift

protocol Networkable {
    var realm: Realm { get }
    var provider: MoyaProvider<Api> { get }
    func fetchPhotos(completion: @escaping ([Photo]) -> ())
}

struct NetworkManager: Networkable {
    
    var realm = try! Realm()
    var provider = MoyaProvider<Api>()
    
    func fetchRemote(completion: @escaping () -> ()) {
        provider.request(.photos) { result in
            switch result {
            case let .success(response):
                if(response.statusCode >= 200 && response.statusCode <= 299) {
                    let data = response.data
                    do {
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else { return }
                        do {
                            let realm = try Realm()
                            try realm.write {
                                for i in 0 ..< 10 {
                                    let object = json[i]
                                    if let photo = Photo(JSON: object) {
                                        realm.add(photo, update: true)
                                    }
                                }
                            }
                        } catch let error {
                            print(error)
                        }
                        completion()
                    } catch let error {
                        print(error)
                    }
                }
            case let .failure(error):
                print(error)
                completion()
            }
        }
    }
    
    func fetchLocal() -> [Photo] {
        let photos = realm.objects(Photo.self).toArray(ofType: Photo.self) as [Photo]
        return photos
    }
    
    func fetchPhotos(completion: @escaping ([Photo]) -> ()) {
        self.fetchRemote {
            completion(self.fetchLocal())
        }
    }
}
