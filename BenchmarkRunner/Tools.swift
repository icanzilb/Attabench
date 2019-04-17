// Copyright © 2017 Károly Lőrentey.
// This file is part of Attabench: https://github.com/attaswift/Attabench
// For licensing information, see the file LICENSE.md in the Git repository above.

import Foundation

extension String {
    init(posixError: Int32) {
        var c = 256
        var p = UnsafeMutablePointer<Int8>.allocate(capacity: c)
        loop: while true {
            switch strerror_r(posixError, p, c) {
            case 0, EINVAL:
                break loop
            case ERANGE:
                p.deallocate()
                c *= 2
                p = .allocate(capacity: c)
            default:
                preconditionFailure("Unexpected return value from strerror_r")
            }
        }
        self = String(cString: p)
        p.deallocate()
    }

    init(signal: Int32) {
        self.init(cString: strsignal(signal))
    }
}

