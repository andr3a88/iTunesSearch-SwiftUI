//
//  RecentSearchRepository.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 25/09/23.
//

import Foundation

protocol RecentSearchRepositoryType {
    func store(searchTerm: String)
    func fetch() -> [String]
    func clear()
}

final class RecentSearchRepository: RecentSearchRepositoryType, ObservableObject {
    
    private let userDefaults: UserDefaults
    private let limiteStorageCount: Int
    
    @Published var recentSearch: [String] = []
    
    init(userDefaults: UserDefaults = UserDefaults(suiteName: "group.as.iTunesSearch")!,
         limiteStorageCount: Int = 5) {
        self.userDefaults = userDefaults
        self.limiteStorageCount = limiteStorageCount
        self.recentSearch = self.fetch()
    }
    
    func store(searchTerm: String) {
        var recentSearch = self.fetch()
        
        // Limit search and remove duplicates
        if recentSearch.count > limiteStorageCount {
            recentSearch.removeFirst()
        }
        recentSearch.append(searchTerm)
        recentSearch.removeDuplicates()
        
        print("Saving \(searchTerm)")
        print("Recent Search \(recentSearch.description)")
        
        userDefaults.setValue(recentSearch, forKey: "recentSearch")
        userDefaults.synchronize()
        
        self.recentSearch = recentSearch
    }
    
    func fetch() -> [String] {
        guard let recentSearch = userDefaults.value(forKey: "recentSearch") as? [String] else {
            return []
        }
        self.recentSearch = recentSearch
        return recentSearch
    }
    
    func clear() {
        userDefaults.removeObject(forKey: "recentSearch")
        userDefaults.synchronize()
        self.recentSearch = []
    }
}

private extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }}
