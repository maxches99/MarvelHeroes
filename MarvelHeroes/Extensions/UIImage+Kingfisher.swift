//
//  UIImage+Kingfisher.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 04.04.2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func download(image url: URL?) {
        guard let imageURL = url else {
            return
        }
        kf.indicatorType = .activity
        kf.setImage(with: ImageResource(downloadURL: imageURL))
    }
}
