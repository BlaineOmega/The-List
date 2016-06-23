import CloudKit

extension CKRecord {
    @nonobjc subscript(key: String) -> AnyObject! {
        get {
            return self.objectForKey(key)
        }
        set(newValue) {
            self.setObject(newValue as? CKRecordValue, forKey: key)
        }
    }
}