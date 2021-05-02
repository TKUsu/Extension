//
//  PickViewController.swift
//  Lucker
//
//  Created by SuJustin on 2021/5/2.
//

import UIKit

class PickViewController: UIViewController {
    enum PickerType {
        case date, string(selectData: [String])
    }
    var type: PickerType = .date
    var date: Date = Date()
    var selectedString: String = ""
    var selectStringHandle: ((_ string: String)->())? = nil
    var selectDateHandle: ((_ date: Date)->())? = nil
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private var selectData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = title
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        
        switch type {
        case .string(let selectData):
            datePicker.isHidden = true
            pickerView.isHidden = false
            self.selectData = selectData
            selectedString = selectData[0]
            pickerView.reloadAllComponents()
        default:
            pickerView.isHidden = true
            datePicker.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func enterAction(_ sender: Button) {
        switch type {
        case .date:
            date = datePicker.date
//            print("[Tip] DatePicker: \(date)")
            selectDateHandle?(date)
        case .string(_):
//            print("[Tip] StringPicker: \(selectedString)")
            selectStringHandle?(selectedString)
        }
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension PickViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let string = selectData[row]
        selectedString = string
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let attributedString = NSAttributedString(string: selectData[row], attributes: [NSAttributedString.Key.foregroundColor : theme.black80])
//        return attributedString
//    }
}

extension UIViewController {
    func showPickerView(title: String?, type: PickViewController.PickerType) -> PickViewController? {
        guard let vc = storyboard?.instantiate(PickViewController.self) as? PickViewController else { return nil }
        vc.type = type
        vc.title = title
        addChild(vc)
        vc.view.frame = view.frame
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        return vc
    }
}
