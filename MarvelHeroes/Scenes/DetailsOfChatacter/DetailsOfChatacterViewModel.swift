//
//  DetailsOfChatacterViewModel.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 04.04.2021.
//

import Foundation
import RxSwift
import RxCocoa

class DetailsOfChatacterViewModel {
    
    private let apiClient: MarvelAPIClient = MarvelAPIClient.shared
    
    private var endpoint: CharacterEndpoint
    
    var isLoading = PublishSubject<Bool>()
    var needNewPage = PublishSubject<Void>()

    var character: ComicCharacter?
    
    var bag = DisposeBag()
    
    init(id: Int) {
        endpoint = CharacterEndpoint(characterId: id)
        
        setupBindings()
    }
    
    func setupBindings() {
        needNewPage
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.fetch()
            })
            .disposed(by: bag)
    }
    
    func fetch() {
        isLoading.onNext(true)
        apiClient.send(endpoint) { [weak self] response in
            switch response {
            case .success(let dataContainer):
                self?.character = dataContainer.results.first
                self?.isLoading.onNext(false)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


