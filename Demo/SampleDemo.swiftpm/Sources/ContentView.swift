import SwiftUI
import Sample

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(SampleClass.test1)
        }
    }
}
