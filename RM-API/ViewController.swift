//
//  ViewController.swift
//  RM-API
//
//  Created by Rosendo Vazquez on 11/11/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var dataTable:CharacterModel?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rick & Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Utils.COLOR_BACKGROUND
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        setupView()
        fetchData()
    }

    func setupView()  {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTable?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let name = dataTable?.results![indexPath.row].name ?? ""
        let status = dataTable?.results![indexPath.row].status ?? ""
        let species = dataTable?.results![indexPath.row].species ?? ""
        let gender = dataTable?.results![indexPath.row].gender ?? ""
        let origin = dataTable?.results![indexPath.row].origin?.name ?? ""
        let image = dataTable?.results![indexPath.row].image ?? ""
        
        let vc = DetailViewController(name: name, status:status, species: species, gender:gender, origin:origin, image:image)
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for:  indexPath)
        cell.textLabel?.text = "\(dataTable?.results![indexPath.row].id ?? 0) - \(dataTable?.results![indexPath.row].name?.capitalized ?? "Hola mundo")"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}



//MARK: API REST
extension ViewController{
    func fetchData()  {
        AF.request(Utils.BASE_URL).response{ [weak self] response in
            guard let data = response.data else { return }
            let dataResponse = try! JSONDecoder().decode(CharacterModel.self, from: data)
            self?.dataTable = dataResponse
            self?.tableView.reloadData()
        }
    }
    
    
}
