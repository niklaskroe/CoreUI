import SwiftUI

struct ExpandingIconInput: View {
    @State private var isExpanded = false
    @State private var text = ""
    @FocusState private var isFocused: Bool
    
    let iconName: String
    let iconColor: Color
    let placeholderText: String
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                    isExpanded.toggle()
                    
                    // clear when collapsing
                    if !isExpanded { text = "" }
                }
                // automatically bring up the keyboard when expanded
                isExpanded ? (isFocused = true) : (isFocused = false)
            } label: {
                Image(systemName: iconName)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(iconColor)
                    .frame(width: 50, height: 50)
            }
            
            if isExpanded {
                TextField(placeholderText, text: $text)
                    .focused($isFocused)
                    .padding(.trailing, 16)
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
        .background(
            Capsule()
                .fill(Color.gray.opacity(0.15))
        )
        .frame(maxWidth: isExpanded ? 300 : 50, alignment: .leading)
        .clipped()
        .onChange(of: isFocused) { _, isNowFocused in
            if !isNowFocused && isExpanded {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                    isExpanded = false
                    text = ""
                }
            }
        }
    }
}

#Preview {
    ExpandingIconInput(iconName: "calendar", iconColor: .primary, placeholderText: "Wann")
}
