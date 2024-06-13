// ukazka paralelismu

let id = "1234"
let dispatchGroup = DispatchGroup()

func startFetch() {
    // ukaz loader
    loader.show()
    
    // zacne task1
    // vedlejsi vlakna
    dispatchGroup.enter()
    fetchUserProfileDetails(id: id) {
        // konci task1
        dispatchGroup.leave()
    }
    
    // zacne dalsi ukoly
    // neceka na dokonceni task1
    dispatchGroup.enter()
    fetchUserPublicDetails(id: id) {
        // konec task2
        dispatchGroup.leave()
    }
    
    // zavola se po dokonceni vsech ukolu
    // hlavni vlakno
    dispatchGroup.notify(queue: .main) {
        print("Hotovo!")
        // skryje loader
        loader.hide()
    }
}
