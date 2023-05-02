import SwiftUI
import Shimmer

struct ListItem: Identifiable {
    var id: Int
    var iconName: String
    var title: String
    var text: String
}

struct ContentView: View {
    @State private var isLoading = false
    
    let items = Array(0..<20).map {
        ListItem(id: $0,
                 iconName: "heart",
                 title: "\($0+1)",
                 text: "List item\($0+1)")
    }
    
    var body: some View {
        List {
            ForEach(items) { item in
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.title)
                            .foregroundColor(isLoading ? .blue : .white)
                            .font(.system(size: 12))
                            .frame(minWidth: 20)
                            .padding(2)
                            .background(.blue)
                            .cornerRadius(4)
                        
                        Text(item.text)
                    }
                    
                    Spacer()
                    
                    Image(systemName: item.iconName)
                }
                // isLoading中にプレースホルダーを表示する (Skeleton)
                .redacted(reason: isLoading ? .placeholder : [])
                // シマーアニメーションを適用
                .shimmering(active: isLoading)
            }
        }
        .listStyle(.plain)
        
        .task {
            isLoading = true
            defer { isLoading = false }
            try? await Task.sleep(for: .seconds(5))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
