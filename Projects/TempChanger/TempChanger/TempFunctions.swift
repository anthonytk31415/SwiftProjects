//
//  tempFunctions.swift
//  TempChanger
//
//  Created by Anthony TK on 8/22/23.
//

import Foundation


func findTemp(amt: Double, input: String, output: String) -> Double? {
    let tempUnits: Set<String> = ["K", "C", "F"]
    var visited = Set<String>()
    var res: Double? = nil
    let conv: Dictionary<String,[(String, Double, Double)]> = ["K": [("C", 1, -273.15)], "C": [("K", 1, 273.15), ("F", 1.8, 32)], "F": [("C", 0.556, -32*0.556)]]

    if !tempUnits.contains(input) || !tempUnits.contains(output) {
        return nil
    }

    func dfs(cur: Double, start: String){
        print(start, output)
        if res == nil && start == output {
            res = cur
            return
        }
        let arr = conv[start]!
        for (out, convFact, convAdd) in arr {
            // print(visited, start, out, convFactor, res ?? "nil")
            if !visited.contains(out){
                visited.insert(out)
                dfs(cur: cur*convFact + convAdd, start: out)
            }
        }
    }
    visited.insert(input)
    dfs(cur: amt, start: input)
    return (res!*100.0).rounded()/100
}
