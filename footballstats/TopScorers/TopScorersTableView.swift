//
//  TopScorersView.swift
//  footballstats
//
//  Created by dgsw8th71 on 2/18/24.
//

import SwiftUI
import XCAFootballDataClient

struct TopScorersTableView: View {
    
    let competition: Competition
    @Bindable
    var vm = TopScorersTableVM()
    
    var body: some View {
        Table(of: Scorer.self) {
            TableColumn("Pos") { scorer in
                HStack {
                    Text(scorer.posText)
                        .fontWeight(.bold)
                        .frame(minWidth: 20)
                    AsyncImage(url: URL(string: scorer.team.crest ?? "")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                        default:
                            Circle()
                                .foregroundStyle(Color.gray.opacity(0.5))
                        }
                    }
                    .frame(width: 40, height: 40)
                    Text(scorer.player.name)
                }
            }
            .width(min: 264)
            TableColumn("Matches") {
                Text($0.playedMatchesText)
                    .frame(minWidth: 64)
            }
            .width(64)
            TableColumn("Goals") {
                Text($0.goalsText)
                    .frame(minWidth: 64)
            }
            .width(64)
            TableColumn("X Goals") {
                Text($0.goalsPerMatchRatioText)
                    .frame(minWidth: 64)
            }
            .width(64)
            TableColumn("Assists") {
                Text($0.playedMatchesText)
                    .frame(minWidth: 64)
            }
            .width(64)
            TableColumn("Pen.") {
                Text($0.playedMatchesText)
                    .frame(minWidth: 64)
            }
            .width(64)
        } rows: {
            ForEach(vm.scorers ?? []) {
                TableRow($0)
            }
        }
        .overlay {
            switch vm.fetchPhase {
            case .fetching:
                ProgressView()
            case .failure(let error):
                Text(error.localizedDescription)
                    .font(.headline)
            default:
                EmptyView()
            }
        }
        .foregroundStyle(.primary)
        .navigationTitle(competition.name + " top scorers")
        .task(id: vm.selectedFilter.id) {
            await vm.fetchTopScorers(competition: competition)
        }
        .toolbar {
            ToolbarItem(placement: .bottomOrnament) {
                Picker("Filter Options", selection: $vm.selectedFilter) {
                    ForEach(vm.filterOptions, id: \.self) { season in
                        Text(" \(season.text) ")
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TopScorersTableView(competition: .defaultCompetitions[0])
    }
}
