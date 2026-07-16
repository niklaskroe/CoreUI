import SwiftUI

public struct CheckboxStyle: ToggleStyle {
    public var checkedColor: Color = .blue
    public var uncheckedColor: Color = .gray.opacity(0.5)
    
    public init(checkedColor: Color, uncheckedColor: Color) {
        self.checkedColor = checkedColor
        self.uncheckedColor = uncheckedColor
    }

    public func makeBody(configuration: Configuration) -> some View {
        Button {
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
