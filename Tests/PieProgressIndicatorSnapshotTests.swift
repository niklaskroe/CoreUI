import XCTest
import SwiftUI
import SnapshotTesting
@testable import CoreUI

@MainActor
final class PieProgressIndicatorSnapshotTests: XCTestCase {
    
    func testPieProgressIndicator_atVariousStates() {
        // 25% progress
        let quarterView = PieProgressIndicatorView(progress: 0.25, themeColor: .blue)
        assertSnapshot(
            of: quarterView,
            as: .image(layout: .fixed(width: 100, height: 100)),
            named: "25_Percent"
        )
        
        // 100% progress
        let fullView = PieProgressIndicatorView(progress: 1.0, themeColor: .green)
        assertSnapshot(
            of: fullView,
            as: .image(layout: .fixed(width: 100, height: 100)),
            named: "100_Percent"
        )
    }
}
