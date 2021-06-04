//
//  AppConfig.swift
//  iOSApp360
//
//  Created by WideClassrooms on 04/06/21.
//

public enum ValueType{
    case PHOTO
    case FULL_NAME
    case DATE_OF_BIRTH
    case MOBILE_NUMBER
    case SUBMIT_BUTTON
    case NOTE
    
}
 protocol FormFields {
    var heading:String {get}
    var subHeading:String {get}
    var valueType:[ValueType] {get}
    var fieldText:[String] { get }
}
public enum FormTemplateType{
    case DETAIL
    
}
 extension FormTemplateType:FormFields{
    var heading: String {
        switch self {
        case .DETAIL:
            return "Dynamic Form"
        
        }
    }
    
    var subHeading: String {
        switch self {
        case .DETAIL:
            return "FORM GENERATED USING Config file"
       
        }
    }
    
    
    var fieldText: [String] {
        switch self {
        case .DETAIL:
            return [
                "Upload",
                "Name ",
                "Date of Birth ",
                "Enter Mobile Number",
                "Learn the template flow and try to design same form using XML/JSON without using any xib/storyboard",
                "SUBMIT"
            ]
       
        }
    }
    var valueType: [ValueType] {
        switch self {
        case .DETAIL:
            return [
                .PHOTO,
                .FULL_NAME,
                .DATE_OF_BIRTH,
                .MOBILE_NUMBER,
                .NOTE,
                .SUBMIT_BUTTON
            ]
        
        }
    }
    
    
    
}
