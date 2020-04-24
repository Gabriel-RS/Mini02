//
//  ViewController.swift
//  Mini02
//
//  Created by Rogerio Lucon on 27/03/20.
//  Copyright © 2020 Rogerio Lucon. All rights reserved.
//

import UIKit

var situacao = " Pendente "

let atualizaRendimentosNotificationKey = "co.gusrigor.atualizaRendimento"
let atualizaFalaNotificationKey = "co.gusrigor.atualizaFala"

class ViewController: UIViewController {
    
    
    @IBOutlet var scorePopover: UIView!
    //Fala da personagem no campo da tela de intro
    @IBOutlet weak var FalaPrsonagem: UITextView!
    //A quantidade de dinheiro da personagem no jogo
    @IBOutlet weak var Dinheiro: UILabel!
    //O nome da personagem
    @IBOutlet weak var NomePersonagem: UILabel!
    //Semestre o qual a personagem esta
    @IBOutlet weak var Semestre: UILabel!
    //A situacao financeira da personagem
    @IBOutlet weak var Situacao: UILabel!
    let notificacao = Notification.Name(rawValue: atualizaFalaNotificationKey)
    var configView: ConfigView?
    var personagem: Personagem = Personagem.shared
    
    deinit {
           NotificationCenter.default.removeObserver(self)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        atualizaSaldo()
        atualizaFala()
        atualizaNome()
        atualizaSemestre()
        atualizaSituacao()
        observer()
        // Do any additional setup after loading the view.
    }
  

    @IBAction func configuracao(_ sender: Any) {
        if configView == nil {
            configView = ConfigView(frame: view.frame, viewController: self)
        }
        view.addSubview(configView!)
        configView?.translatesAutoresizingMaskIntoConstraints = false
        configView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        configView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        configView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        configView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
  
    @IBAction func scoreInfo(_ sender: Any) {
        self.view.addSubview(scorePopover)
        
        self.tabBarController?.setTabBar(hidden: true, viewController: self)
        
        scorePopover.translatesAutoresizingMaskIntoConstraints = false
        scorePopover.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scorePopover.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scorePopover.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scorePopover.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scorePopover.removeFromSuperview()
        configView?.dismiss()
        self.tabBarController?.setTabBar(hidden: false, viewController: self)
    }
    
    func observer(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.atualizarFala(notificacao:)), name: notificacao, object: nil)
    }
  
    @objc func atualizarFala(notificacao: NSNotification){
        print("a notificacao chegou")
        atualizaSaldo()
        atualizaFala()
    }
    //Funcao para atualizar o saldo ao iniciar a tela
    func atualizaSaldo(){
        print("FOI")
        personagem = Personagem.shared
        Dinheiro.text = String(format:"R$ %.2f", personagem.dinheiro(nil)!)
    }
    //Funcao para atualizar a fala da personagem ao carregar a tela
    func atualizaFala(){
        personagem = Personagem.shared
        let temp:Int? = personagem.score(nil)
        if(temp!>650){
            FalaPrsonagem.text = "Está na situação boa!"
        }else if(temp!>350){
            FalaPrsonagem.text = "Está na situação Mais ou menos!"
        }else{
            FalaPrsonagem.text = "Está na situação Ruim!"
        }
    }
    func atualizaNome(){
        NomePersonagem.text = personagem.nome
    }
    func atualizaSemestre(){
        Semestre.text = "\(personagem.semestreAtual()) Semestre"
    }
    func atualizaSituacao(){
        Situacao.text = situacao
    }
}


