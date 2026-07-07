import XCTest
@testable import PoolwatchLog

final class PoolwatchLogTests: XCTestCase {
    var store: Store!

    override func setUp() {
        super.setUp()
        store = Store()
        store.items = []
        store.save()
    }

    func testAddIncreasesCount() {
        let before = store.items.count
        _ = store.add(PoolReading())
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testAddRespectsFreeLimit() {
        store.isPro = false
        store.items = []
        for _ in 0..<Store.freeLimit {
            _ = store.add(PoolReading())
        }
        XCTAssertEqual(store.items.count, Store.freeLimit)
        let result = store.add(PoolReading())
        XCTAssertFalse(result)
        XCTAssertEqual(store.items.count, Store.freeLimit)
    }

    func testProBypassesLimit() {
        store.isPro = true
        store.items = []
        for _ in 0..<(Store.freeLimit + 3) {
            _ = store.add(PoolReading())
        }
        XCTAssertEqual(store.items.count, Store.freeLimit + 3)
    }

    func testDeleteAtOffsets() {
        _ = store.add(PoolReading())
        _ = store.add(PoolReading())
        let before = store.items.count
        store.delete(at: IndexSet(integer: 0))
        XCTAssertEqual(store.items.count, before - 1)
    }

    func testDeleteSpecificItem() {
        _ = store.add(PoolReading())
        guard let item = store.items.first else { return XCTFail("no item") }
        store.delete(item)
        XCTAssertFalse(store.items.contains(where: { $0.id == item.id }))
    }

    func testCanAddMoreWhenUnderLimit() {
        store.isPro = false
        store.items = []
        XCTAssertTrue(store.canAddMore)
    }

    func testUpdatePersistsChange() {
        _ = store.add(PoolReading())
        guard let item = store.items.first else { return XCTFail("no item") }
        store.update(item)
        XCTAssertEqual(store.items.first?.id, item.id)
    }

    func testPersistenceReload() {
        store.items = []
        _ = store.add(PoolReading())
        let reloaded = Store()
        reloaded.load()
        XCTAssertFalse(reloaded.items.isEmpty)
    }
}
