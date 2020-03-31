//
//  MemeFacade.swift
//  Memes
//
//  Created by panandafog on 30.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import RealmSwift

final class MemeFacadeImpl: MemeFacade {
    private let memeRepository: MemeRepository
    private let memeService: MemeService
    private var memeToken: NotificationToken?

    init(memeService: MemeService, memeRepository: MemeRepository) {
        self.memeRepository = memeRepository
        self.memeService = memeService
    }

    func loadMore() {
        memeService.getMemes(newPage: true, completion: {
            guard let posts = $0 else { return }
            self.memeRepository.save(posts)
        })
    }

    func getMemes(completion: @escaping OnUpdatePosts) {
        memeService.getMemes(newPage: false, completion: {
            guard let posts = $0 else { return }
            self.memeRepository.save(posts)
        })
        let posts = memeRepository.getMemes()
        memeToken = posts.observe { _ in
            completion(posts.map { $0.post })
        }
    }

    func getRepository() -> MemeRepository {
        memeRepository
    }
}

protocol MemeFacade {
    typealias OnUpdatePosts = ([Post]?) -> Void

    func getMemes(completion: @escaping OnUpdatePosts)
    func loadMore()
    func getRepository() -> MemeRepository
}
