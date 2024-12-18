//
//  CacheService.swift
//  TwitterClone
//
//  Created by Sevde Aydın on 12/18/24.
//

import Foundation

protocol CacheService {
    func setImageCache(url: String, data: Data) throws
    func retrieveImageFromCache(with url: String) throws -> Data?
    func clearAllCache() throws
}

enum CacheError: Error {
    case invalidData
    case cacheLimitExceeded
    case itemNotFound
    case clearCacheError
}

final class CacheManager: CacheService {
    
    private let cache = NSCache<NSString, NSData>()
    private var cachedUrls: Set<String> = []
    
    init(
        countLimit: Int = 100,
        totalCostLimit: Int = 50 * 1024 * 1024 // 50MB
    ) {
        self.cache.countLimit = countLimit
        self.cache.totalCostLimit = totalCostLimit
    }
    
    func setImageCache(url: String, data: Data) throws {
        guard data.count > 0 else {
            throw CacheError.invalidData
        }
        
        if !cachedUrls.contains(url) && cachedUrls.count >= cache.countLimit {
            throw CacheError.cacheLimitExceeded
        }
        
        cache.setObject(data as NSData, forKey: url as NSString)
        cachedUrls.insert(url)
    }
    
    func retrieveImageFromCache(with url: String) throws -> Data? {
        guard let cachedData = cache.object(forKey: url as NSString) else {
            throw CacheError.itemNotFound
        }
        return cachedData as Data
    }
    
    func clearAllCache() throws {
        cache.removeAllObjects()
        cachedUrls.removeAll()
    }
}
