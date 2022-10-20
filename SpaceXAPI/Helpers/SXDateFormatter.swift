//
//  SXDateFormatter.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/19/22.
//

import Foundation

/// DateFormatter subclass for custom formatting of date strings
class SXDateFormatter : DateFormatter {
    
    enum DateFormat : String {
        case UTC = "yyyy-MM-dd'T'HH:mm:ssZ"
        case HumanReadable = "MMM d, yyyy"
    }
    /// DateFormatters hash to memoize the creation of expensive DateFormatters
    private static var CachedFormatters = [String : SXDateFormatter]()
    
    static func MakeHumanReadableDateString(_ dateString: String) -> String {
        if
            let cachedUTCFormatter = CachedFormatters[DateFormat.UTC.rawValue],
            let cachedHumanFormatter = CachedFormatters[DateFormat.HumanReadable.rawValue]
        {
            let formmattedDate = FormatDate(dateString, cachedUTCFormatter, cachedHumanFormatter)
            return formmattedDate
        }
        let utcDateFormatter = SXDateFormatter()
        utcDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let utcFormat = DateFormat.UTC.rawValue
        utcDateFormatter.dateFormat = utcFormat
        CachedFormatters[utcFormat] = utcDateFormatter
        let humanDateFormatter = SXDateFormatter()
        let humanFormat = DateFormat.HumanReadable.rawValue
        humanDateFormatter.dateFormat = humanFormat
        CachedFormatters[humanFormat] = humanDateFormatter
        
        let formattedDate = FormatDate(dateString, CachedFormatters[utcFormat]!, CachedFormatters[humanFormat]!)
        
        return formattedDate
    }
    
    static func FormatDate(
        _ dateString: String,
        _ inputFormatter: SXDateFormatter,
        _ outputFormatter: SXDateFormatter) -> String
    {
        guard let date = inputFormatter.date(from: dateString) else { return dateString }
        let dateString = outputFormatter.string(from: date)
        return dateString
    }
}
