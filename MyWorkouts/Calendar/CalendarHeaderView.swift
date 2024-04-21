//
//  CalendarHeaderView.swift
//  MyWorkouts
//
//  Created by Marcin Jędrzejak on 21/04/2024.
//

import SwiftUI
import SwiftData

struct CalendarHeaderView: View {
    @State private var monthDate = Date.now
    @State private var years: [Int] = []
    @State private var selectedMonth = Date.now.monthInt
    @State private var selectedYear = Date.now.yearInt
    @Query private var workouts: [Workout]
    let months = Date.fullMonthNames
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Picker("",selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text(String(year))
                        }
                    }
                    Picker("",selection: $selectedMonth) {
                        ForEach(months.indices, id: \.self) { index in
                            Text(months[index]).tag(index + 1)
                        }
                    }
                }
                .buttonStyle(.bordered)
                CalendarView(date: monthDate)
                Spacer()
            }
            .navigationTitle("Tallies")
        }
        .onAppear {
            years = Array(Set(workouts.map {$0.date.yearInt}.sorted()))
        }
        .onChange(of: selectedYear) {
            updateDate()
        }
        .onChange(of: selectedMonth) {
            updateDate()
        }
    }

    func updateDate() {
        monthDate = Calendar.current.date(from: DateComponents(year: selectedYear, month: selectedMonth, day: 1))!
    }
}

#Preview {
    CalendarHeaderView()
        .modelContainer(Activity.preview)
}
