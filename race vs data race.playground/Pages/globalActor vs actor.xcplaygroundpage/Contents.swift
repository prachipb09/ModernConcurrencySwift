//    //: [Previous](@previous)
import SwiftUI

@globalActor final class BaseGlobalActor: Sendable {
    public static let shared = BaseActor()
    /// actors instance
}

actor BaseActor {
    private var balance = 0
    func updateBalance() -> Int {
        balance += 1
        return balance
    }
    
    func readBalance() -> Int {
        balance
    }
}

class Example {
    func performUpdate() {
        Task {
            await withTaskGroup(of: Void.self) { grp in
                grp.addTask {
                    let _ = await BaseGlobalActor.shared.updateBalance()
                }
                grp.addTask {
                    let _ = await BaseGlobalActor.shared.updateBalance()
                }
                await grp.waitForAll()
                print(await BaseGlobalActor.shared.readBalance()) // 2
            }
            
            let obj1 = BaseActor()
            async let call1 = obj1.updateBalance()
            
            let obj2 = BaseActor()
            async let call2 = obj2.updateBalance()
            
            await [call1, call2]
            print(await obj1.readBalance()) // 1
            print(await obj2.readBalance()) // 1
        }
    }
}

//Example().performUpdate()


    //: [Next](@next)

//@globalActor
//actor BaseActor {
//    private var balance = 0
//    
//    static let shared = BaseActor()
//    
//    func updateBalance() async throws -> Int {
//      //  print(Thread.current)
//        try? await Task.sleep(nanoseconds: 2_000_000_000)
//       balance += 1
//        return balance
//    }
//    
//    func readBalance() -> Int {
//        balance
//    }
//}
//
//class Example {
//    func performUpdate() {
//        Task {
//            await withTaskGroup(of: Void.self) { grp in
//                for i in (0..<1000) {
//                grp.addTask {
//                    let _ = try? await BaseActor.shared.updateBalance()
//                    }
//                }
//                await grp.waitForAll()
//                print(await BaseActor.shared.readBalance())
//            }
//        }
//    }
//}
//
//Example().performUpdate()

//actor Counter {
//    static var count = 0
//    
//    static func increment() {
//        count += 1
//    }
//}
//DispatchQueue.concurrentPerform(iterations: 1000) {_ in 
//    Counter.increment()
//}

//print(Counter.count)


