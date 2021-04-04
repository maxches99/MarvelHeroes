//
//  CollectionCharactersViewModel.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 04.04.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol CollectionCharactersViewModel {
    var isLoading: PublishSubject<Bool> { get }
    var selectedItem: PublishSubject<Int> { get }
    var needNewPage: PublishSubject<Void> { get }
    var characters: [ComicCharacter] { get }
    
    func fetch()
}

class CollectionCharactersViewModelImpl: CollectionCharactersViewModel {
    
    private let apiClient: MarvelAPIClient = MarvelAPIClient.shared
    private var endpoint = CharactersEndpoint()
    
    var selectedItem = PublishSubject<Int>()
    var isLoading = PublishSubject<Bool>()
    var needNewPage = PublishSubject<Void>()
    
    var limit = 20
    var characters: [ComicCharacter] = []
    
    var bag = DisposeBag()
    
    init() {
        endpoint.limit = limit
        endpoint.offset = 0
        
        setupBindings()
    }
    
    func setupBindings() {
        needNewPage
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.endpoint.offset += strongSelf.limit
                strongSelf.fetch()
            })
            .disposed(by: bag)
    }
    
    func fetch() {
        isLoading.onNext(true)
        apiClient.send(endpoint) { response in

            response.map { [weak self] dataContainer in
                self?.characters.append(contentsOf: dataContainer.results)
                self?.isLoading.onNext(false)
            }
        }
    }
    
}

