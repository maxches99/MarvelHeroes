//
//  DetailsOfChatacterCoordinator.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 04.04.2021.
//

import Foundation
import RxSwift
import RxCocoa

class DetailsOfChatacterCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: DetailsOfChatacterViewModel
    
    init(id: Int) {
        viewModel = DetailsOfChatacterViewModel(id: id)
        
        super.init()
    }
    
    override func start() {
        let viewController = DetailsOfChatacterViewController(vm: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
