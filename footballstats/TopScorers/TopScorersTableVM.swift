//
//  TopScorersVM.swift
//  footballstats
//
//  Created by dgsw8th71 on 2/18/24.
//

import Foundation
import Observation
import XCAFootballDataClient

@Observable
final class TopScorersTableVM {
    
    let client = FootballDataClient(apiKey: apiKey)
    var fetchPhase = FetchPhase<[Scorer]>.initial
    
    var scorers: [Scorer]? { fetchPhase.value }
    
    var selectedFilter = FilterOption.latest
    var filterOptions: [FilterOption] = {
        var date = Calendar.current.date(byAdding: .year, value: -4, to: Date())!
        var options = [FilterOption]()
        for i in 0..<3 {
            if let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: date) {
                options.append(.year(Calendar.current.component(.year, from: nextYear)))
                date = nextYear
            }
        }
        options.append(.latest)
        return options
    }()
    
    func fetchTopScorers(competition: Competition) async {
        fetchPhase = .fetching
        do {
            var scorers = try await client.fetchTopScorers(competitionId: competition.id, filterOption: selectedFilter)
            scorers = scorers.enumerated().map { idx, scorer in
                var scorer = scorer
                scorer.pos = idx + 1
                return scorer
            }
            if Task.isCancelled { return }
            fetchPhase = .success(scorers)
        } catch {
            if Task.isCancelled { return }
            fetchPhase = .failure(error)
        }
    }
    
}
