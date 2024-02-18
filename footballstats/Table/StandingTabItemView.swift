//
//  TabItemView.swift
//  footballstats
//
//  Created by dgsw8th71 on 2/18/24.
//

import SwiftUI
import XCAFootballDataClient

struct StandingTabItemView: View {
    
    @State var selectedCompetition: Competition?
    
    var body: some View {
        NavigationSplitView {
            List(Competition.defaultCompetitions, id: \.self, selection: $selectedCompetition) {
                Text($0.name)
            }
            .navigationTitle("XCA Football Standings")
        } detail: {
            if let selectedCompetition {
                StandingTableView(competition: selectedCompetition)
                    .id(selectedCompetition)
            } else {
                Text("Select a competition")
            }
        }
    }
}

#Preview {
    StandingTabItemView(selectedCompetition: nil)
}
