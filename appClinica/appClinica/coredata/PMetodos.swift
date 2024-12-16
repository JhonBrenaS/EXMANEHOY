import UIKit

protocol PMetodos {
    func save(bean:Cliente)->Int
    func findAll()->[ClienteEntity]
    func update(bean:ClienteEntity)->Int
    func delete(bean:ClienteEntity)->Int
}
