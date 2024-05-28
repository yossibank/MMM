import SwiftData
import SwiftUI
import TabScreen

@main
struct MMMApp: App {
    init() {
        Appearance.configure()
    }

    var body: some Scene {
        WindowGroup {
            TabScreen()
        }
        .modelContainer(sharedModelContainer)
    }

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
