import SwiftData

public final class MMMDataModel<T: PersistentModel> {
    public init() {}

    @MainActor
    public var all: [T] {
        let context = MMMDataModelConfiguration.container
        let fetchDescriptor = FetchDescriptor<T>()
        let models = try? context.mainContext.fetch(fetchDescriptor)
        return models ?? []
    }

    @MainActor
    public var first: T? {
        let context = MMMDataModelConfiguration.container
        let fetchDescriptor = FetchDescriptor<T>()
        let model = try? context.mainContext.fetch(fetchDescriptor).first
        return model
    }

    @MainActor
    public func upsert(model: T) {
        let context = MMMDataModelConfiguration.container
        context.mainContext.insert(model)
        try? context.mainContext.save()
    }
}
