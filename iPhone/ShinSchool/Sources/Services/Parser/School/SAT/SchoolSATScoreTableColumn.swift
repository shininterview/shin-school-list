import Foundation

/// The SQL table column names for the school SAT score data.
/// See a sample response below:
/// https://data.cityofnewyork.us/resource/f9bf-2cp4.json?$$app_token=QIJIwfPSzqXgvFAURtmHNpbDw&$limit=1
enum SchoolSATScoreTableColumn {
  static let count = "num_of_sat_test_takers"
  static let databaseNumber = "dbn"
  static let mathScore = "sat_math_avg_score"
  static let readingScore = "sat_critical_reading_avg_score"
  static let writingScore = "sat_writing_avg_score"
}
