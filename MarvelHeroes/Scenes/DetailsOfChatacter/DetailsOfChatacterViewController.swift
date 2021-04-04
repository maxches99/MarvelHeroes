//
//  DetailsOfChatacterViewController.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 04.04.2021.
//

import UIKit
import Stevia
import RxCocoa
import RxSwift

class DetailsOfChatacterViewController: UIViewController {
    
    var vm: DetailsOfChatacterViewModel
    
    var bag = DisposeBag()
    
    var activity = UIActivityIndicatorView()
    
    var lblName = UILabel()
    
    var imgAvatar = UIImageView()
    
    var lblDescription = UILabel()
    
    var comicsStack = UIStackView()
    
    let sv = UIScrollView()
    
    init(vm: DetailsOfChatacterViewModel) {
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
        comicsStack.axis = .vertical
        
        lblDescription.numberOfLines = 0
        lblName.font = .systemFont(ofSize: 16, weight: .bold)
        
        view.subviews(
            imgAvatar,
            activity,
            sv.subviews(
                lblName,
                lblDescription,
                comicsStack
            )
        )
        activity.centerInContainer()
        imgAvatar.top(0).left(0).right(0).Height == imgAvatar.Width
        sv.left(16).right(16).bottom(0).Top == imgAvatar.Bottom + 8
        lblName.top(0).left(0).Width == sv.Width
        lblDescription.left(0).Top == lblName.Bottom + 8
        lblDescription.Width == sv.Width
        comicsStack.left(0).bottom(0).Top == lblDescription.Bottom + 8
        lblDescription.Width == sv.Width
        comicsStack.Width == sv.Width
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.fetch()
    }
    
    func setupBindings() {
        vm.isLoading
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] flag in
                self?.activity.isHidden = !flag
                if !flag {
                    self?.activity.stopAnimating()
                    self?.fill()
                } else {
                    self?.activity.startAnimating()
                }
            })
            .disposed(by: bag)
    }
    
    func fill() {
        lblName.text = vm.character?.name
        imgAvatar.download(image: vm.character?.thumbnail?.url)
        lblDescription.text = vm.character?.description
        vm.character?.comics?.items?.forEach { [weak self] item in
            let lbl = UILabel()
            lbl.text = item.name
            self?.comicsStack.addArrangedSubview(lbl)
        }
        vm.character?.series?.items?.forEach { [weak self] item in
            let lbl = UILabel()
            lbl.text = item.name
            self?.comicsStack.addArrangedSubview(lbl)
        }
        vm.character?.events?.items?.forEach { [weak self] item in
            let lbl = UILabel()
            lbl.text = item.name
            self?.comicsStack.addArrangedSubview(lbl)
        }
    }

}
