//
//  ViewController.swift
//  iOSApp360
//
//  Created by WideClassrooms Chauhan on 04/06/21.
//

import UIKit

class ViewController: UIViewController {
    var currentTemplate:FormTemplateType?
    let dayArray = Array(1...31)
    let monthArray = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    let yearArray = Array(1920...2021)
    var scrollView:UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentTemplate = .DETAIL
        self.getTemplateView(template: .DETAIL)
    }

    
    func getTemplateView(template:FormTemplateType){
        self.view.subviews.forEach({$0.removeFromSuperview()})
        scrollView = UIScrollView()
        scrollView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
       let contentView = UIView()
        contentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        

        
        if let healthForm = self.getFormContentView(template: template){
            contentView.addSubview(healthForm)
            NSLayoutConstraint.activate([
                healthForm.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 0)
            ])
            healthForm.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView!.addSubview(contentView)
            self.view.addSubview(scrollView!)
            if (template == .DETAIL){
                contentView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 700)
                scrollView!.contentSize = CGSize(width: contentView.frame.size.width, height: 700)
            }
            
        }
        
    }
    
    func getFormContentView(template:FormTemplateType) -> UIStackView? {
        
        let wrapperView = self.getVStack(spacing: 20, distribution: .fill)
        wrapperView.isLayoutMarginsRelativeArrangement = true
        wrapperView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 15, bottom: 0, trailing: 15)
        switch template {
        case .DETAIL:
            
            let header = getHeader(template: template)
            wrapperView.addArrangedSubview(header)
            
            let photoStack = self.getHStack(spacing: 8, distribution: .fillProportionally)
            let nameStack = self.getVStack(spacing: 10, distribution: .fill)
            
            
            let contentView = getVStack(spacing: 12, distribution: .fill)
            for value in template.valueType {
                switch value {
                case .PHOTO:
                    if let field = self.getChildView(template: template, valueType: value){
                        photoStack.addArrangedSubview(field)
                    }
                    contentView.addArrangedSubview(photoStack)
                    break
                case .FULL_NAME, .DATE_OF_BIRTH:
                    if let field = self.getChildView(template: template, valueType: value){
                        nameStack.addArrangedSubview(field)
                    }
                    break
               
                case .MOBILE_NUMBER,.SUBMIT_BUTTON,.NOTE:
                    
                    if let field = self.getChildView(template: template, valueType: value){
                        contentView.addArrangedSubview(field)
                    }
                    break;
               
                default:
                    print("NA")
                }
                
                
            }
            let photoView = UIView()
            photoView.addSubview(photoStack)
            wrapperView.addArrangedSubview(photoView)
            photoView.heightAnchor.constraint(equalTo: photoStack.heightAnchor).isActive = true
            photoStack.centerXAnchor.constraint(equalTo: photoView.centerXAnchor).isActive = true
            photoView.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addArrangedSubview(nameStack)
            wrapperView.addArrangedSubview(contentView)
            //wrapperView.addArrangedSubview(vStack)
        
        
        }
        
        return wrapperView
    }
    
    
    
}

//View Design

extension ViewController{
    func getVStack(spacing:CGFloat, distribution:UIStackView.Distribution)->UIStackView{
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = spacing
        stack.distribution = distribution
        return stack
    }
    
    func getHStack(spacing:CGFloat, distribution:UIStackView.Distribution)->UIStackView{
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = spacing
        stack.distribution = distribution
        return stack
    }
    
    func getChildView(template:FormTemplateType, valueType:ValueType)->UIStackView?{
        var viewHolder:UIStackView?
        switch template {
        
        case .DETAIL:
            switch valueType {
            case .PHOTO:
                viewHolder = self.getVStack(spacing: 10, distribution: .fill)
                if let index = template.valueType.firstIndex(of: valueType) {
                    let title = template.fieldText[index]
                    let imageView = UIImageView()
                    
                    imageView.image = UIImage(named: "dummy-user")
                    imageView.tag = index+1
                    
                    let button = UIButton()
                    button.setTitle(title, for: .normal)
                    button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
                    button.backgroundColor = UIColor.systemBlue
                    button.setTitleColor(.white, for: .normal)
                    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                    button.layer.cornerRadius = 10
                    button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
                   
                    button.tag = Int("\(index+1)1") ?? 0
                    button.heightAnchor.constraint(equalToConstant: 25).isActive = true
                    button.translatesAutoresizingMaskIntoConstraints = false
                    if let container = viewHolder {
                        
                        container.addArrangedSubview(imageView)
                        container.addArrangedSubview(button)
                        container.widthAnchor.constraint(equalToConstant: 120).isActive = true
                        container.translatesAutoresizingMaskIntoConstraints = false
                    }
                    imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    imageView.layer.cornerRadius = 60
                    imageView.layer.borderWidth = 0.3
                    imageView.layer.borderColor = UIColor.gray.cgColor
                    imageView.layer.masksToBounds = true
                    imageView.contentMode = .center
                    
                }
                
                break
            case .FULL_NAME, .DATE_OF_BIRTH:
                viewHolder = self.getVStack(spacing: 5, distribution: .fill)
                if let index = template.valueType.firstIndex(of: valueType) {
                    let title = template.fieldText[index]
                    let label = UILabel()
                    label.text = title
                    label.font = UIFont(name: "Helvetica", size: 15)
                    label.textColor = .darkGray
                    
                    let wrapper = self.getHStack(spacing: 5, distribution: .fillEqually)
                    for count in 0...2 {
                        
                        let textField = UITextField()
                        if( valueType == .DATE_OF_BIRTH) {
                            let placeholders = ["Day", "Month", "Year"]
                            textField.placeholder = placeholders[count]
                            textField.textAlignment = .left
                            let toolbar: UIToolbar = UIToolbar()
                            
                            toolbar.barStyle = UIBarStyle.default
                            
                             
                        }else{
                            
                            switch count {
                                case 0:
                                    
                                    textField.placeholder = "First"
                                    textField.becomeFirstResponder()
                                    break
                                case 1:
                                    
                                    textField.placeholder = "Middle"
                                    
                                    break
                                case 2:
                                    
                                    textField.placeholder = "Last"
                                    break
                                default:
                                    print("NA")
                            
                            }
                        }
                        textField.backgroundColor = .white
                        textField.layer.cornerRadius = 8
                        textField.layer.borderWidth = 0.3
                        
                        wrapper.addArrangedSubview(textField)
                        
                    }
                    wrapper.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    label.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    label.translatesAutoresizingMaskIntoConstraints = false
                    wrapper.translatesAutoresizingMaskIntoConstraints = false
                    
                    if let container = viewHolder {
                        container.addArrangedSubview(label)
                        container.addArrangedSubview(wrapper)
                        
                        container.translatesAutoresizingMaskIntoConstraints = false
                    }
                    
                }
                break
            case .MOBILE_NUMBER:
                viewHolder = self.getVStack(spacing: 5, distribution: .fill)
                if let index = template.valueType.firstIndex(of: valueType) {
                    let title = template.fieldText[index]
                    
                    let label = UILabel()
                    label.text = title
                    label.font = UIFont(name: "Helvetica", size: 15)
                    label.textColor = .darkGray
                    
                    let leftLabel = UILabel()
                    leftLabel.text = "+91-"
                    leftLabel.font = UIFont(name: "Helvetica", size: 19)
                    leftLabel.textColor = .darkGray
                    
                    
                    let textField = UITextField()
                    textField.tag = index + 1
                    textField.backgroundColor = .white
                    textField.layer.cornerRadius = 8
                    textField.layer.borderWidth = 0.3
                    textField.leftView = leftLabel
                    textField.leftViewMode = .always
                    textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    if let container = viewHolder {
                        container.addArrangedSubview(label)
                        container.addArrangedSubview(textField)
                    }
                    
                }
                
                
                
                break
           case .NOTE:
                viewHolder = self.getHStack(spacing: 12, distribution: .fill)
                if let index = template.valueType.firstIndex(of: valueType) {
                    let title = template.fieldText[index]
                    
                    
                    
                    let label = UILabel()
                    label.text = title
                    label.textColor = .darkGray
                    label.numberOfLines = 0
                    label.font = UIFont(name: "Helvetica", size: 14)
                    if let container = viewHolder {
                        container.addArrangedSubview(label)
                    }
                    
                    
                }
                break
            
            
            case .SUBMIT_BUTTON:
                viewHolder = self.getVStack(spacing: 5, distribution: .fill)
                if let index = template.valueType.firstIndex(of: valueType) {
                    let title = template.fieldText[index]
                    //let toggleView = UIView()
                    let submitView = UIView()
                    let button = UIButton()
                    
                    button.setTitle(title, for: .normal)
                    button.backgroundColor = UIColor.blue
                    button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
                    button.setTitleColor(.white, for: .normal)
                    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
                    button.tag = index + 1
                    
                    button.layer.cornerRadius = 20
                    button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 40, bottom: 15, right: 40)
                    
                    NSLayoutConstraint.activate([
                        submitView.heightAnchor.constraint(equalToConstant: 30)
                        
                    ])
                    submitView.addSubview(button)
                    button.centerXAnchor.constraint(equalTo: submitView.centerXAnchor).isActive = true
                    submitView.bringSubviewToFront(button)
                            
                    if let container = viewHolder {
                        container.addArrangedSubview(submitView)
                        
                    }
                    button.translatesAutoresizingMaskIntoConstraints = false
                    
                }
                break
            
            default:
                print("NA")
            }
            break
        
        
        }
        
        return viewHolder
    }
    
    func getHeader(template:FormTemplateType) -> UIStackView{
        let wrapper = self.getVStack(spacing: 8, distribution: .fill)
        let heading = template.heading
        let subheading = template.subHeading
        if  heading != ""{
            let header = UILabel()
            header.text = heading
            header.textAlignment = .left
            header.font = UIFont(name: "Helvetica", size: 20)
            header.textColor = .darkGray
            header.heightAnchor.constraint(equalToConstant: 50).isActive = true
            wrapper.addArrangedSubview(header)
            
        }
        
        if subheading != "" {
            let subheader = UILabel()
            subheader.text = subheading
            subheader.font = UIFont(name: "Helvetica", size: 15)
            subheader.numberOfLines = 0
            subheader.textColor = .gray
            wrapper.addArrangedSubview(subheader)
        }
       
        return wrapper
    }
}

