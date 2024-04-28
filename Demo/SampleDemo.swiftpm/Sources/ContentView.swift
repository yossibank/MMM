import Sample
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(.information)
                .resizable()
                .frame(width: 40, height: 40)
            Text(SampleClass().sample())
        }
    }
}
