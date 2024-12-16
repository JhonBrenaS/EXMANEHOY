import UIKit
import Alamofire

class DatosMedicamentoViewController: UIViewController {

    @IBOutlet weak var txtCodigo: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtStock: UITextField!
    @IBOutlet weak var txtPrecio: UITextField!
    @IBOutlet weak var btnModificar: UIButton!
    @IBOutlet weak var btnEliminar: UIButton!
    @IBOutlet weak var btnVolver: UIButton!
    var obj: Medicamento!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnModificar.layer.cornerRadius = 10
        btnEliminar.layer.cornerRadius = 10
        btnVolver.layer.cornerRadius = 10
        
        txtCodigo.text = String(obj.codigo)
        txtNombre.text = obj.nombre
        txtPrecio.text = String(obj.precio)
        txtStock.text = String(obj.stock)
    }
    
    @IBAction func btnModificar(_ sender: UIButton) {
        let nom=getNombre()
        let pre=getPrecio()
        let sto=getStock()
        obj.nombre = nom
        obj.precio = pre
        obj.stock = sto
        modificarMedicamento(bean: obj)
    }
    
    @IBAction func btnEliminar(_ sender: UIButton) {
        let ventana=UIAlertController(title: "Sistema", message: "Seguro de eliminar Medicamento?", preferredStyle: .alert)
        let botonA=UIAlertAction(title: "SI", style: .default, handler: {
            x in
            self.eliminarMedicamento(cod: Int(self.txtCodigo.text ?? "0") ?? 0)
        })
        ventana.addAction(botonA)
        ventana.addAction(UIAlertAction(title: "NO", style: .cancel))
        
        present(ventana, animated: true)
    }
    
    
    @IBAction func btnVovler(_ sender: UIButton) {
        performSegue(withIdentifier: "datosMedicamento2", sender: nil)
    }

    func getNombre()->String{
        return txtNombre.text ?? ""
    }
    func getStock()->Int{
        return Int(txtStock.text ?? "0") ?? 0
    }
    func getPrecio()->Double{
        return Double(txtPrecio.text ?? "0") ?? 0
    }
    //funcion para crear ventana de mensaje
    func getVentana(_ msg:String){
        //crear ventana
        let ventana=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
        //crear boton
        ventana.addAction(UIAlertAction(title: "Aceptar", style: .default,handler: {_ in self.performSegue(withIdentifier: "datosMedicamento2", sender: nil)}))
        //mostrar ventana
        present(ventana, animated: true)
    }
    
    func modificarMedicamento(bean: Medicamento){
        AF.request("https://sistema-s2o0.onrender.com/medicamento/actualizar",method: .put, parameters: bean,encoder: JSONParameterEncoder.default).response(completionHandler: {
            data in
            
            //validacion de datos
            switch data.result{
            case .success:
                self.getVentana("Medicamento actualizado")
            case .failure(let error):
                self.getVentana(error.localizedDescription)
            }
        })
    }
    
    func eliminarMedicamento(cod: Int){
        AF.request("https://sistema-s2o0.onrender.com/medicamento/eliminar/"+String(cod),method: .delete).response(completionHandler: {
            data in
            
            //validacion de datos
            switch data.result{
            case .success:
                self.getVentana("Medicamento eliminado")
            case .failure(let error):
                self.getVentana(error.localizedDescription)
            }
        })
    }
}
