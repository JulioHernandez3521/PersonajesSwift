//
//  ViewController.swift
//  Reto 5 - Que personaje eres
//
//  Created by Forte Apps on 20/07/20.
//  Copyright © 2020 UVEG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let questions = [
        "¿Qué actividad prefieres?",
        "¿Qué ambiente disfrutas más?",
        "¿Cómo te describen tus amigos?",
        "¿Qué ritmo de trabajo tienes?",
        "¿Qué superpoder preferirías?"
    ]
    
    let answers = [
        ["Explorar", "Descansar", "Resolver acertijos"],
        ["Montaña", "Casa", "Bosque"],
        ["Valiente", "Tranquilo", "Astuto"],
        ["Rápido", "Lento", "Estratega"],
        ["Fuerza", "Tiempo", "Inteligencia"]
    ]
    
    var score = [
        "Leon": 0,
        "Tortuga": 0,
        "Zorro": 0
    ]
    
    var currentQuestion = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadQuestion()
    }
    
    func loadQuestion() {
        questionLabel.text = questions[currentQuestion]
        tableView.reloadData()
    }
    
    func assignScore(for option: String) {
        switch option {
        case "Explorar", "Montaña", "Valiente", "Rápido", "Fuerza":
            score["Leon"]! += 1
        case "Descansar", "Casa", "Tranquilo", "Lento", "Tiempo":
            score["Tortuga"]! += 1
        case "Resolver acertijos", "Bosque", "Astuto", "Estratega", "Inteligencia":
            score["Zorro"]! += 1
        default:
            break
        }
    }
    
    func showResult() {
        let resultVC = ResultViewController()
        resultVC.resultText = determineCharacter()
        self.present(resultVC, animated: true)
    }
    
    func determineCharacter() -> String {
        let maxScore = score.max { a, b in a.value < b.value }
        
        switch maxScore?.key {
        case "Leon":
            return "Eres un León 🦁\nValiente, decidido y protector."
        case "Tortuga":
            return "Eres una Tortuga 🐢\nPaciente, estable y confiable."
        case "Zorro":
            return "Eres un Zorro 🦊\nInteligente, creativo y estratégico."
        default:
            return "No se pudo determinar tu personalidad."
        }
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers[currentQuestion].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = answers[currentQuestion][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = answers[currentQuestion][indexPath.row]
        
        // Asignar puntos
        assignScore(for: selected)
        
        // Avanzar pregunta
        currentQuestion += 1
        
        if currentQuestion < questions.count {
            loadQuestion()
        } else {
            showResult()
        }
    }
}
