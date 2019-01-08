# OSLog Framework

The `OSLog` framework provides convenience wrappers around the native `OSLog` facilities provided by Apple.

The framework provides logging functionality via the `Log` class. There is one function per each log level:

- `Log.msg` sends a default-level log message.
- `Log.debug` sends a debug-level log message.
- `Log.info` sends an info-level log message.
- `Log.error` sends an error-level log message.
- `Log.fault` sends a fault-level log message.

There is a static `Log` instance called `default`. This corresponds to the `OSLog.default` object provided by the system. There are static logging functions on the `Log` class that invoke the corresponding methods on `Log.default` object.

See Apple's documentation for `OSLog` for a description of the various log levels and their uses.

Client applications can provide their own instances of the `Log` class, specifying a custom subsystem name (in reverse DNS notation) and log category. `Log` instances can be initialized with a custom `LogFormatter` which is used to produce the string that is sent to the log. Context information relating to the source file, line of code, and source function are all provided to the `LogFormatter` instance.

Each `Log` instance can be enabled or disabled. `Log` instances are disabled by default. The various `Log` functions use the `@autoclosure` construct for evaluating the message to be logged. Thus if a `Log` instance is disabled, its messages are not evaluated. This eliminates any overhead that would be incurred by performing otherwise unnecessary string expansion.

Client applications can provide an extension to the `Log` class defining static `Log` instances for each subsystem and category. For example:

```swift
import OSLog

extension Log {
    private static let subsystem = "com.example.ExampleApp"

    static let ui = Log(subsystem: subsystem, category: "ui")
    static let network = Log(subsystem: subsystem, category: "network")
}
```

The app can then use these loggers as follows:

```swift
Log.ui.info("This is an info log message")

Log.network.isEnabled = false
Log.network.debug("This message will not appear as the logger is disabled")
```

