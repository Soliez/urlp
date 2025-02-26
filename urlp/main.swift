//
//  main.swift
//  urlp
//
//  Created by Erik Solis  on 2025-02-26.
//

import Foundation


func showUsage(){
    print("Usage: urlp [-plist | -json] <URL>")
}


func url2plist(url: String) -> [String: Any]? {
    guard let components = URLComponents(string: url) else {
        return nil
    }
    
    var plist: [String: Any] = [
        "scheme": components.scheme ?? "",
        "host": components.host ?? "",
        "path": components.path,
        "query": components.query ?? "",
        "fragment": components.fragment ?? "",
        "user": components.user ?? "",
        "password": components.password ?? ""
    ]
    
    // Only add the port if it exists.
    if let port = components.port {
        plist["port"] = port
    }
    
    // Add query items if any.
    if let queryItems = components.queryItems, !queryItems.isEmpty {
        plist["queryItems"] = queryItems.map { ["name": $0.name, "value": $0.value ?? ""] }
    }
    
    return plist
}

 
guard CommandLine.arguments.count > 2 else {
    showUsage()
    exit(1)
}

let format = CommandLine.arguments[1]
let url = CommandLine.arguments[2]

let plist = url2plist(url: url)

if format == "-plist" {
    if let plistData = try? PropertyListSerialization.data(fromPropertyList: plist!, format: .xml, options: 0),
       let plistString = String(data: plistData, encoding: .utf8) {
        print(plistString)
    } else {
        print("Error: Could not serialize plist.")
    }
} else if format == "-json" {
    if let jsonData = try? JSONSerialization.data(withJSONObject: plist!, options: [.prettyPrinted]),
       let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString)
    } else {
        print("Error: Could not serialize JSON.")
    }
} else {
    showUsage()
}
