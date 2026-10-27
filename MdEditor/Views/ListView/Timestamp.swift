//
//  Timestamp.swift
//  MdEditor
//
//  Created by Zack Williams on 23-10-2026.
//

import Foundation
import SwiftUI

struct Timestamp: View {
    var timestamp: Date = .now

    var calendar: Calendar = .current

    private func startOfDay() -> Date {
        return calendar.startOfDay(for: .now)
    }

    private func startOfYesterday() -> Date {
        return startOfDay().addingTimeInterval(-86400)
    }

    private func dayOfWeek(timestamp: Date = .now) -> Int {
        return calendar.component(.weekday, from: timestamp)
    }

    private func startOfWeek() -> Date {
        let timeInterval = Double(-86400 * (dayOfWeek() - 1))

        return startOfDay().addingTimeInterval(timeInterval)
    }

    var body: some View {
        if timestamp >= startOfDay() {
            Text(timestamp, style: .time)
        } else if timestamp >= startOfYesterday() {
            Text("Yesterday")
        } else if timestamp >= startOfWeek() {
            Text(calendar.weekdaySymbols[dayOfWeek() - 1])
        } else {
            Text(timestamp.formatted(date: .numeric, time: .omitted))
        }
    }
}

#Preview {
    Timestamp()
}
