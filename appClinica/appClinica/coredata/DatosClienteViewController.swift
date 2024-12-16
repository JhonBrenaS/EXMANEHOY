import UIKit

class DatosClienteViewController: UIViewController {

    @IBOutlet weak var txtCodigo: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtCredito: UITextField!
    //atributo de la estructura Cliente
    //var obj:Cliente!
    //atributo de ClienteEntity
    var obj:ClienteEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCodigo.text=String(obj.codigo)
        txtNombre.text=obj.nombre
        txtApellido.text=obj.apellido
        txtCredito.text=String(obj.credito)
    }
    
    @IBAction func btnModificar(_ sender: UIButton) {
        let nom=getNombre()
        let ape=getApellido()
        let cred=getCredito()
        //modificar valores del atributo obj
        obj.nombre=nom
        obj.apellido=ape
        obj.credito=cred
        let estado=ControladorCliente().update(bean: obj)
         if estado>0{
             getVentana("Cliente actualizado")
         }
         else
         {
             getVentana("Error en la actualizacion")
         }
        
        
    }
    @IBAction func btnEliminar(_ sender: UIButton) {
        let ventana=UIAlertController(title: "Sistema", message: "Seguro de eeliminar Cliente?", preferredStyle: .alert)
        let botonA=UIAlertAction(title: "SI", style: .default, handler: {
            x in
            var salida=ControladorCliente().delete(bean: self.obj)
            if salida>0{
                self.getVentana("Cliente eliminado")
            }
            else{
                self.getVentana("Error en la eliminacion")
            }
        })
        ventana.addAction(botonA)
        ventana.addAction(UIAlertAction(title: "NO", style: .cancel))
        
        present(ventana, animated: true)
    }
    @IBAction func btnVolver(_ sender: UIButton) {
        
    }
    func getNombre()->String{
        return txtNombre.text ?? ""
    }
    func getApellido()->String{
        return txtApellido.text ?? ""
    }
    func getCredito()->Double{
        return Double(txtCredito.text ?? "0") ?? 0
    }
    //funcion para crear ventana de mensaje
    func getVentana(_ msg:String){
        //crear ventana
        let ventana=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        //crear boton
        ventana.addAction(UIAlertAction(title: "Aceptar", style: .default))
        //mostrar ventana
        present(ventana, animated: true)
    }
}
