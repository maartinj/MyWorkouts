//
//  StartTab.swift
//  MyWorkouts
//
//  Created by Marcin Jędrzejak on 21/04/2024.
//

import SwiftUI
import SwiftData

struct StartTab: View {
    var body: some View {
        TabView {
            ActivityListView()
                .tabItem {
                    Label("Activities", systemImage: "figure.mixed.cardio")
                }
            CalendarHeaderView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    StartTab()
        .modelContainer(Activity.preview)
}
