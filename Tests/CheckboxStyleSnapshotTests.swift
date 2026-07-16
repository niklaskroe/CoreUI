import XCTest
import SwiftUI
import SnapshotTesting
@testable import CoreUI
#if os(macOS)
import AppKit
#endif

@MainActor
final class CheckboxStyleSnapshotTests: XCTestCase {
    private func assertCheckboxSnapshot(
        _ view: some View,
        named name: String,
        file: StaticString = #filePath,
        testName: String = #function,
        line: UInt = #line
    ) {
        #if os(macOS)
        let host = NSHostingView(rootView: view)
        host.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        assertSnapshot(of: host, as: .image(precision: 0.99, perceptualPrecision: 0.98), named: "mac_\(name)", file: file, testName: testName, line: line)
        #else
        assertSnapshot(
            of: view,
            as: .image(precision: 0.95, perceptualPrecision: 0.95, layout: .fixed(width: 200, height: 50)),
            named: name,
            file: file,
            testName: testName,
            line: line
        )
        #endif
    }
    
    func testCheckboxStyle_atVariousStates() {
        let uncheckedView = Toggle("Buy groceries", isOn: .constant(false))
            .toggleStyle(CheckboxStyle(checkedColor: Color(red: 0.5, green: 0.5, blue: 1.0), uncheckedColor: Color(red: 1.0, green: 0.5, blue: 0.5)))
        
        assertCheckboxSnapshot(uncheckedView.environment(\.colorScheme, .light), named: "unchecked_light")
        assertCheckboxSnapshot(uncheckedView.environment(\.colorScheme, .dark), named: "unchecked_dark")
        
        let checkedView = Toggle("Clean room", isOn: .constant(true))
            .toggleStyle(CheckboxStyle(checkedColor: Color(red: 1.0, green: 0.5, blue: 0.5), uncheckedColor: Color(red: 0.5, green: 0.5, blue: 1.0)))
        
        assertCheckboxSnapshot(checkedView.environment(\.colorScheme, .light), named: "checked_light")
        assertCheckboxSnapshot(checkedView.environment(\.colorScheme, .dark), named: "checked_dark")
    }
}

