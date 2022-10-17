import XCTest

@testable import ShinSchool

/// Verifies if we can parse the schol JSON correctly.
class SchoolJSONParserUnitTests: XCTestCase {

  enum Constants {
    static let JSONFileName = "SchoolJSON"
    static let JSONFileType = "json"
  }

  func testExample() throws {
    guard let JSONObjectArray = schoolJSONString() else {
      XCTAssert(false, "Failed to parse the JSON data.")
      return
    }

    let schools = SchoolJSONParser.schoolsFromJSONArray(JSONObjectArray)
    XCTAssertEqual(schools.count, 1)
    guard let school = schools.first else {
      XCTAssert(false, "Expect to have one school object.")
      return
    }
    XCTAssertEqual(school.name, "Clinton School Writers & Artists, M.S. 260")
  }

  func schoolJSONString() -> [[String: AnyObject]]? {
    let bundle = Bundle(for: type(of: self))
    guard
      let path = bundle.path(
        forResource: Constants.JSONFileName, ofType: Constants.JSONFileType)
    else {
      return nil
    }

    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let JSONObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
      if let array = JSONObject as? [[String: AnyObject]] {
        return array
      }
    } catch {
      XCTAssert(false, "Failed to parse the JSON data.")
    }

    return nil
  }
}
