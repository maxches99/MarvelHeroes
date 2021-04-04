//
//  CoordinatorConfigurator.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 04.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
}

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController = UINavigationController()
    
    func start() {
        fatalError("Start method must be implemented")
    }
    
    func start(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
}

class AppCoordinator: BaseCoordinator {
    
    var window = UIWindow(frame: UIScreen.main.bounds)
    
    init(navC: UINavigationController) {
        super.init()
        
        navigationController = navC
    }
    
    override func start() {
        self.navigationController.navigationBar.isHidden = true
        self.childCoordinators.removeAll()
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
        if UserDefaults.standard.bool(forKey: "HasBeenShownInstructions") {
            openCollectionCharacters()
        } else {
            openInstruction()
        }
    }
    
    private func openCollectionCharacters() {
        let coordinator = CollectionCharactersCoordinator()
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
    
    private func openInstruction() {
        let coordinator = InstructionCoordinator()
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
