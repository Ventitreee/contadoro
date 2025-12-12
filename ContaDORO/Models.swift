import Foundation

struct SandwichEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    var count: Int
}

struct SandwichStats {
    let todayCount: Int
    let weekTotal: Int
    let monthTotal: Int
    let streak: Int
}

@MainActor
final class SandwichStore: ObservableObject {
    @Published private(set) var entries: [SandwichEntry] = []

    private let storageKey = "sandwich_entries"
    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.locale = .current
        cal.timeZone = .current
        return cal
    }()

    init() {
        entries = Self.loadEntries(forKey: storageKey)
        pruneOldDaysIfNeeded()
    }

    func incrementToday() {
        let today = calendar.startOfDay(for: Date())
        if let index = entries.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: today) }) {
            entries[index].count += 1
        } else {
            entries.append(SandwichEntry(id: UUID(), date: today, count: 1))
        }
        persist()
    }

    func stats() -> SandwichStats {
        let today = calendar.startOfDay(for: Date())
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) ?? today
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today)) ?? today

        let todayCount = entries
            .filter { calendar.isDate($0.date, inSameDayAs: today) }
            .map(\.count)
            .reduce(0, +)

        let weekTotal = entries
            .filter { $0.date >= startOfWeek }
            .map(\.count)
            .reduce(0, +)

        let monthTotal = entries
            .filter { $0.date >= startOfMonth }
            .map(\.count)
            .reduce(0, +)

        let streak = computeStreak(upTo: today)

        return SandwichStats(
            todayCount: todayCount,
            weekTotal: weekTotal,
            monthTotal: monthTotal,
            streak: streak
        )
    }

    func history(sortedByMostRecent: Bool = true) -> [SandwichEntry] {
        entries.sorted { lhs, rhs in
            sortedByMostRecent ? lhs.date > rhs.date : lhs.date < rhs.date
        }
    }

    private func computeStreak(upTo date: Date) -> Int {
        let sorted = entries.sorted { $0.date > $1.date }
        var streak = 0
        var current = date

        for entry in sorted {
            if calendar.isDate(entry.date, inSameDayAs: current) {
                streak += entry.count > 0 ? 1 : 0
                guard let previous = calendar.date(byAdding: .day, value: -1, to: current) else { break }
                current = previous
            } else if entry.date < current {
                // Gap detected; streak ends.
                break
            }
        }
        return streak
    }

    private func pruneOldDaysIfNeeded(maxDays: Int = 365) {
        let cutoff = calendar.date(byAdding: .day, value: -maxDays, to: Date()) ?? Date()
        entries = entries.filter { $0.date >= cutoff }
        persist()
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private static func loadEntries(forKey key: String) -> [SandwichEntry] {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let decoded = try? JSONDecoder().decode([SandwichEntry].self, from: data)
        else {
            return []
        }
        return decoded
    }
}
