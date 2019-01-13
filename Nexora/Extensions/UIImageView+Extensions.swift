//
//  UIImageView+Extensions.swift
//  Nexora
//
//  Created by Mac on 1/13/19.
//  Copyright © 2019 aatalyk. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(urlString: String) {
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
