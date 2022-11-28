//
//  DictionaryExtension.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 28/11/22.
//

import Foundation

extension Dictionary {
    func toParameterString() -> String {
        var param = ""
        for key in self.keys {
            if let value = self[key] as? String {
                param = param + String(describing: key) + "=" + value + "&"
            }
        }
        if let _ = param.popLast() { }
        return param
    }
}
