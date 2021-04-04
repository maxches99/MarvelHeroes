//
//  CollectionCharactersViewController.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 03.04.2021.
//

import UIKit
import Stevia
import RxCocoa
import RxSwift

class CollectionCharactersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var vm: CollectionCharactersViewModel
    
    var bag = DisposeBag()
    
    var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
        layout.itemSize = CGSize(width: UIViewController().view.bounds.width/2 - 30, height: UIViewController().view.bounds.width/2 + 50)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        
        return collectionView
    }()
    
    var activity = UIActivityIndicatorView()
    
    init(vm: CollectionCharactersViewModel) {
        self.vm = vm
        
        super.init(nibName: nil, bundle: nil)
        
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        var view = UIView()
        view.backgroundColor = .white
        
        let lbl = UILabel()
        lbl.text = "Characters"
        lbl.font = .systemFont(ofSize: 46, weight: .bold)
        
        view.subviews(
            lbl,
            collectionView,
            activity
        )
        activity.centerInContainer()
        lbl.top(26).left(16)
        collectionView.backgroundColor = .white
        collectionView.fillHorizontally().bottom(0).Top == lbl.Bottom + 16
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        vm.fetch()
        // Do any additional setup after loading the view.
    }
    
    func setupBindings() {
        vm.isLoading
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] flag in
                self?.activity.isHidden = !flag
                if !flag {
                    self?.collectionView.reloadData()
                    self?.activity.stopAnimating()
                } else {
                    self?.activity.startAnimating()
                }
            })
            .disposed(by: bag)
    }

}

extension CollectionCharactersViewController {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == vm.characters.count - 5 {
            vm.needNewPage.onNext(())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vm.selectedItem.onNext(vm.characters[indexPath.row].id)
    }
    
}

extension CollectionCharactersViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        let character = self.vm.characters[indexPath.row]
        cell.setup(item: character)
        return cell
    }
    
    
}
