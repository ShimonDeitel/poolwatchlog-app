import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: Store
    @Environment(\.dismiss) var dismiss
    @AppStorage("notifEnabled") private var notifEnabled = true
    @AppStorage("hapticEnabled") private var hapticEnabled = true
    @State private var showingPaywall = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Reminders", isOn: $notifEnabled)
                        .accessibilityIdentifier("remindersToggle")
                    Toggle("Haptics", isOn: $hapticEnabled)
                        .accessibilityIdentifier("hapticsToggle")
                }
                Section("Subscription") {
                    if store.isPro {
                        Label("Pro unlocked", systemImage: "checkmark.seal.fill")
                            .foregroundStyle(Theme.accent)
                    } else {
                        Button("Upgrade to Pro") { showingPaywall = true }
                            .accessibilityIdentifier("upgradeButton")
                    }
                }
                Section("About") {
                    Link("Privacy Policy", destination: URL(string: "https://shimondeitel.github.io/poolwatchlog-app/privacy.html")!)
                    Link("Terms of Use", destination: URL(string: "https://shimondeitel.github.io/poolwatchlog-app/terms.html")!)
                    Text("Poolwatch Log v1.0")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                        .accessibilityIdentifier("settingsDoneButton")
                }
            }
            .sheet(isPresented: $showingPaywall) {
                PaywallView()
            }
        }
    }
}
