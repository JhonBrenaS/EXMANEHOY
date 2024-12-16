import UIKit
import Alamofire

class NuevoMedicamentoViewController: UIViewController {

    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtStock: UITextField!
    
    @IBOutlet weak var txtPrecio: UITextField!
    
    @IBOutlet weak var btnGrabar: UIButton!
    
    @IBOutlet weak var btnVolver: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnGrabar.layer.cornerRadius = 10
        btnVolver.layer.cornerRadius = 10
        
    }
    
    @IBAction func btnGrabar(_ sender: UIButton) {
        let nom=getNombre()
        let pre=getPrecio()
        let sto=getStock()
        let obj=Medicamento(codigo:0,nombre:nom,precio:pre,stock:sto)
        grabarMedicamento(bean: obj)
    }
    
    @IBAction func btnVolver(_ sender: UIButton) {
        performSegue(withIdentifier: "nuevoMedicamento2", sender: nil)
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
        ventana.addAction(UIAlertAction(title: "Aceptar", style: .default,handler: {_ in self.performSegue(withIdentifier: "nuevoMedicamento2", sender: nil)}))
        //mostrar ventana
        present(ventana, animated: true)
    }
    func grabarMedicamento(bean: Medicamento){
        AF.request("https://sistema-s2o0.onrender.com/medicamento/registrar",method: .post,parameters: bean,encoder: JSONParameterEncoder.default).response(completionHandler: {
            data in
            
            //validacion de datos
            switch data.result{
            case .success(let info):
                do{
                    //deserializar
                    let med = try JSONDecoder().decode(Medicamento.self, from: info!)
                    self.getVentana("Medicamento Registrado con ID :" + String(med.codigo))
                }catch{
                    self.getVentana("Error en el JSON")
                }
                
            case .failure(let error):
                   self.getVentana(error.localizedDescription)
            }
        })
    }
    
}
