import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    private let contactKey = "contacts"
    
    func saveContact(_ contact: String) {
        var contacts = fetchContacts()
        contacts.append(contact)
        userDefaults.set(contacts, forKey: contactKey)
    }
    
    func fetchContacts() -> [String] {
        if let contacts = userDefaults.value(forKey: contactKey) as? [String] {
            return contacts
        }
        return []
    }
    
    func deleteContact(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        userDefaults.set(contacts, forKey: contactKey)
    }
}
