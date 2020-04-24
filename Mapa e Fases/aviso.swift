//
//  aviso.swift
//  auto
//
//  Created by Rafael Costa on 03/04/20.
//  Copyright © 2020 Rafael Costa. All rights reserved.
//

import UIKit

func zerafase(){
    switch prog {
    case 2:
        resposta1 = Array(repeating: 0, count:4)
    case 3:
        resposta2 = Array(repeating: 0, count:3)
    case 4:
        resposta3 = Array(repeating: 0, count:3)
    case 5:
        resposta4 = Array(repeating: 0, count:3)
    case 6:
        resposta5 = Array(repeating: 0, count:3)
    case 7:
        resposta6 = Array(repeating: 0, count:3)
    case 8:
        resposta7 = Array(repeating: 0, count:3)
    case 9:
        resposta8 = Array(repeating: 0, count:3)
    default:
        print("n era para isso acontecer")
    }
}

class popup: UIViewController{
    
    @IBOutlet weak var questao: UILabel!
    @IBOutlet weak var resp1: UIButton!
    @IBOutlet weak var resp2: UIButton!
    @IBOutlet weak var ajuda: UILabel!
    @IBOutlet var pop: UIView!
    @IBOutlet weak var efeito: UIVisualEffectView!
    var effect:UIVisualEffect!
    
    //Funçào que apresenta a pergunta e as respostas possíveis
    func mostraper(){
        questao.text = per[p]
        resp1.setTitle(per[p+1], for: .normal)
        resp2.setTitle(per[p+2], for: .normal)
        p += 4
    }
    
    func salvaresp (x: intmax_t){
        switch prog {
        case 2:
            resposta1[r] = x
        case 3:
            resposta2[r] = x
        case 4:
            resposta3[r] = x
        case 5:
            resposta4[r] = x
        case 6:
            resposta5[r] = x
        case 7:
            resposta6[r] = x
        case 8:
            resposta7[r] = x
        case 9:
            resposta8[r] = x
        default:
            print("n era para isso acontecer")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prog += 1
        effect = efeito.effect
        efeito.effect = nil
        pop.layer.cornerRadius = 5
        mostraper()
    }
    
    func anima(){
        self.view.addSubview(pop)
        pop.center = self.view.center
        pop.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        pop.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.efeito.effect = self.effect
            self.pop.alpha = 1
            self.pop.transform = CGAffineTransform.identity
        }
    }
    
    func animaf(){
        UIView.animate(withDuration: 0.3, animations: {
            self.pop.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.pop.alpha = 0
            
            self.efeito.effect = nil
            
        }){ (success: Bool) in
            self.pop.removeFromSuperview()
        }
    }
    
    @IBAction func p1(_ sender: AnyObject) {
        anima()
        ajuda.text = help[a]
    }
    
    @IBAction func p2(_ sender: Any) {
        anima()
        ajuda.text = help[a+1]
    }
    
    @IBAction func fecha(_ sender: AnyObject) {
        animaf()
    }
    
    @IBAction func volta(_ sender: AnyObject) {
        zerafase()
        r = 0
        prog -= 1
    }
    
    func perguntas(){
        if i >= 6 || q[i+1] == 0{
            self.performSegue(withIdentifier: "Finaliza", sender: self)
        }
        else {
            self.performSegue(withIdentifier: "Continua", sender: self)
            i += 1
            prog -= 1
        }
    }
    
    @IBAction func r1(_ sender: AnyObject) {
        a += 3
        salvaresp(x: 1)
        perguntas()
        r += 1
        pula = true
    }
    
    @IBAction func r2(_ sender: AnyObject) {
        a += 3
        salvaresp(x: 2)
        perguntas()
        r += 1
        pula = false
        c+=1
    }
}

class selecf: UIViewController{
    @IBOutlet weak var fala: UILabel!
    @IBOutlet weak var fase1: UIButton!
    @IBOutlet weak var fase2: UIButton!
    @IBOutlet weak var fase3: UIButton!
    @IBOutlet weak var fase4: UIButton!
    @IBOutlet weak var fase5: UIButton!
    @IBOutlet weak var fase6: UIButton!
    @IBOutlet weak var fase7: UIButton!
    @IBOutlet weak var fase8: UIButton!
    
    @IBOutlet weak var bancoFase2: UIButton!
    @IBOutlet weak var setaBancoF2: UIImageView!
    
    func dialogo(){
        if(c==8){
            bancoFase2.alpha = 1
            setaBancoF2.alpha = 1
            fala?.text = texto[c]
            c += 1
        }else{
          fala?.text = texto[c]
          if pula == true {
              c += 2
              pula = false
          } else {
            c += 1
          }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dialogo()
        //Progresso de fases
        switch prog {
        case 1:
            fase1?.backgroundColor = nil
        case 2:
            fase2?.backgroundColor = nil
        case 3:
            fase3?.backgroundColor = nil
        case 4:
            fase4?.backgroundColor = nil
        case 5:
            fase5?.backgroundColor = nil
        case 6:
            fase6?.backgroundColor = nil
        case 7:
            fase7?.backgroundColor = nil
        case 8:
            fase8?.backgroundColor = nil
        default:
            print("ERRO")
        }
    }
    
    @IBAction func banco(_ sender: Any) {
        print(contadorBanco)
    }
    
    
    
    //Avança uma fase
    @IBAction func avanca(_ sender: AnyObject) {
    }
    
    //Vai pra fase 1
    @IBAction func f1(_ sender: AnyObject) {
        contadorBanco = 1
        switch prog {
        case 1:
            r = 0
            p = 1
            a = 0
            i = 1
            q = q1
            c = q[0]
            self.performSegue(withIdentifier: "fase", sender: self)
        default:
            print("1:")
            for valor in resposta1{
                print(valor)
            }
            print("\n2:")
            for valor in resposta2{
                print(valor)
            }
            print("\n3:")
            for valor in resposta3{
                print(valor)
            }
            print("\n4:")
            for valor in resposta4{
                print(valor)
            }
            print("\n5:")
            for valor in resposta5{
                print(valor)
            }
            print("\n6:")
            for valor in resposta6{
                print(valor)
            }
            print("\n7:")
            for valor in resposta7{
                print(valor)
            }
            print("\n8:")
            for valor in resposta8{
                print(valor)
            }
        }
    }
    
    //Vai pra fase 2
    @IBAction func f2(_ sender: Any) {
        switch prog {
        case 2:
            r = 0
            p = 13
            a = 6
            i = 1
            q = q2
            c = q[0]
            self.performSegue(withIdentifier: "fase", sender: self)
        default:
            print("ERRO")
        }
    }
    
    //Vai pra fase 3
    @IBAction func f3(_ sender: AnyObject) {
        switch prog {
        case 3:
            r = 0
            p = 21
            a = 15
            i = 1
            q = q3
            c = q[0]
            self.performSegue(withIdentifier: "fase", sender: self)
        default:
            print("ERRO")
        }
    }
    
    //Vai pra fase 4
    @IBAction func f4(_ sender: AnyObject) {
        switch prog {
        case 4:
            r = 0
            p = 33
            a = 24
            i = 1
            q = q4
            c = q[0]
            self.performSegue(withIdentifier: "fase", sender: self)
        default:
            print("ERRO")
        }
    }
    
    //Vai pra fase 5
    @IBAction func f5(_ sender: AnyObject) {
        switch prog {
        case 5:
            r = 0
            p = 45
            a = 33
            i = 1
            q = q5
            c = q[0]
            self.performSegue(withIdentifier: "fase", sender: self)
        default:
            print("ERRO")
        }
    }
    
    //Vai pra fase 6
    @IBAction func f6(_ sender: AnyObject) {
        switch prog {
        case 6:
            r = 0
            p = 57
            a = 42
            i = 1
            q = q6
            c = q[0]
            self.performSegue(withIdentifier: "fase", sender: self)
        default:
            print("ERRO")
        }
    }
    
    //Vai pra fase 7
    @IBAction func f7(_ sender: AnyObject) {
        switch prog {
        case 7:
            r = 0
            p = 69
            a = 51
            i = 1
            q = q7
            c = q[0]
            self.performSegue(withIdentifier: "fase", sender: self)
        default:
            print("ERRO")
        }
    }
    
    //Vai pra fase 8
    @IBAction func f8(_ sender: AnyObject) {
        switch prog {
        case 8:
            r = 0
            p = 81
            a = 60
            i = 1
            q = q8
            c = q[0]
            self.performSegue(withIdentifier: "fase", sender: self)
        default:
            print("ERRO")
        }
    }
    
    //Refaz a fase
    @IBAction func refazer(_ sender: Any) {
        zerafase()
        r = 0
        prog -= 1
        c = q[0]
        i = 1
        
        switch prog {
        case 1:
            p = 1
            a = 0
        case 2:
            p = 13
            a = 6
        case 3:
            p = 21
            a = 15
        case 4:
            p = 33
            a = 24
        case 5:
            p = 45
            a = 33
        case 6:
            p = 57
            a = 42
        case 7:
            p = 69
            a = 51
        case 8:
            p = 81
            a = 60
        default:
            print("UÉ")
        }
        
    }
    
    //Quantidades de caixa de dialogo terão
    @IBAction func telas(_ sender: Any) {
        if c <= q[i]{
            dialogo()
        }
        else{
            self.performSegue(withIdentifier: "Passa", sender: self)
        }
    }
    @IBAction func fundoViraBanco(_ sender: UIButton) {
        
    }
    
}
