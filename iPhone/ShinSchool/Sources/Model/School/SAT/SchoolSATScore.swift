import Foundation

/// The model for the school SAT score data.
/// See a sample response below:
/// https://data.cityofnewyork.us/resource/f9bf-2cp4.json?$$app_token=QIJIwfPSzqXgvFAURtmHNpbDw&$limit=1
public class SchoolSATScore {
  let count: Int
  let mathScore: Int
  let readingScore: Int
  let writingScore: Int

  init(count: Int, mathScore: Int, readingScore: Int, writingScore: Int) {
    self.count = count
    self.mathScore = mathScore
    self.readingScore = readingScore
    self.writingScore = writingScore
  }
}
