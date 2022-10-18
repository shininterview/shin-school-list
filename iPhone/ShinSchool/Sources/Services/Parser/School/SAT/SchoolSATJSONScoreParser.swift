import Foundation

/// Helper class for parsing the school SAT score data from the API response.
/// See a sample response below to see the available properties:
/// https://data.cityofnewyork.us/resource/f9bf-2cp4.json?$$app_token=QIJIwfPSzqXgvFAURtmHNpbDw&$limit=1
public class SchoolSATJSONScoreParser {
  public static func schoolSATScoreFromDictionary(_ dictionary: [String: AnyObject])
    -> SchoolSATScore?
  {
    guard let countString = dictionary[SchoolSATScoreTableColumn.count] as? String else {
      return nil
    }
    guard let count = Int(countString) else {
      return nil
    }
    guard let mathScoreString = dictionary[SchoolSATScoreTableColumn.mathScore] as? String else {
      return nil
    }
    guard let mathScore = Int(mathScoreString) else {
      return nil
    }
    guard let readingScoreString = dictionary[SchoolSATScoreTableColumn.readingScore] as? String
    else {
      return nil
    }
    guard let readingScore = Int(readingScoreString) else {
      return nil
    }
    guard let writingScoreString = dictionary[SchoolSATScoreTableColumn.writingScore] as? String
    else {
      return nil
    }
    guard let writingScore = Int(writingScoreString) else {
      return nil
    }

    return SchoolSATScore(
      count: count, mathScore: mathScore, readingScore: readingScore, writingScore: writingScore)
  }
}
