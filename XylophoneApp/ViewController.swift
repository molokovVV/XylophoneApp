//
//  ViewController.swift
//  XylophoneApp
//
//  Created by Виталик Молоков on 05.02.2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var nameButtons = ["A","B","C","D","E","F","G"]
    private var buttonStackView = UIStackView()
    
    private var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
        createButtons()
        
    }
    
    private func createButtons() {
        for (index, nameButton) in nameButtons.enumerated() {
            let multiplierWidth = 0.97 - (0.03 * Double(index))
            createButton(name: nameButton, width: multiplierWidth)
        }
    }
    
    private func createButton(name: String, width: Double) {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(name, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 45)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
        
        buttonStackView.addArrangedSubview(button)
        
        button.layer.cornerRadius = 10
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: width).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        button.backgroundColor = getColor(for: name)
    }
    
    private func getColor(for name: String) -> UIColor {
        switch name {
        case "A": return .systemRed
        case "B": return .systemOrange
        case "C": return .systemYellow
        case "D": return .systemGreen
        case "E": return .systemIndigo
        case "F": return .systemBlue
        case "G": return .systemPurple
        default: return .white
        }
    }
    
    private func toggleButtonAlpha(_ button: UIButton) {
        button.alpha = button.alpha == 1 ? 0.5 : 1
    }
    
    private func playSound(_ buttonText: String) {
        guard let url = Bundle.main.url(forResource: buttonText, withExtension: "wav") else { return }
        
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    @objc private func buttonsTapped(_ sender: UIButton) {
        toggleButtonAlpha(sender)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.toggleButtonAlpha(sender)
        }
        guard let buttonText = sender.currentTitle else { return }
        playSound(buttonText)
    }
}

extension ViewController {
    private func setViews() {
        view.backgroundColor = .white
        view.addSubview(buttonStackView)
        
        buttonStackView.alignment = .center
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
