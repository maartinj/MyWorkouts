//
//  CalendarView.swift
//  Custom Calendar
//
//  Created by Marcin Jędrzejak on 20/04/2024.
//

// Link part 1: https://www.youtube.com/watch?v=X_boPC1tg_Y&ab_channel=StewartLynch
// Link part 2: https://www.youtube.com/watch?v=tJC7izUkm8k&ab_channel=StewartLynch

import SwiftUI

struct CalendarView: View {
    @State private var color: Color = .blue
    let date: Date
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    var body: some View {
        VStack {
            LabeledContent("Calendar Color") {
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
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
    }
}

#Preview {
    CalendarView(date: Date.now)
}
