@testable import MacToastKit
import SwiftUI
import Testing

@MainActor
@Suite(.serialized)
struct MacToastKitTests {
    // MARK: MacToastKit - Simple

    let toast = ToastWindowController()

    @Test("Toast - Minimal default")
    func toastSimple() async throws {
        toast.showToast(
            message: "This is the default style.",
            icon: Image(systemName: "party.popper"),
            duration: 3,
            position: .bottomCenter(100)
        )

        try await Task.sleep(for: .seconds(3))
    }

    @Test("Toast - SF Symbols")
    func toastSymbols() async throws {
        toast.showToast(
            message: "SF Symbols look great!",
            icon: Image(systemName: "checkmark.circle.fill"),
            duration: 3,
            position: .center
        )

        try await Task.sleep(for: .seconds(3))
    }

    @Test("Toast - Custom Positioning")
    func toastPosition() async throws {
        toast.showToast(
            message: "You can change the position too!",
            icon: Image(systemName: "location"),
            duration: 3,
            position: .topLeft(0)
        )

        try await Task.sleep(for: .seconds(3))
    }

    @Test("Toast -  Click to Dimiss")
    func toastDismiss() async throws {
        toast.showToast(
            message: "Click to dismiss Me!",
            icon: Image(systemName: "cursorarrow.click"),
            duration: 3,
            position: .center
        )

        try await Task.sleep(for: .seconds(3))
    }

    @Test("Toast - Custom Durations")
    func toastDuration() async throws {
        toast.showToast(
            message: "Increase the Duration!",
            icon: Image(systemName: "timer"),
            duration: 7,
            position: .topRight(12)
        )

        try await Task.sleep(for: .seconds(7))
    }

    // MARK: Real Examples

    @Test("Toast -  Toggle Light Theme")
    func toastLightMode() async throws {
        toast.showToast(
            message: "Toggled Light Mode",
            icon: Image(systemName: "sun.max.fill"),
            duration: 3,
            position: .bottomRight(50)
        )

        try await Task.sleep(for: .seconds(3))
    }

    @Test("Toast -  Airpods Connected")
    func toastAirpods() async throws {
        toast.showToast(
            message: "Airpods Max Connected",
            icon: Image(systemName: "airpodsmax"),
            duration: 3,
            position: .topCenter(15)
        )

        try await Task.sleep(for: .seconds(3))
    }

    @Test("Toast -  Caffeinate your Mac")
    func toastCaffeinate() async throws {
        toast.showToast(
            message: "Caffeinate Turned On",
            icon: Image(systemName: "powerplug.fill"),
            duration: 3,
            position: .bottomCenter(100)
        )

        try await Task.sleep(for: .seconds(3))
    }
}
