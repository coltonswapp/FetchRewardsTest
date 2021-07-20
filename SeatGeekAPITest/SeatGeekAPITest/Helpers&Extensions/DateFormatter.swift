//
//  DateFormatter.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/19/21.
//

import Foundation

extension String {
    
    func formatDate(_ dateString: String) -> String {

        let dateFormatterIN = DateFormatter()
        dateFormatterIN.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatterIN.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterOUT = DateFormatter()
        dateFormatterOUT.dateFormat = "MMM d, yyyy - h:mma"
        return dateFormatterOUT.string(from: dateFormatterIN.date(from: dateString) ?? Date())
    }
}

extension Date {
    func formatToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        
        return formatter.string(from: self)
    }
}
