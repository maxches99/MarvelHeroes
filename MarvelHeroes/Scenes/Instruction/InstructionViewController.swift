//
//  InstructionViewController.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 04.04.2021.
//

import UIKit
import Stevia
import RxCocoa
import RxSwift

class InstructionViewController: UIViewController {
    
    let btn = UIButton()
    
    var vm: InstructionViewModel
    
    var bag = DisposeBag()
    
    init(vm: InstructionViewModel) {
        self.vm = vm
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let lbl = UILabel()
        
        
        lbl.text = "Marvel Heroes"
        lbl.font = .systemFont(ofSize: 46, weight: .bold)
        
        let lbl1 = UILabel()
        lbl1.text = "Find your heroes"
        lbl1.font = .systemFont(ofSize: 16, weight: .bold)
        
        let imgFirst = UIImageView(image: UIImage(named: "Avengers_logo"))
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 16
        
        
        let lbl2 = UILabel()
        lbl2.text = "Open details of hero"
        lbl2.font = .systemFont(ofSize: 16, weight: .bold)
        
        let imgFirst2 = UIImageView(image: UIImage(named: "Avengers_logo"))
        
        let hStack2 = UIStackView()
        hStack2.axis = .horizontal
        hStack2.spacing = 16
        
        let lbl3 = UILabel()
        lbl3.text = "Use backswipe to navigate back"
        lbl3.font = .systemFont(ofSize: 16, weight: .bold)
        
        let imgFirst3 = UIImageView(image: UIImage(named: "Avengers_logo"))
        
        let hStack3 = UIStackView()
        hStack3.axis = .horizontal
        hStack3.spacing = 16
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 86
        vStack.addArrangedSubview(hStack)
        vStack.addArrangedSubview(hStack2)
        vStack.addArrangedSubview(hStack3)
        
        btn.backgroundColor = .blue
        btn.text("Continue")
        btn.layer.cornerRadius = 30
        
        view.subviews(lbl, vStack, btn)
        
        lbl.centerHorizontally().top(60)
        imgFirst.size(60)
        vStack.left(16).centerVertically()
        hStack.addArrangedSubview(imgFirst)
        hStack.addArrangedSubview(lbl1)
        imgFirst2.size(60)
        hStack2.addArrangedSubview(imgFirst2)
        hStack2.addArrangedSubview(lbl2)
        imgFirst3.size(60)
        hStack3.addArrangedSubview(imgFirst3)
        hStack3.addArrangedSubview(lbl3)
        
        btn.bottom(16).height(60).left(16).right(16).centerHorizontally()
        
        
        self.view = view
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        btn.rx.tap
            .bind(to: vm.goNext)
            .disposed(by: bag)
    }

}
