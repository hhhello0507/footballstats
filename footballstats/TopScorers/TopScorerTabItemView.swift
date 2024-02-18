//
//  TopScorerTabItemView.swift
//  footballstats
//
//  Created by dgsw8th71 on 2/18/24.
//

import SwiftUI
import XCAFootballDataClient

struct TopScorerTabItemView: View {
    
    @State var selectedCompetition: Competition?
    
    var body: some View {
        NavigationSplitView {
            List(Competition.defaultCompetitions, id: \.self, selection: $selectedCompetition) {
                Text($0.name)
            }
            .navigationTitle("XCA Football Scorers")
        } detail: {
            if let selectedCompetition {
                TopScorersTableView(competition: selectedCompetition)
                    .id(selectedCompetition)
            } else {
                Text("Select a competition")
            }
        }
    }
}

#Preview {
    TopScorerTabItemView(selectedCompetition: nil)
}
