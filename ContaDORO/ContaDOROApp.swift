import SwiftUI

@main
struct ContaDOROApp: App {
    @StateObject private var store = SandwichStore()
    @State private var selection = 0

    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
                CounterView(store: store)
                    .tabItem {
                        Image(systemName: "bag.fill")
                        Text("Oggi")
                    }
                    .tag(0)

                StatsView(store: store)
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                        Text("Statistiche")
                    }
                    .tag(1)
            }
            .accentColor(.yellow)
            .preferredColorScheme(.light)
        }
    }
}
