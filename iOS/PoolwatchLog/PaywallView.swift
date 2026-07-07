import SwiftUI

struct PaywallView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var purchases: PurchaseManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(Theme.accentSoft)
                        .padding(.top, 40)
                    Text("Poolwatch Log Pro")
                        .font(Theme.titleFont)
                        .foregroundStyle(.white)
                    Text("Chemical trend charts and reorder reminders")
                        .font(Theme.bodyFont)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.horizontal, 32)
                    Spacer()
                    if let product = purchases.product {
                        Button {
                            Task {
                                await purchases.purchase()
                                store.isPro = purchases.isPro
                                if purchases.isPro { dismiss() }
                            }
                        } label: {
                            Text("Unlock — \(product.displayPrice)/month")
                                .font(Theme.headlineFont)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Theme.accent)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .accessibilityIdentifier("paywallPurchaseButton")
                        .padding(.horizontal, 24)
                    } else {
                        ProgressView()
                    }
                    Button("Restore Purchases") {
                        Task {
                            await purchases.restore()
                            store.isPro = purchases.isPro
                            if purchases.isPro { dismiss() }
                        }
                    }
                    .accessibilityIdentifier("restorePurchasesButton")
                    .font(Theme.captionFont)
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.bottom, 24)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .accessibilityIdentifier("paywallCloseButton")
                        .foregroundStyle(.white)
                }
            }
        }
    }
}
