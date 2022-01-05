// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

public class TagLogInterceptor: AnyLogInterceptor {

    var ignoredTags: Set<String>

    public init(ignoredTags: Any?...) {
        self.ignoredTags = Set(ignoredTags.compactMap(objectTag))
    }

    public func shouldLog(_ entry: LogEntry) -> Bool {
        return ignoredTags.intersection(entry.tags).isEmpty
    }
}
