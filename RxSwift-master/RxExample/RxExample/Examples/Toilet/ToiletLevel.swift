//
//  ToiletLevel.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/11/24.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//


enum OperationType {
    case stop
    case normalClean
    case femaleClean
    case dry
    case childClean
    case maleAuto
    case femaleAuto
}

enum WaterTemperatureLevel {
    case oneLevel
    case twoLevel
    case threeLevel
    case fourLevel
    case fiveLevel
    case sixLevel
    case spa
    case superCare
}

enum WaterPressureLevel {
    case oneLevel
    case twoLevel
    case threeLevel
    case fourLevel
    case fiveLevel
    case pressureLevel
}

enum PositionLevel {
    case oneLevel
    case twoLevel
    case threeLevel
    case fourLevel
    case fiveLevel
    case moveLevel
}

enum CleanTimeLevel {
    case oneLevel
    case twoLevel
    case threeLevel
    case fourLevel
}

extension OperationType{
    var value: UInt8 {
        switch self {
        case .stop:
            return 0
        case .normalClean:
            return 1
        case .femaleClean:
            return 2
        case .dry:
            return 3
        case .childClean:
            return 4
        case .maleAuto:
            return 5
        case .femaleAuto:
            return 6
        }
    }
}

extension WaterTemperatureLevel{
    var value: UInt8 {
        switch self {
        case .oneLevel:
            return 1
        case .twoLevel:
            return 2
        case .threeLevel:
            return 3
        case .fourLevel:
            return 4
        case .fiveLevel:
            return 5
        case .sixLevel:
            return 6
        case .spa:
            return 7
        case .superCare:
            return 8
        }
    }
    
    var sign: String{
        switch self {
        case .oneLevel:
            return "OFF"
        case .twoLevel:
            return "32˚C"
        case .threeLevel:
            return "34˚C"
        case .fourLevel:
            return "36˚C"
        case .fiveLevel:
            return "38˚C"
        case .sixLevel:
            return "40˚C"
        case .spa:
            return "冷热spa"
        case .superCare:
            return "经期特护"
        }
    }
}

extension WaterPressureLevel{
    var value: UInt8 {
        switch self {
        case .oneLevel:
            return 1
        case .twoLevel:
            return 2
        case .threeLevel:
            return 3
        case .fourLevel:
            return 4
        case .fiveLevel:
            return 5
        case .pressureLevel:
            return 6
        }
    }
    
    var sign: String{
        switch self {
        case .oneLevel:
            return "1档"
        case .twoLevel:
            return "2档"
        case .threeLevel:
            return "3档"
        case .fourLevel:
            return "4档"
        case .fiveLevel:
            return "5档"
        case .pressureLevel:
            return "按摩洗净"
        }
    }
}

extension PositionLevel{
    var value: UInt8 {
        switch self {
        case .oneLevel:
            return 1
        case .twoLevel:
            return 2
        case .threeLevel:
            return 3
        case .fourLevel:
            return 4
        case .fiveLevel:
            return 5
        case .moveLevel:
            return 6
        }
    }
    
    var sign: String{
        switch self {
        case .oneLevel:
            return "1档"
        case .twoLevel:
            return "2档"
        case .threeLevel:
            return "3档"
        case .fourLevel:
            return "4档"
        case .fiveLevel:
            return "5档"
        case .moveLevel:
            return "移动洗净"
        }
    }
}

extension CleanTimeLevel{
    var sign: String{
        switch self {
        case .oneLevel:
            return "1 min"
        case .twoLevel:
            return "2 min"
        case .threeLevel:
            return "3 min"
        case .fourLevel:
            return "4 min"
        }
    }
}
