
import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tvClientes: UITableView!
    //arreglo de la estructura cliente
    var lista:[ClienteEntity]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lista=ControladorCliente().findAll()
        //origen de datos en la clase actual
        tvClientes.dataSource=self
        //cambiar alto a la celda
        tvClientes.rowHeight=200
        //escuchar delegado
        tvClientes.delegate=self
    }

    @IBAction func btnNuevo(_ sender: UIButton) {
        performSegue(withIdentifier: "nuevo", sender: nil)
    }
    /*func llenarArreglo(){
      lista.append(Cliente(codigo:1,nombre:"Luis",apellido:"Soto Mora",credito: 5600))
      lista.append(Cliente(codigo:2,nombre:"Ana",apellido:"Luna Castro",credito: 7400))
      lista.append(Cliente(codigo:3,nombre:"Alicia",apellido:"Pari Oca",credito: 8900))
    }*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //objeto de la clase ItemTableViewCell
        let row=tvClientes.dequeueReusableCell(withIdentifier: "celda") as! ItemTableViewCell
        //acceder a los labels
        row.lblCodigo.text=String(lista[indexPath.row].codigo)
        row.lblNombre.text=lista[indexPath.row].nombre
        return row
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "datos", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="datos"{
            let pantalla2=segue.destination as! DatosClienteViewController
            pantalla2.obj=lista[tvClientes.indexPathForSelectedRow!.row]
        }
    }
}

