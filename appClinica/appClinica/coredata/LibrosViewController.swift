//
//  LibrosViewController.swift
//  appClinica
//
//  Created by DAMII on 26/11/24.
//

import UIKit

class LibrosViewController: UIViewController,UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout{
    

    @IBOutlet weak var cvLibros: UICollectionView!
    var lista:[Libros]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        llenarDatos()
        cvLibros.dataSource=self
        cvLibros.delegate=self
    }
    func llenarDatos(){
        lista.append(Libros(codigo:1,titulo:"java 22",precio:87.6,cantidad:5, imagen: "java"))
        lista.append(Libros(codigo:2,titulo:"swift 6",precio:125.7,cantidad:9, imagen: "swift"))
        lista.append(Libros(codigo:3,titulo:"kotlin",precio:62.4,cantidad:15, imagen: "kotlin"))
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lista.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row=cvLibros.dequeueReusableCell(withReuseIdentifier: "row",for:indexPath) as! ItemCollectionViewCell
        row.imgFoto.image=UIImage(named: lista[indexPath.row].imagen)
        row.lblTitulo.text=lista[indexPath.row].titulo
        
   
        return row
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ancho=(collectionView.frame.width-40)/2
        return CGSize(width: ancho, height: 228)
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ancho=(collectionView.frame.width-50)/2
        return CGSize(width: ancho, height: 250)
    }*/
}
