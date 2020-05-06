//
//  BancoViewController.swift
//  Mini02
//
//  Created by Gabriel Rodrigues da Silva on 06/04/20.
//  Copyright © 2020 Rogerio Lucon. All rights reserved.
//

import UIKit

class BancoViewController: UIViewController {
    
    //Banco
    @IBOutlet weak var SaldoBanco: UILabel!
    @IBOutlet weak var SaldoPoupanca: UILabel!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var foto: UIImageView!
    
    //Banco História
    @IBOutlet weak var saldoConta: UIView!
    @IBOutlet weak var poupancaView: UIView!
    @IBOutlet weak var Investimento: UIButton!
    @IBOutlet weak var Contas: UIButton!
    @IBOutlet weak var Extrato: UIButton!
    @IBOutlet weak var fundoView: UIView!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var seta: UIImageView!
    @IBOutlet weak var viewKim: UIView!
    @IBOutlet weak var textoLabel: UILabel!
    @IBOutlet weak var faturaView: UIView!
    @IBOutlet weak var faturaKim: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var faturaTexto: UILabel!
    @IBOutlet weak var setaFatura: UIImageView!
    @IBOutlet weak var faturaAtual: UILabel!
    @IBOutlet weak var cartaoLimite: UILabel!
    
    var banco = Personagem.shared.dinheiro(nil)
    let personagem: Personagem = Personagem.shared
    
    enum Segues {
        static let dicaFatura = "dicaFatura"
        static let dicaConta = "dicaConta"
        static let dicaBanco = "dicaBanco"
        static let guardarPoupanca = "poupGuardar"
        static let retirarPoupanca = "poupRetirar"
        static let pagarFatura = "pagarFatura"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foto?.image = UIImage(named: "kleytinho")
        nome?.text = personagem.nome!
        atualizarLabel()
        observer()
        
        fase1()
        fase2()
        fase4()

    }
    
    func observer(){
        NotificationCenter.default.addObserver(self, selector: #selector(atualizarSaldo(n:)), name: NSNotification.Name.init("AtualizarSaldo"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(proximoTexto(_:)), name: NSNotification.Name.init("AtualizarFala"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(faturaNext(_:)), name: NSNotification.Name.init("AtualizarFatura"), object: nil)
    }
    
    @objc func atualizarSaldo(n:NSNotification) {
        atualizarLabel()
        banco = personagem.dinheiro(nil)
    }
    
    @IBAction func BackButton(_ sender: Any) {
        let nome = Notification.Name(rawValue: atualizaFalaNotificationKey)
        NotificationCenter.default.post(name: nome, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func atualizarLabel() {
        let saldoConta = personagem.dinheiro(nil)
        let poupanca = personagem.poupanca(nil)
        let saldoFatura = personagem.fatura(nil)
        let limite = personagem.cartao(nil)! - saldoFatura!
        
        SaldoBanco?.text = "R$ " + String(format: "%.2f", saldoConta!).replacingOccurrences(of: ".", with: ",")
        SaldoPoupanca?.text = "R$ " + String(format: "%.2f", poupanca!).replacingOccurrences(of: ".", with: ",")
        cartaoLimite?.text = "R$ " + String(format: "%.2f", limite).replacingOccurrences(of: ".", with: ",")
        faturaAtual?.text = "Fatura atual: R$ " + String(format: "%.2f", saldoFatura!).replacingOccurrences(of: ".", with: ",")
    }
            
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.dicaFatura {
            let destVC = segue.destination as! DicasView
            destVC.fatura = "ToFirstChild"
        }
        if segue.identifier == Segues.dicaConta {
            let destVC = segue.destination as! DicasView
            destVC.contas = "ToFirstChild"
            
        }
        if segue.identifier == Segues.dicaBanco {
            let destVC = segue.destination as! DicasView
            destVC.banco = "ToFirstChild"
        }
        if segue.identifier == Segues.retirarPoupanca {
            let destVC = segue.destination as! PoupancaView
            destVC.action = "retirar"
            destVC.saldo = personagem.poupanca(nil)!
        }
        if segue.identifier == Segues.guardarPoupanca {
            let destVC = segue.destination as! PoupancaView
            destVC.action = "guardar"
            destVC.saldo = personagem.dinheiro(nil)!
        }
        if segue.identifier == Segues.pagarFatura {
            let destVC = segue.destination as! PoupancaView
            destVC.action = "pagar"
            destVC.saldo = personagem.dinheiro(nil)!
            destVC.minimo = personagem.fatura(nil)! * 0.1
        }
    }
    
    //História - Capítulo 1
    
    @IBAction func teste(_ sender: Any) {
        fundoView?.isHidden = false
    }
    
    @objc func fundoV(){
        fundoView?.isHidden = false
        print("ok...")

    }
    
    func fase1() {
        if prog == 1 && contadorBanco >= 1 {
            fundoView?.isHidden = false
            viewKim?.isHidden = false
            faturaKim?.isHidden = false
            poupancaView?.transform = CGAffineTransform(translationX: 0, y: -20)
            StackView?.transform = CGAffineTransform(translationX: 0, y: -90)
            Extrato?.transform = CGAffineTransform(translationX: 0, y: -130)
            textoLabel?.text = textoFase1[1]!
            faturaTexto?.text = textoFase1[contadorBanco]
            backButton?.isEnabled = false
        }
    }
    
    @IBAction func proximoTexto(_ sender: Any) {
        if contadorBanco >= 1 && contadorBanco <= 20 {
            if contadorBanco != 9  {
                contadorBanco += 1
                textoLabel?.text = textoFase1[contadorBanco]!
            }
            
            switch  contadorBanco {
            case 3:
                view.addSubview(saldoConta)
            case 4:
                view.sendSubviewToBack(saldoConta)
                view.addSubview(poupancaView)
                //seta?.center.x += 250
                //seta?.center.y -= 390
            case 6:
                seta?.isHidden = false
                //seta?.center.x -= 250
                //seta?.center.y += 390
            case 7:
                view.sendSubviewToBack(poupancaView)
                seta?.isHidden = true
                view.addSubview(StackView)
                Contas.alpha = 0.5
                Investimento?.isEnabled = false
            case 8:
                Investimento.alpha = 0.5
                Contas.alpha = 1
                seta?.isHidden = false
                seta?.center.x += 190
                seta?.center.y += 130
                contadorBanco += 1
            case 12:
                view.sendSubviewToBack(StackView)
                seta?.isHidden = true
                Investimento.alpha = 1
            case 17:
                view.addSubview(Extrato)
            case 19:
                viewKim?.isHidden = true
                fundoView?.isHidden = true
                contadorBanco = 0
                Investimento.alpha = 1
                poupancaView?.transform = .identity
                StackView?.transform = .identity
                Extrato?.transform = .identity
                backButton?.isEnabled = true
                NotificationCenter.default.post(name: NSNotification.Name.init("AtualizarTexto"), object: nil)
            default:
                print("ok")
            }
        }
    }
    
    @IBAction func voltarTexto(_ sender: Any) {
        if contadorBanco > 1 && contadorBanco <= 9 {
            contadorBanco -= 1
            textoLabel?.text = textoFase1[contadorBanco]!
            switch  contadorBanco {
            case 1:
                view.sendSubviewToBack(saldoConta)
            case 2:
                view.sendSubviewToBack(poupancaView)
                view.addSubview(saldoConta)
            case 3:
                view.sendSubviewToBack(poupancaView)
                view.addSubview(saldoConta)
            case 5:
                seta?.isHidden = true
            case 6:
                view.sendSubviewToBack(StackView)
                view.addSubview(poupancaView)
                seta?.isHidden = false
                seta?.center.x -= 190
                seta?.center.y -= 130
            case 8:
                textoLabel?.text = textoFase1[contadorBanco - 1]!
                Investimento.alpha = 1
                Contas.alpha = 0.5
                seta?.isHidden = true
                contadorBanco -= 1
            default:
                print("nada")
            }
        }
    }

    //História - Capítulo 2
    
    func fase2() {
        if prog == 2 && contadorBanco >= 1 || prog == 3 && contadorBanco >= 1 {
            if contadorBanco == 1 {
                fundoView?.isHidden = false
                view?.addSubview(StackView)
                Investimento?.isUserInteractionEnabled = false
                Investimento?.alpha = 0.5
                Contas?.alpha = 1
                seta?.isHidden = false
                seta?.center.x += 190
                seta?.center.y += 220
                backButton?.isEnabled = false
            }
            faturaKim?.isHidden = false
            faturaTexto?.text = textoFase2[contadorBanco]
        }
    }
    @IBAction func contas(_ sender: Any) {
        if prog == 2 && contadorBanco >= 1 {
            view.sendSubviewToBack(StackView)
            contadorBanco += 1
        }
    }
    @IBAction func pagar(_ sender: Any) {
        if prog == 2 && contadorBanco >= 1 {
            //faturaNext((Any).self)
            //contadorBanco += 1
        }
    }
    
    @IBAction func faturaNext(_ sender: Any) {
        if prog == 1 && contadorBanco >= 12 && contadorBanco < 14 {
            contadorBanco += 1
            faturaTexto?.text = textoFase1[contadorBanco]
            if contadorBanco == 14 {
                faturaView?.isHidden = false
                setaFatura?.isHidden = false
                NotificationCenter.default.post(name: NSNotification.Name.init("AtualizarView"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name.init("AtualizarFala"), object: nil)
            }
        }
        else if prog == 2 && contadorBanco >= 1 && contadorBanco < 14 {
            print(contadorBanco)

            if contadorBanco <= 5 || contadorBanco > 6 {
                faturaTexto?.text = textoFase2[contadorBanco]
                if contadorBanco != 7 {
                    contadorBanco += 1
                }

                switch  contadorBanco {
                case 3:
                    NotificationCenter.default.post(name: NSNotification.Name.init("AtualizarView"), object: nil)
                case 6:
                    faturaView?.isHidden = false
                    setaFatura?.isHidden = false
                    setaFatura?.center.x += 310
                    setaFatura?.center.y += 185
                case 7:
                    faturaView?.isHidden = true
                    setaFatura?.isHidden = true
                    fundoView?.isHidden = true
                    Investimento?.alpha = 1
                    Contas?.isUserInteractionEnabled = false
                    backButton?.isEnabled = true
                    NotificationCenter.default.post(name: NSNotification.Name.init("AtualizarTexto"), object: nil)
                case 14:
                    self.dismiss(animated: true, completion: nil)
                default: break
                }
            }
        }
        else if prog == 3 && contadorBanco >= 1 || prog == 4 && contadorBanco >= 1 {
            seta?.isHidden = true
            Investimento?.isUserInteractionEnabled = false
            Contas?.isUserInteractionEnabled = false
            Contas?.alpha = 1
            Investimento?.alpha = 1
            fundoView?.isHidden = true
            backButton?.isEnabled = true
        }
        
    }
    
    //História - Capítulo 4
    
    func fase4() {
        if prog == 4 && contadorBanco >= 1 {
            if contadorBanco == 1 {
                fundoView?.isHidden = false
                view?.addSubview(StackView)
                Investimento?.alpha = 1
                Contas?.isUserInteractionEnabled = false
                Contas?.alpha = 0.5
                seta?.isHidden = false
                seta?.center.x += 5
                seta?.center.y += 220
                backButton?.isEnabled = false
            }
        }
    }
    
    
}


extension PoupancaView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


class PoupancaView: UIViewController {
    
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var SaldoDisponivel: UILabel!
    @IBOutlet weak var ValorTextField: UITextField!
    @IBOutlet weak var valorMinimo: UILabel!
    
    var saldo: Float = 0
    var minimo: Float = 0
    var banco = personagem.dinheiro(nil)
    var poupanca = personagem.poupanca(nil)
    var valor: String!
    var valor2: String!
    var valorFt: String!
    
    var action = "xxxx"
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionLabel.text = action
        SaldoDisponivel?.text = "Saldo disponível: R$ " + String(format: "%.2f", saldo).replacingOccurrences(of: ".", with: ",")
        ValorTextField?.delegate = self
        if action == "pagar" {
            valorMinimo?.isHidden = false
            valorMinimo?.text = "Pagamento mínimo: R$ " + String(format: "%.2f", minimo).replacingOccurrences(of: ".", with: ",")
        }

        observer()
    }
    func observer(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if let duration = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double {
                
                UIView.animate(withDuration: duration){
                    let bounds = UIScreen.main.bounds
                    self.view.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height - keyboardSize.height)
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    @objc func keyboardHide(notification: NSNotification){
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double {
            UIView.animate(withDuration: duration){
                self.view.frame = UIScreen.main.bounds
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @IBAction func ConfirmarButton(_ sender: Any) {

      
            if (ValorTextField.hasText && action == "guardar") {
            valor = ValorTextField.text?.replacingOccurrences(of: ",", with: ".")
            let total = (valor as NSString).floatValue
            
            if (total <= banco!) {
                _ = personagem.dinheiro(-total)
                 _ = personagem.poupanca(total)
                NotificationCenter.default.post(name: NSNotification.Name.init("AtualizarSaldo"), object: nil)
                self.dismiss(animated: true, completion: nil)

                
            } else {
                let alert = UIAlertController(title: "Saldo da conta insuficiente", message: nil, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        } else if(ValorTextField.hasText && action == "retirar") {
            valor2 = ValorTextField.text?.replacingOccurrences(of: ",", with: ".")
            let total2 = (valor2 as NSString).floatValue
                let poup = personagem.poupanca(nil)
            
            if (total2 <= poup!) {
                 _ = personagem.dinheiro(total2)
                 _ = personagem.poupanca(-total2)
                NotificationCenter.default.post(name: NSNotification.Name.init("AtualizarSaldo"), object: nil)
                self.dismiss(animated: true, completion: nil)

                
            } else {
                ValorTextField.clearsOnBeginEditing = true
                let alert = UIAlertController(title: "Saldo da poupança insuficiente", message: nil, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
            } else if ValorTextField.hasText && action == "pagar" {
                valorFt = ValorTextField.text?.replacingOccurrences(of: ",", with: ".")
                let total = (valorFt as NSString).floatValue
                
                if total <= banco! && total >= minimo {
                    _ = personagem.dinheiro(-total)
                    _ = personagem.fatura(-total)
                    NotificationCenter.default.post(name: NSNotification.Name.init("AtualizarSaldo"), object: nil)
                    self.dismiss(animated: true) {
                        contadorBanco = 7
                        print("ContadorPoup: \(contadorBanco)")
                        NotificationCenter.default.post(name: NSNotification.Name.init("AtualizarFatura"), object: nil)
                    }
                    
                } else if total > banco! {
                    let alert = UIAlertController(title: "Saldo da conta insuficiente", message: nil, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            else if prog == 2 && contadorBanco >= 1 {
                print("Atualizada")
            }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ValorTextField?.resignFirstResponder()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        valor = textField.text?.replacingOccurrences(of: ",", with: ".")
        let total = (valor as NSString).floatValue
        if ValorTextField.hasText && total > banco! && action == "guardar" {
            SaldoDisponivel.textColor = .red
        } else if ValorTextField.hasText && total > poupanca! && action == "retirar" {
            SaldoDisponivel.textColor = .red
        } else if ValorTextField.hasText && total < minimo && action == "pagar" {
            valorMinimo.textColor = .red
        } else {
            SaldoDisponivel.textColor = .black
            if action == "pagar" {
                valorMinimo.textColor = .black
            }
        }
    }
    
    
}


class DicasView: UIViewController {
    
    enum dicas {
       static let banco = [
                            "nome": "Banco",
                            "desc": "Texto...Banco..."
                          ]
       static let poupanca = [
                                "nome": "Poupança",
                                "desc": "Texto...Poupança..."
                             ]
       static let contas = [
                            "nome": "Contas",
                            "desc": "Texto...Contas..."
                          ]
       static let fatura = [
                            "nome": "Fatura",
                            "desc": "Texto...Fatura..."
                            ]
    }
        
    var fatura: String = "dicaFatura"
    var contas: String = "dicaConta"
    var banco: String = "dicaBanco"
    var poupanca: String = "dicaPoupanca"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .none
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == banco {
            let destVC = segue.destination as! DicasChildView
            destVC.view.backgroundColor = .lightGray
            destVC.tituloLabel?.text = dicas.banco["nome"]!
            destVC.textLabel?.text = dicas.banco["desc"]!
        }
        if segue.identifier == poupanca {
            let destVC = segue.destination as! DicasChildView
            destVC.view.backgroundColor = .darkGray
            destVC.tituloLabel?.text = dicas.poupanca["nome"]!
            destVC.textLabel?.text = dicas.poupanca["desc"]!
        }
        if segue.identifier == contas {
            let destVC = segue.destination as! DicasChildView
            destVC.view.backgroundColor = .yellow
            destVC.tituloLabel?.text = dicas.contas["nome"]!
            destVC.textLabel?.text = dicas.contas["desc"]!
        }
        if segue.identifier == fatura {
            let destVC = segue.destination as! DicasChildView
            destVC.view.backgroundColor = .green
            destVC.tituloLabel?.text = dicas.fatura["nome"]!
            destVC.textLabel?.text = dicas.fatura["desc"]!
        }
    }
    
}


class DicasChildView: UIViewController {
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        tituloLabel?.text = "Padrão"
        textLabel?.backgroundColor = .none
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
