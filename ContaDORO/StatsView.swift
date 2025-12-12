import SwiftUI

struct StatsView: View {
    @ObservedObject var store: SandwichStore

    private var stats: SandwichStats {
        store.stats()
    }

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    summary
                    trend
                    historyList
                }
                .padding(20)
            }
        }
        .navigationTitle("Statistiche")
    }

    private var summary: some View {
        VStack(spacing: 12) {
            HStack {
                statTile(title: "Oggi", value: stats.todayCount, color: Theme.mustard, icon: "bag.fill")
                statTile(title: "Settimana", value: stats.weekTotal, color: Theme.neonGreen, icon: "calendar")
            }
            HStack {
                statTile(title: "Mese", value: stats.monthTotal, color: Theme.neonPink, icon: "chart.bar.fill")
                statTile(title: "Streak", value: stats.streak, color: Theme.teal, icon: "flame.fill")
            }
        }
    }

    private var trend: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ultimi 7 giorni")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white.opacity(0.8))

            let history = last7Days()
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(history, id: \.date) { item in
                    VStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(LinearGradient(colors: [Theme.neonPink, Theme.mustard], startPoint: .top, endPoint: .bottom))
                            .frame(width: 26, height: max(CGFloat(item.count) * 18, 4))
                        Text(shortLabel(for: item.date))
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Theme.neonPink.opacity(0.3), lineWidth: 1.5)
                    )
            )
        }
    }

    private var historyList: some View {
        let entries = store.history()
        return VStack(alignment: .leading, spacing: 12) {
            Text("Storico")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white.opacity(0.85))

            ForEach(entries) { entry in
                HStack {
                    VStack(alignment: .leading) {
                        Text(dateLabel(for: entry.date))
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                        Text(detailLabel(for: entry.date))
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    Spacer()
                    Text("\(entry.count)")
                        .font(.system(size: 20, weight: .black, design: .rounded))
                        .foregroundColor(Theme.neonGreen)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
            }
        }
    }

    private func statTile(title: String, value: Int, color: Color, icon: String) -> some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .bold))
                Spacer()
                Text(title)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white.opacity(0.85))
            Text("\(value)")
                .font(.system(size: 26, weight: .black, design: .rounded))
                .foregroundColor(color)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
        )
    }

    private func last7Days() -> [(date: Date, count: Int)] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let days = (0..<7).compactMap { calendar.date(byAdding: .day, value: -$0, to: today) }

        return days.reversed().map { day in
            let count = store.entries
                .filter { calendar.isDate($0.date, inSameDayAs: day) }
                .map(\.count)
                .reduce(0, +)
            return (date: day, count: count)
        }
    }

    private func shortLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "E"
        return formatter.string(from: date).uppercased()
    }

    private func dateLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    private func detailLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
}
