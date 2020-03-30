import UIKit

//Boston Time
//var unixDate: TimeInterval = 1584384797
//Sydney Time
var unixDate: TimeInterval = 1584385015

let usableDate = Date(timeIntervalSince1970: unixDate)
print("GMT")
print(usableDate)

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .full
dateFormatter.timeStyle = .medium
var dateString = dateFormatter.string(from: usableDate)
print("My TimeZone (Boston)")
print(dateString)

//TimeZone.knownTimeZoneIdentifiers.forEach({print($0)})
let timeZone = TimeZone(identifier: "Australia/Sydney")
dateFormatter.timeZone = timeZone
dateString = dateFormatter.string(from: usableDate)
print("Australia/Sydney")
print(dateString)

//Wednesday, Mar 16, 2020
dateFormatter.dateFormat = " EEEE, MMM d"
dateString = dateFormatter.string(from: usableDate)
print("Australia/Sydney with date pattern")
print(dateString)
