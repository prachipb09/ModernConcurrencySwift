import Foundation

class Owner {
    var name: String
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Asset {
    weak var temporaryOwner: Owner? // Weak: Optional, can become nil
    unowned let permanentOwner: Owner // Unowned: Non-optional, must always exist
    
    init(temporaryOwner: Owner?, permanentOwner: Owner) {
        self.temporaryOwner = temporaryOwner
        self.permanentOwner = permanentOwner
    }
    
    deinit {
        print("Asset is being deinitialized")
    }
}

    // Example
var permanentOwner: Owner? = Owner(name: "Permanent")
var temporaryOwner: Owner? = Owner(name: "Temporary")

var asset: Asset? = Asset(temporaryOwner: temporaryOwner, permanentOwner: permanentOwner!)

    // Deallocate the temporary owner
temporaryOwner = nil // No issue, as it's weak
print(asset?.temporaryOwner) // Output: nil

    // Deallocate the permanent owner
permanentOwner = nil // ⚠️ If accessed, will crash because of unowned

