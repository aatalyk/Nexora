//
//  Photo.swift
//  Nexora
//
//  Created by Mac on 1/13/19.
//  Copyright © 2019 aatalyk. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Photo: Object, Mappable {
    @objc dynamic var albumId = 0
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var url = ""
    @objc dynamic var thumbnailUrl = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        albumId <- map["albumId"]
        id <- map["id"]
        title <- map["title"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
    }
}
