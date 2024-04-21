//
//  CalendarView.swift
//  Custom Calendar
//
//  Created by Marcin Jędrzejak on 20/04/2024.
//

// Link part 1: https://www.youtube.com/watch?v=X_boPC1tg_Y&ab_channel=StewartLynch
// Link part 2: https://www.youtube.com/watch?v=tJC7izUkm8k&ab_channel=StewartLynch

import SwiftUI
import SwiftData

struct CalendarView: View {
    let date: Date
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    let selectedActivity: Activity?
    @Query private var workouts: [Workout]

    init(date: Date, selectedActivity: Activity?) {
        self.date = date
        self.selectedActivity = selectedActivity
        let endOfMonthAdjustment = Calendar.current.date(byAdding: .day, value: -1, to: date.endOfMonth)!
        let predicate = #Predicate<Workout> { $0.date >= date.startOfMonth && $0.date <= endOfMonthAdjustment }
        _workouts = Query(filter: predicate, sort: \Workout.date)
    }
    var body: some View {
        let color = selectedActivity == nil ? .blue : Color(hex: selectedActivity!.hexColor)!
        VStack {
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundColor(color)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Text(day.formatted(.dateTime.day()))
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(
                                        Date.now.startOfDay == day.startOfDay ? .red.opacity(0.3) : color.opacity(0.3)
                                    )
                            )
                    }
                }
            }
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
        .onChange(of: selectedActivity) {
        }
    }
}

#Preview {
    CalendarView(date: Date.now, selectedActivity: nil)
        .modelContainer(Activity.preview)
}
