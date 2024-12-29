//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/21/24.
//

import Foundation
import Combine

@MainActor
final class TweetViewModel: ObservableObject {
    @Published private(set) var viewState: ViewState = .idle
    @Published var tweets = [Tweet]()
    @Published var errorMessage: String?
    private let tweetManager: TweetService
    
    private var cancellables = Set<AnyCancellable>()
    private var currentFetchTask: Task<Void, Never>?
    private var currentImageDownloadTask: Task<Data?, Never>?
    
    init(tweetManager: TweetService) {
        self.tweetManager = tweetManager
        Task {
            await fetchTweets()
        }
    }
    
    func fetchTweets() async {
        self.viewState = .loading
        
        do {
            let tweet = try await tweetManager.fetchTweets()
            self.tweets = tweet
            self.viewState = .showData
        } catch let error as NetworkError {
            handleError(error: error)
        } catch {
            handleError(error: NetworkError.unknown)
        }
    }
    
    private func handleError(error: NetworkError) {
        self.viewState = .error(error.localizedDescription)
        self.errorMessage = error.localizedDescription
        print(error.localizedDescription)
    }
}


