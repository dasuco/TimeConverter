//
//  ContentView.swift
//  TimeConverter
//
//  Created by Sucias Colomer, David on 8/7/21.
//

import SwiftUI

enum TypesConvinations {
    case SegToMin
    case SegToHrs
    case MinToSeg
    case MinToHrs
    case HrsToMin
    case HrsToSeg
    case mirrorCase
}

enum Units {
    case seg
    case min
    case hrs
}


struct ContentView: View {
    @State private var numberToConvert = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    
    let units = ["seg", "min", "hrs"]
    
    var inputUnitType: Units {
        if inputUnit == 0 {
            return .seg
        } else if  inputUnit == 1 {
            return .min
        } else {
            return .hrs
        }
    }
    
    var outputUnitType: Units {
        if outputUnit == 0 {
            return .seg
        } else if  outputUnit == 1 {
            return .min
        } else {
            return .hrs
        }
    }

    
    var useThisCaseConverter: TypesConvinations {
        if inputUnitType == Units.seg && outputUnitType == Units.min {
            return .SegToMin
        } else if inputUnitType == .seg && outputUnitType == .hrs {
            return .SegToHrs
        } else if inputUnitType == .min && outputUnitType == .seg {
            return .MinToSeg
        } else if inputUnitType == .min && outputUnitType == .hrs {
            return .MinToHrs
        } else if inputUnitType == .hrs && outputUnitType == .min {
            return .HrsToMin
        } else if inputUnitType == .hrs && outputUnitType == .seg {
            return .HrsToSeg
        } else {
            return .mirrorCase
        }
    }
    
    var resultConverted: Double {
        
        let intNumber = Int(numberToConvert) ?? 0
        
        switch useThisCaseConverter {
        case .SegToMin:
            return Double(intNumber / 60)
        case .SegToHrs:
            return Double(intNumber / 3600)
        case .MinToSeg:
            return Double(intNumber * 60)
        case .MinToHrs:
            return Double(intNumber / 60)
        case .HrsToMin:
            return Double(intNumber * 60)
        case .HrsToSeg:
            return Double(intNumber * 3600)
        case .mirrorCase:
            if intNumber == 0 {
                return 0.00
            } else {
                return Double(intNumber)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Introduce a number")) {
                    TextField("Number: ", text: $numberToConvert)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Select your unit")) {
                    Picker("Convert from this unit", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("What unit to covert your value?")) {
                    Picker("Convert to this unit", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text("\(resultConverted, specifier: "%.2f") \(units[outputUnit])")
                }
            }
            .navigationBarTitle("TimeConverter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
