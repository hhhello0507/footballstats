//
//  footballstatsApp.swift
//  footballstats
//
//  Created by dgsw8th71 on 2/18/24.
//

import SwiftUI

@main
struct footballstatsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                StandingTabItemView()
                    .tabItem {
                        Label("Standings", systemImage: "table.fill")
                    }
                TopScorerTabItemView()
                    .tabItem {
                        Label("Top Scorers", systemImage: "soccerball.inverse")
                    }
            }
        }
    }
}
