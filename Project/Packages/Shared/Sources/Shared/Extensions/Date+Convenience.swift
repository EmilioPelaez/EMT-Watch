//
//  Created by Emilio Peláez on 30/4/23.
//

import Foundation

public extension Date {
	
	var startOfDay: Date {
		Calendar.current.startOfDay(for: self)
	}
	
	func addingDays(_ days: Int) -> Date {
		guard let date = Calendar.current.date(byAdding: .day, value: days, to: self) else {
			preconditionFailure("Unable to create date...")
		}
		return date
	}
	
	var nextDay: Date {
		addingDays(1)
	}
	
	var previousDay: Date {
		addingDays(-1)
	}
	
	var previousSecond: Date {
		addingTimeInterval(-1)
	}
	
	var startOfMonth: Date {
		let components = Calendar.current.dateComponents([.year, .month], from: self)
		guard let date = Calendar.current.date(from: components) else {
			preconditionFailure("Unable to create date...")
		}
		return date
	}
	
	var previousMonth: Date {
		guard let date = Calendar.current.date(byAdding: .month, value: -1, to: self) else {
			preconditionFailure("Unable to create date...")
		}
		return date
	}
	
	var nextMonth: Date {
		guard let date = Calendar.current.date(byAdding: .month, value: 1, to: self) else {
			preconditionFailure("Unable to create date...")
		}
		return date
	}
	
	var daysInMonth: Int {
		(Calendar.current.dateComponents([.day], from: self, to: startOfMonth.nextMonth).day ?? 0) + 1
	}
	
	static var today: Date {
		Date().startOfDay
	}
	
	static var thisWeek: Date {
		Date().addingTimeInterval(-84600 * 7)
	}
	
	static var thisMonth: Date {
		Date().startOfMonth
	}
	
	static var nextMonth: Date {
		thisMonth.nextMonth
	}
	
}
