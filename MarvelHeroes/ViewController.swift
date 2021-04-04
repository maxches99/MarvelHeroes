//
//  ViewController.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 03.04.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiClient = MarvelAPIClient(publicKey: "c28ab9fb3e26c25bd9587126a00babb8",
                                        privateKey: "cc1335c1ee1b6d0ed1da337333cea261fc6d0c78")
        apiClient.send(CharactersEndpoint()) { response in
            print("\nGetCharacters finished:")

            response.map { dataContainer in
                for character in dataContainer.results {
                    print("  Title: \(character.name ?? "Unnamed character")")
                    print("  Thumbnail: \(character.thumbnail?.url.absoluteString ?? "None")")
                }
            }
        }
    }


}

