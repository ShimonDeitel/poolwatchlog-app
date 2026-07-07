import Foundation

struct PoolReading: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var chlorine: Double = 3.0
    var ph: Double = 7.4
    var date: Date = Date()
    var cleaned: Bool = false
}
