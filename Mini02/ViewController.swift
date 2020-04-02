//
//  ViewController.swift
//  Mini02
//
//  Created by Rogerio Lucon on 27/03/20.
//  Copyright © 2020 Rogerio Lucon. All rights reserved.
//

import UIKit

var nome = "Kleytinho"
var dindin = 0.00
var fala = "Oi, Eu sou o " + nome
var nSemestre = 5
var semestre = String(nSemestre) + " Semestre"
var situacao = " Pendente "
var investimentoSelecionado = 0 //1-CDB, 2-LCI, 3-CRI, 4-Deb
var aplicada = [10.00,20.00,30.00,40.00]
var imposto0 = [2.00,1.50,1.00,2.00]
var bruto0 = [15.00,23.00,35.00,30.00]

class ViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        atualizaSaldo()
        atualizaFala()
        atualizaNome()
        atualizaSemestre()
        atualizaSituacao()
        // Do any additional setup after loading the view.
    }
    //Funcao para atualizar o saldo ao iniciar a tela
    func atualizaSaldo(){
        Dinheiro.text = "R$"+String(dindin)+"0 "
    }
    //Funcao para atualizar a fala da personagem ao carregar a tela
    func atualizaFala(){
        FalaPrsonagem.text=fala
    }
    func atualizaNome(){
        NomePersonagem.text = nome
    }
    func atualizaSemestre(){
        Semestre.text = semestre
    }
    func atualizaSituacao(){
        Situacao.text = situacao
    }
}
class Investimentos: UIViewController {
    
    @IBOutlet weak var explicacao: UILabel!
   
    @IBOutlet weak var tipoInvestimento: UILabel!
    @IBOutlet weak var aplicado: UILabel!
    
    @IBOutlet weak var bruto: UILabel!
    
    @IBOutlet weak var imposto: UILabel!
    
    @IBOutlet weak var lucro: UILabel!
    
    var Explicacao = ["Explicacao de CDB","Explicacao de LCI/LCA","Explicacao de CRI/CRA","Explicacao de DEBÊNTURES"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        atualizaRendimento()
        atualizaMsg()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func bCDB(_ sender: UIButton) {
        investimentoSelecionado = 0
        atualizaMsg()
        tipoInvestimento.text = "CDB"
        atualizaRendimento()
        
    }
    @IBAction func bLCI(_ sender: Any) {
        investimentoSelecionado = 1
        atualizaMsg()
        tipoInvestimento.text = "LCI/LCA"
        atualizaRendimento()
    }
    @IBAction func bCRI(_ sender: Any) {
        investimentoSelecionado = 2
        atualizaMsg()
        tipoInvestimento.text = "CRI/CRA"
        atualizaRendimento()
    }
    @IBAction func bDEB(_ sender: Any) {
        investimentoSelecionado = 3
        atualizaMsg()
        tipoInvestimento.text = "DEBÊNTURES"
        atualizaRendimento()
    }
    func atualizaRendimento(){
        aplicado.text = "R$ " + String( aplicada[investimentoSelecionado]) + "0"
        bruto.text = "R$ " + String( bruto0[investimentoSelecionado]) + "0"
        imposto.text = "R$ " + String( imposto0[investimentoSelecionado]) + "0"
        lucro.text = "R$ " + String(( bruto0[investimentoSelecionado] - imposto0[investimentoSelecionado])-aplicada[investimentoSelecionado]) + "0"
    }
    func atualizaMsg(){
        explicacao.text = Explicacao[investimentoSelecionado]
    }
    
    
}
class Investe: UIViewController{
    
    
    @IBOutlet weak var saldoDisp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        atualizaSaldoDispo()
        
        // Do any additional setup after loading the view.
    }
    func atualizaSaldoDispo(){
        saldoDisp.text = "Saldo disponível: R$ " + String(dindin) + "0 "
    }
}


