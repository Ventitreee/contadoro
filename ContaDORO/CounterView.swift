import SwiftUI

struct CounterView: View {
    @ObservedObject var store: SandwichStore
    @State private var bounce = false

    private var todayCount: Int {
        store.stats().todayCount
    }

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            VStack(spacing: 32) {
                header
                tallyCard
                Spacer()
                sandwichButton
                Spacer()
                footer
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)
            .padding(.bottom, 32)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.6).repeatForever()) {
                bounce.toggle()
            }
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text("ContaDORO")
                .font(.system(size: 36, weight: .black, design: .rounded))
                .foregroundColor(Theme.mustard)
                .shadow(color: Theme.neonPink.opacity(0.8), radius: 8, x: 0, y: 6)
            Text("Conta i panini di oggi in un tocco")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white.opacity(0.85))
        }
    }

    private var tallyCard: some View {
        VStack(spacing: 12) {
            Text("Panini di oggi")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
            Text("\(todayCount)")
                .font(.system(size: 72, weight: .black, design: .rounded))
                .foregroundColor(Theme.neonGreen)
                .shadow(color: Theme.neonGreen.opacity(0.4), radius: 10, x: 0, y: 4)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(Theme.neonPink.opacity(0.5), lineWidth: 2)
                )
        )
        .shadow(color: Theme.deeppurple.opacity(0.5), radius: 20, x: 0, y: 12)
    }

    private var sandwichButton: some View {
        Button(action: store.incrementToday) {
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Theme.mustard, Theme.neonPink.opacity(0.6), Theme.neonGreen.opacity(0.8)],
                            center: .center,
                            startRadius: 10,
                            endRadius: 160
                        )
                    )
                    .frame(width: 200, height: 200)
                    .shadow(color: Theme.neonPink.opacity(0.4), radius: 16, x: 0, y: 10)
                    .shadow(color: Theme.neonGreen.opacity(0.25), radius: 24, x: 0, y: 14)
                    .scaleEffect(bounce ? 1.02 : 0.98)

                VStack(spacing: 10) {
                    SandwichIcon()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                    Text("Aggiungi panino")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Theme.deeppurple)
                        .shadow(color: .white.opacity(0.5), radius: 6, x: 0, y: 3)
                }
            }
        }
        .buttonStyle(PressableStyle())
        .accessibilityLabel("Aggiungi un panino")
        .accessibilityHint("Aggiorna il conteggio di oggi")
    }

    private var footer: some View {
        Text("Tieni premuto il bottone per mordere ancora")
            .font(.system(size: 14, weight: .medium, design: .rounded))
            .foregroundColor(.white.opacity(0.7))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 12)
    }
}

private struct PressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.6, blendDuration: 0.1), value: configuration.isPressed)
    }
}

private struct SandwichIcon: View {
    var body: some View {
        ZStack(alignment: .center) {
            Capsule()
                .fill(Color(red: 0.94, green: 0.64, blue: 0.30))
                .frame(height: 90)
                .overlay(Capsule().stroke(Color.white.opacity(0.25), lineWidth: 3))
                .offset(y: -6)
            Capsule()
                .fill(Color(red: 0.94, green: 0.64, blue: 0.30))
                .frame(height: 90)
                .overlay(Capsule().stroke(Color.black.opacity(0.1), lineWidth: 2))
                .offset(y: 6)

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(LinearGradient(colors: [Theme.neonGreen, Color(red: 0.16, green: 0.55, blue: 0.29)], startPoint: .leading, endPoint: .trailing))
                .frame(height: 26)
                .shadow(color: Theme.neonGreen.opacity(0.35), radius: 4, x: 0, y: 3)

            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(LinearGradient(colors: [Color.white.opacity(0.9), Color(red: 0.95, green: 0.85, blue: 0.65)], startPoint: .top, endPoint: .bottom))
                .frame(height: 12)
                .offset(y: -18)
        }
        .padding(8)
    }
}

private extension Theme {
    static var deeppurple: Color { deepPurple }
}
