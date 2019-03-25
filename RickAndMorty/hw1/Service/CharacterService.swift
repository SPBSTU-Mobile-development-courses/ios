//
//  CharacterService.swift
//  hw1
//
//  Created by Александр Пономарёв on 12/03/2019.
//  Copyright © 2019 Александр Пономарёв. All rights reserved.
//

protocol CharacterService {
    func getCharacter(url: String?, _ completionHandler: @escaping (([Person], String?) -> Void))
    func getPlanet(url: String?, _ completionHandler: @escaping ((Planet) -> Void))
}
