//
//  CollectionCharactersCoordinator.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 04.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

class CollectionCharactersCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    override func start() {
        let viewModel: CollectionCharactersViewModel = CollectionCharactersViewModelImpl()
        let viewController = CollectionCharactersViewController(vm: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
        
        viewModel.selectedItem
            .asDriver(onErrorJustReturn: 0)
            .drive(onNext: { [weak self] id in
                guard let strongSelf = self else { return }
                strongSelf.openDetail(id)
            })
            .disposed(by: disposeBag)
    }
    
    func openDetail(_ id: Int) {
        self.navigationController.navigationBar.isHidden = true
        
        let coordinator = DetailsOfChatacterCoordinator(id: id)
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
