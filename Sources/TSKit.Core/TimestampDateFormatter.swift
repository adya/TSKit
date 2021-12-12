import Foundation

open class TimestampDateFormatter: DateFormatter {
    
    /// Number of days before `today` for which formatter should do relative formatting.
    /// Dates older than this number of days will be formatted as dates only, without time.
    public var relativeDays: Int = 7
    
    /// Flag indicating whether formatter should display time of day when doing relative formatting.
    public var useTimeOfDay: Bool = false
    
    /// Flag indicating whether formatter should display only time for current day.
    public var hideToday: Bool = true
    
    public override init() {
        super.init()
        dateStyle = .short
        timeStyle = .short
        doesRelativeDateFormatting = true
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        dateStyle = .short
        timeStyle = .short
        doesRelativeDateFormatting = true
    }
    
    open override func string(from date: Date) -> String {
        self.timeStyle = useTimeOfDay ? .short : .none
        if Calendar.current.isDateInToday(date) {
            self.dateStyle = hideToday ? .none : .short
        } else {
            let daysSince = Calendar.current.dateComponents([.day],
                                                            from: date,
                                                            to: Date()).day ?? 0
            let shouldDoRelativeFormatting = daysSince < relativeDays && daysSince > -relativeDays // for future dates
            self.doesRelativeDateFormatting = shouldDoRelativeFormatting
            self.dateStyle = .short
            
            if !shouldDoRelativeFormatting {
                self.timeStyle = .none
            }
        }
        return super.string(from: date)
    }
}

