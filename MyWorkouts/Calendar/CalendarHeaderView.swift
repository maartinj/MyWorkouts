//
//  CalendarHeaderView.swift
//  MyWorkouts
//
//  Created by Marcin Jędrzejak on 21/04/2024.
//

import SwiftUI

struct CalendarHeaderView: View {
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView()
                Spacer()
            }
            .navigationTitle("Tallies")
        }
    }
}

#Preview {
    CalendarHeaderView()
}
