//
//  CharacterCollectionViewCell.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 03.04.2021.
//

import UIKit
import Stevia

class CharacterCollectionViewCell: UICollectionViewCell {
    
    var name: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    var decription: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 10)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var thumb = UIImageView()
    
    func setup(item: ComicCharacter) {
        name.text = item.name
        decription.text = item.description
        thumb.download(image: item.thumbnail?.url)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        var innerView = UIView()
        innerView.backgroundColor = .white
        
        self.subviews(
            innerView.subviews(
                name,
                thumb,
                decription
            )
        )
        innerView.left(2).right(2).top(2).bottom(2)
        backgroundColor = .black
        thumb.fillHorizontally().top(0)
        thumb.Width == thumb.Height
        name.left(0).right(0).Top == thumb.Bottom + 8
        decription.left(0).right(0).bottom(0).Top == name.Bottom + 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
