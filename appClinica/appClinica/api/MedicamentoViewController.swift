import UIKit
import Alamofire

class MedicamentoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   

    @IBOutlet weak var tvMedicamentos: UITableView!
    @IBOutlet weak var btnNuevo: UIButton!
   
    var lista:[Medicamento] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnNuevo.layer.cornerRadius = 10
        listado()
        tvMedicamentos.dataSource = self
        tvMedicamentos.delegate = self
        tvMedicamentos.rowHeight = 200
    }
    
    @IBAction func btnNuevo(_ sender: UIButton) {
        performSegue(withIdentifier: "nuevoMedicamento", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fila = tvMedicamentos.dequeueReusableCell(withIdentifier: "row") as! ItemMedicamentoTableViewCell
        fila.lblCodigo.text = String(lista[indexPath.row].codigo)
        fila.lblNombre.text = lista[indexPath.row].nombre
        return fila
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "datosMedicamento", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="datosMedicamento"{
            let pantalla2 = segue.destination as! DatosMedicamentoViewController
            pantalla2.obj = lista[tvMedicamentos.indexPathForSelectedRow!.row]
        }
    }
    
    func listado() {
        AF.request("https://sistema-s2o0.onrender.com/medicamento/lista").responseDecodable(of: [Medicamento].self, completionHandler: {
            data in
            // Validar si hay datos dentro de "data"
            guard let info = data.value else {return}
            self.lista = info
            self.tvMedicamentos.reloadData()
        })
    }
}
