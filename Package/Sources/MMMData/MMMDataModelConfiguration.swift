import SwiftData

public enum MMMDataModelConfiguration {
    public static let container: ModelContainer = {
        let schema = Schema([
            ColorThemeModel.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
}
