//
//  ViewController.swift
//  QuotesPractice
//
//  Created by Telman Yusifov on 02.05.25.
//

import UIKit

class ViewController: UIViewController {
    
    private let languageManager = LanguageManager.shared
    
    let quotes: [QuoteModel] = [
        .init(text: "quote1", author: "quote1author", color: .red),
        .init(text: "quote2", author: "quote2author", color: .blue),
        .init(text: "quote3", author: "quote3author", color: .purple),
    ]
    
    var activeQuoteIndex = 0
    var activeQuote: QuoteModel? = nil
    var selectedLanguage: String? = nil
    
    private let quoteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .red
        return view
    }()
    
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.montserratMedium.rawValue, size: 16)
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: Fonts.montserratSemibold.rawValue, size: 16)
        return label
    }()
    
    private let quoteStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .center
        return view
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("next_quote".localized(), for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        activeQuoteIndex = 0
        activeQuote = quotes.first
        selectedLanguage = languageManager.get()
        
        updateQuoteLanguage()
        
        
        let languageButton = UIBarButtonItem(image: UIImage(systemName: "globe"), style: .done, target: self, action: #selector(didTapChangeLanguageButton))
        navigationController?.navigationBar.topItem?.setRightBarButton(languageButton, animated: true)
        
        view.addSubview(quoteView)
        quoteView.addSubview(quoteStackView)
        quoteStackView.addArrangedSubview(quoteLabel)
        quoteStackView.addArrangedSubview(authorLabel)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            quoteView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quoteView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quoteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            quoteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            quoteStackView.topAnchor.constraint(equalTo: quoteView.topAnchor, constant: 50),
            quoteStackView.bottomAnchor.constraint(equalTo: quoteView.bottomAnchor, constant: -50),
            quoteStackView.leadingAnchor.constraint(equalTo: quoteView.leadingAnchor, constant: 20),
            quoteStackView.trailingAnchor.constraint(equalTo: quoteView.trailingAnchor, constant: -20),
            
            nextButton.topAnchor.constraint(equalTo: quoteView.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapNextButton() {
        if activeQuoteIndex < (quotes.count - 1) {
            activeQuoteIndex += 1
        } else {
            activeQuoteIndex = 0
        }
        
        activeQuote = quotes[activeQuoteIndex]
        updateTexts()
    }
    
    private func updateQuoteLanguage() {
        UIView.animate(withDuration: 0.2) {
            self.quoteLabel.alpha = 0
            self.authorLabel.alpha = 0
            self.quoteView.backgroundColor = self.activeQuote?.color
        }
        UIView.animate(withDuration: 0.2, delay: 0.2) {
            self.quoteLabel.alpha = 1
            self.authorLabel.alpha = 1
        }
        
        quoteLabel.text = activeQuote?.text.localized()
        authorLabel.text = "- \(activeQuote?.author.localized() ?? "")"
    }
    
    @objc
    private func didTapChangeLanguageButton() {
        let alert = UIAlertController(title: "choose_language".localized(), message: nil, preferredStyle: .actionSheet)
        let englishButton = UIAlertAction(title: "English", style: .default) { alertAction in
            self.languageManager.change(language: Language.en.rawValue)
            self.updateTexts()
        }
        let turkButton = UIAlertAction(title: "Türkçe", style: .default) { alertAction in
            self.languageManager.change(language: Language.tr.rawValue)
            self.updateTexts()
        }
        let azerbaijanButton = UIAlertAction(title: "Azərbaycan", style: .default) { alertAction in
            self.languageManager.change(language: Language.az.rawValue)
            self.updateTexts()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(englishButton)
        alert.addAction(turkButton)
        alert.addAction(azerbaijanButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    
    private func updateTexts() {
        nextButton.setTitle("next_quote".localized(), for: .normal)
        updateQuoteLanguage()
    }
}

