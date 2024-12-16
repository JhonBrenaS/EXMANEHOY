
import UIKit

class ControladorCliente:PMetodos {
    
    func save(bean: Cliente) -> Int {
        var salida = -1
        //1. crear objeto de la clase AppDelegate
        let delegate=UIApplication.shared.delegate as! AppDelegate
        //2. acceder a la variable persistentContainer "conexion con la BD"
        let contextoBD=delegate.persistentContainer.viewContext
        //3. acceder a la entidad
        let tabla=ClienteEntity(context: contextoBD)
        //4. setear los atributos del parametro bean a la "tabla"
        tabla.codigo=Int16(bean.codigo)
        tabla.nombre=bean.nombre
        tabla.apellido=bean.apellido
        tabla.credito=bean.credito
        //5. controlar exception
        do{
            //6. grabar
            try contextoBD.save()
            salida=1
        }catch let ex as NSError{
            print(ex.localizedDescription)
        }
        return salida
    }
    func findAll() -> [ClienteEntity] {
        //declarar
        var datos:[ClienteEntity]!
        //1. crear objeto de la clase AppDelegate
        let delegate=UIApplication.shared.delegate as! AppDelegate
        //2. acceder a la variable persistentContainer "conexion con la BD"
        let contextoBD=delegate.persistentContainer.viewContext
        //3. obtener contenido de la entidad "ClienteEntity"
        let registros=ClienteEntity.fetchRequest()
        //4. controlar exception
        do{
            //5. recorrido sobre "registros" y guardar la informacion
            //dentro de datos
            try datos=contextoBD.fetch(registros)
        }catch let ex as NSError{
            print(ex.localizedDescription)
        }
        return datos
    }
    func update(bean: ClienteEntity) -> Int {
        var salida = -1
        //1. crear objeto de la clase AppDelegate
        let delegate=UIApplication.shared.delegate as! AppDelegate
        //2. acceder a la variable persistentContainer "conexion con la BD"
        let contextoBD=delegate.persistentContainer.viewContext
        //3. controlar exception
        do{
            //4. grabar
            try contextoBD.save()
            salida=1
        }catch let ex as NSError{
            print(ex.localizedDescription)
        }
        return salida
    }
    func delete(bean: ClienteEntity) -> Int {
        var salida = -1
        //1. crear objeto de la clase AppDelegate
        let delegate=UIApplication.shared.delegate as! AppDelegate
        //2. acceder a la variable persistentContainer "conexion con la BD"
        let contextoBD=delegate.persistentContainer.viewContext
        //3. controlar exception
        do{
            //4. eliminar
            contextoBD.delete(bean)
            //5. grabar
            try contextoBD.save()
            salida=1
        }catch let ex as NSError{
            print(ex.localizedDescription)
        }
        return salida
        
    }
    
   
}
