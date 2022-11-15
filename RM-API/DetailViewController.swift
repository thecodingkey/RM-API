//
//  DetailViewController.swift
//  RM-API
//
//  Created by Rosendo Vazquez on 14/11/22.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    var name:String?
    var status:String?
    var species:String?
    var gender:String?
    var origin:String?
    var image:String?
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSpecie: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(name: String? = nil, status: String? = nil, species: String? = nil, gender: String? = nil, origin: String? = nil, image: String? = nil) {
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.origin = origin
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView()  {
        fetchImage(url: image ?? "")
        view.backgroundColor = Utils.COLOR_TEXT
        
        
        lblName.textAlignment = .left
        lblStatus.textAlignment = .left
        lblSpecie.textAlignment = .left
        lblGender.textAlignment = .left
        lblOrigin.textAlignment = .left
        
        
        lblName.text = "\(name!)"
        lblStatus.text = "Status: \(status!)"
        lblSpecie.text = "Specie: \(species!)"
        lblGender.text = "Gender: \(gender!)"
        lblOrigin.text = "Origin: \(origin!)"
        
        
        btn.layer.backgroundColor = Utils.COLOR_BACKGROUND.cgColor
        btn.layer.cornerRadius = 24
        
        
        imgAvatar.contentMode = .scaleAspectFill
        imgAvatar.clipsToBounds = true
        imgAvatar.layer.cornerRadius = 116
   
    }
    
 
    
    @IBAction func gotIt(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func fetchImage(url:String) {
        AF.request(url).response {[weak self] response in
            
            if let data =  response.data{
                self?.imgAvatar.image = UIImage(data: data, scale: 1)
            }
        }
    }

}
