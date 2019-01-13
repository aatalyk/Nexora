//
//  UIImage+Extensions.swift
//  Nexora
//
//  Created by Mac on 1/13/19.
//  Copyright © 2019 aatalyk. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func from(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func from(_ urlString: String) -> UIImage {
        guard let url = URL(string: urlString) else { return UIImage()}
        do {
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else { return UIImage()}
            return image
        } catch {
            return UIImage()
        }
    }
}
