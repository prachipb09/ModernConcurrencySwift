import Foundation


actor BankAccountActor {
    var balance: Int
    
    init(balance: Int) {
        self.balance = balance
    }
    
    func transfer(amount: Int,
                  to toAccount: BankAccountActor) async -> Bool {
        guard balance >= amount else {
            return false
        }
        balance -= amount
        await toAccount.deposit(amount: amount)
        
        return true
    }
    
    private func deposit(amount: Int) {
        balance = balance + amount
    }
}

let bankAccountOne = BankAccountActor(balance: 100)
let bankAccountTwo = BankAccountActor(balance: 100)

final class BankActor: Sendable {
    func transfer(amount: Int,
                  from fromAccount: BankAccountActor,
                  to toAccount: BankAccountActor) async -> Bool {
        await fromAccount.transfer(amount: amount, to: toAccount)
    }
}

let bank = BankActor()
Task {
    async let call1 = bank.transfer(amount: 70, from: bankAccountOne, to: bankAccountTwo)
    async let call2 = bank.transfer(amount: 50, from: bankAccountOne, to: bankAccountTwo)
    let data = await [call1, call2]
    
    await print(bankAccountOne.balance)
    await print(bankAccountTwo.balance)
}









