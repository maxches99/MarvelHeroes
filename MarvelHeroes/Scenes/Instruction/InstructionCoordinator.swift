//
//  InstructionCoordinator.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 04.04.2021.
//

import Foundation
import RxSwift
import RxCocoa

class InstructionCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = InstructionViewModel()
    
    override func start() {
        let viewController = InstructionViewController(vm: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
        
        viewModel.goNext
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                guard let strongSelf = self else { return }
                UserDefaults.standard.set(true, forKey: "HasBeenShownInstructions")
                strongSelf.openCollectionCharacters()
            })
            .disposed(by: disposeBag)
    }
    
    private func openCollectionCharacters() {
        let coordinator = CollectionCharactersCoordinator()
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}

