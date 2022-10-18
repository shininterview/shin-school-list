import Foundation

/// Helper class for parsing the school SAT score data from the API response.
/// See a sample response below to see the available properties:
/// https://data.cityofnewyork.us/resource/f9bf-2cp4.json?$$app_token=QIJIwfPSzqXgvFAURtmHNpbDw&$limit=1
public class SchoolSATJSONScoreParser {
  public static func schoolSATScoreFromDictionary(_ dictionary: [String: AnyObject]) -> SchoolSATScore? {
    guard let count = dictionary[SchoolSATScoreTableColumn.count] as? Int else {
      return nil
    }
    guard let mathScore = dictionary[SchoolSATScoreTableColumn.mathScore] as? Int else {
      return nil
    }
    guard let readingScore = dictionary[SchoolSATScoreTableColumn.readingScore] as? Int else {
      return nil
    }
    guard let writingScore = dictionary[SchoolSATScoreTableColumn.writingScore] as? Int else {
      return nil
    }

    return SchoolSATScore(count: count, mathScore: mathScore, readingScore: readingScore, writingScore: writingScore)
  }
}
