//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import Foundation
import Combine

final class TweetViewModel: ObservableObject {
    @Published private(set) var viewState: ViewState = .idle
    @Published var tweetList: [Tweet] = []
    
    private let networkManager: NetworkService
    private let cacheManager: CacheService
    
    private var cancellables = Set<AnyCancellable>()
    private var currentFetchTask: Task<Void, Never>?
    private var currentImageDownloadTask: Task<Data?, Never>?
    
    init(networkManager: NetworkService, cacheManager: CacheService) {
        self.networkManager = networkManager
        self.cacheManager = cacheManager
    }
    
    private func cancelCurrentTask() {
        currentFetchTask?.cancel()
        currentFetchTask = nil
    }
    
    private func cancelImageTask() {
        currentImageDownloadTask?.cancel()
        currentImageDownloadTask = nil
    }
    
    deinit {
        cancelCurrentTask()
        cancelImageTask()
    }
}

extension TweetViewModel {
    func fetchTweets() {
        cancelCurrentTask()
        currentFetchTask = Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            do {
                try Task.checkCancellation()
                
                let tweetResponse: Tweet = try await networkManager.fetch(with: TweetEndpoint.getTweets)
                print("tweet: \(tweetResponse)")
                try Task.checkCancellation()
                self.viewState = tweetList.isEmpty ? .noData : .showData
            } catch {
                if let networkError = error as? NetworkError {
                    self.viewState = .error(networkError.errorDescription)
                }
            }
        }
    }
}
