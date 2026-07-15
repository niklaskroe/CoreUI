import SwiftUI

public struct CheckboxStyle: ToggleStyle {
    public var checkedColor: Color = .blue
    public var uncheckedColor: Color = .gray.opacity(0.5)

    public func makeBody(configuration: Configuration) -> some View {
        Button {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
            
            configuration.isOn.toggle()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(configuration.isOn ? checkedColor : uncheckedColor)
                    .contentTransition(.symbolEffect(.replace.downUp))
                    .symbolEffect(.bounce, value: configuration.isOn)

                configuration.label
                    .foregroundStyle(.primary)
            }
        }
        .buttonStyle(.plain)
    }
}
