/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class DatabaseFixtureTest: BaseTestCase {

    let url = top5000SitesList()

    func testDatabaseFixture() {
        let file = "testDatabaseFixture-browser.db"
        let arg = LaunchArguments.LoadDatabasePrefix + file
        app.terminate()
        restart(app, args: [LaunchArguments.SkipIntro, LaunchArguments.SkipWhatsNew, arg])

        // app will now start with prepopulated database

        navigator.browserPerformAction(.openBookMarksOption)
        let list = app.tables["Bookmarks List"].cells.count
        XCTAssertEqual(list, 1, "There should be an entry in the bookmarks list")
    }

    // This two tests should be disabled. They are only meant to generate the browserDB or check how all web sites are presented
    func testLoadAllSites() {
        for index in url.top5000SitesList.indices {
            navigator.openURL(url.top5000SitesList[index])
        }
    }

    func testLoadNumberOfSites() {
        // For example to navigate to the 100 first top sites. This can be changed as per needs
        let n = 2
        let urlSlice = url.top5000SitesList.prefix(n)

        for index in urlSlice.indices {
            navigator.openURL(urlSlice[index])
        }
    }
}
