//
//  Model.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import Foundation
// MARK: - Welcome
struct ResponseModel: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
    func toCurrencyType() -> [currencyType] {
        return rates.map{.init(price: $0.value, id: $0.key)}
    }
}

struct currencyType: Identifiable, Equatable, Comparable, Hashable {
    static func < (lhs: currencyType, rhs: currencyType) -> Bool {
        lhs.stared
    }
    init(price: Double? = nil ,id: String, saved: [String] = []) {
        self.price = price
        self.id = id
        self.name = id.toKr
        self.flag = id.toFlag
        self.currencyName = id.toCurrencyName
        self.stared = saved.contains(where: {$0 == self.id})
    }
    var price: Double? = nil
    var id: String
    var name: String
    var flag: String?
    var currencyName: String
    var stared: Bool = false
    mutating func selection() {
        self.stared = !self.stared
    }
}

enum Currency: String, CaseIterable {
    case AED
    case AFN
    case ALL
    case AMD
    case ANG
    case AOA
    case ARS
    case AUD
    case AWG
    case AZN
    case BAM
    case BBD
    case BDT
    case BGN
    case BHD
    case BIF
    case BMD
    case BND
    case BOB
    case BRL
    case BSD
    case BTC
    case BTN
    case BWP
    case BYN
    case BYR
    case BZD
    case CAD
    case CDF
    case CHF
    case CLP
    case CNY
    case COP
    case CRC
    case CUC
    case CUP
    case CVE
    case CZK
    case DJF
    case DKK
    case DOP
    case DZD
    case EGP
    case ERN
    case ETB
    case EUR
    case FJD
    case FKP
    case FOK
    case GBP
    case GEL
    case GGP
    case GHS
    case GIP
    case GMD
    case GNF
    case GTQ
    case GYD
    case HKD
    case HNL
    case HRK
    case HTG
    case HUF
    case IDR
    case ILS
    case IMP
    case INR
    case IQD
    case IRR
    case ISK
    case JEP
    case JMD
    case JOD
    case JPY
    case KES
    case KGS
    case KHR
    case KID
    case KMF
    case KRW
    case KWD
    case KYD
    case KZT
    case LAK
    case LBP
    case LKR
    case LRD
    case LSL
    case LYD
    case MAD
    case MDL
    case MGA
    case MKD
    case MMK
    case MNT
    case MOP
    case MRU
    case MUR
    case MVR
    case MWK
    case MXN
    case MYR
    case MZN
    case NAD
    case NGN
    case NIO
    case NOK
    case NPR
    case NZD
    case OMR
    case PAB
    case PEN
    case PGK
    case PHP
    case PKR
    case PLN
    case PYG
    case QAR
    case RON
    case RSD
    case RUB
    case RWF
    case SAR
    case SBD
    case SCR
    case SDG
    case SEK
    case SGD
    case SHP
    case SLL
    case SOS
    case SRD
    case SSP
    case STN
    case SYP
    case SZL
    case THB
    case TJS
    case TMT
    case TND
    case TOP
    case TRY
    case TTD
    case TVD
    case TWD
    case TZS
    case UAH
    case UGX
    case USD
    case UYU
    case UZS
    case VES
    case VND
    case VUV
    case WST
    case XAF
    case XCD
    case XDR
    case XOF
    case XPF
    case YER
    case ZAR
    case ZMW
    case ZWL
}
extension String {
    var toKr: String {
        switch self {
        case "AED" : return "아랍에미리트"
        case "AFN" : return "아프가니스탄"
        case "ALL" : return "알바니아"
        case "AMD" : return "아르메니아"
        case "ANG" : return "네덜란드령 안틸레스"
        case "AOA" : return "앙골라"
        case "ARS" : return "아르헨티나"
        case "AUD" : return "호주"
        case "AWG" : return "아루바"
        case "AZN" : return "아제르바이잔"
        case "BAM" : return "보스니아 헤르체고비나"
        case "BBD" : return "바베이도스"
        case "BDT" : return "방글라데시"
        case "BGN" : return "불가리아"
        case "BHD" : return "바레인"
        case "BIF" : return "부룬디"
        case "BMD" : return "버뮤다"
        case "BND" : return "브루나이"
        case "BOB" : return "볼리비아"
        case "BRL" : return "브라질"
        case "BSD" : return "바하마"
        case "BTC" : return "비트코인"
        case "BTN" : return "부탄"
        case "BWP" : return "보츠와나"
        case "BYN" : return "벨라루스"
        case "BYR" : return "벨라루스 (구)"
        case "BZD" : return "벨리즈"
        case "CAD" : return "캐나다"
        case "CDF" : return "콩고 민주 공화국"
        case "CHF" : return "스위스"
        case "CLP" : return "칠레"
        case "CNY" : return "중국"
        case "COP" : return "콜롬비아"
        case "CRC" : return "코스타리카"
        case "CUC" : return "쿠바 (전환 페소)"
        case "CUP" : return "쿠바"
        case "CVE" : return "카보베르데"
        case "CZK" : return "체코"
        case "DJF" : return "지부티"
        case "DKK" : return "덴마크"
        case "DOP" : return "도미니카 공화국"
        case "DZD" : return "알제리"
        case "EGP" : return "이집트"
        case "ERN" : return "에리트레아"
        case "ETB" : return "에티오피아"
        case "EUR" : return "유럽 연합"
        case "FJD" : return "피지"
        case "FKP" : return "포클랜드 제도"
        case "FOK" : return "페로 제도"
        case "GBP" : return "영국"
        case "GEL" : return "조지아"
        case "GGP" : return "건지 섬"
        case "GHS" : return "가나"
        case "GIP" : return "지브롤터"
        case "GMD" : return "감비아"
        case "GNF" : return "기니"
        case "GTQ" : return "과테말라"
        case "GYD" : return "가이아나"
        case "HKD" : return "홍콩"
        case "HNL" : return "온두라스"
        case "HRK" : return "크로아티아"
        case "HTG" : return "아이티"
        case "HUF" : return "헝가리"
        case "IDR" : return "인도네시아"
        case "ILS" : return "이스라엘"
        case "IMP" : return "맨 섬"
        case "INR" : return "인도"
        case "IQD" : return "이라크"
        case "IRR" : return "이란"
        case "ISK" : return "아이슬란드"
        case "JEP" : return "저지 섬"
        case "JMD" : return "자메이카"
        case "JOD" : return "요르단"
        case "JPY" : return "일본"
        case "KES" : return "케냐"
        case "KGS" : return "키르기스스탄"
        case "KHR" : return "캄보디아"
        case "KID" : return "키리바시"
        case "KMF" : return "코모로"
        case "KRW" : return "한국"
        case "KWD" : return "쿠웨이트"
        case "KYD" : return "케이맨 제도"
        case "KZT" : return "카자흐스탄"
        case "LAK" : return "라오스"
        case "LBP" : return "레바논"
        case "LKR" : return "스리랑카"
        case "LRD" : return "라이베리아"
        case "LSL" : return "레소토"
        case "LYD" : return "리비아"
        case "MAD" : return "모로코"
        case "MDL" : return "몰도바"
        case "MGA" : return "마다가스카르"
        case "MKD" : return "북마케도니아"
        case "MMK" : return "미얀마"
        case "MNT" : return "몽골"
        case "MOP" : return "마카오"
        case "MRU" : return "모리타니"
        case "MUR" : return "모리셔스"
        case "MVR" : return "몰디브"
        case "MWK" : return "말라위"
        case "MXN" : return "멕시코"
        case "MYR" : return "말레이시아"
        case "MZN" : return "모잠비크"
        case "NAD" : return "나미비아"
        case "NGN" : return "나이지리아"
        case "NIO" : return "니카라과"
        case "NOK" : return "노르웨이"
        case "NPR" : return "네팔"
        case "NZD" : return "뉴질랜드"
        case "OMR" : return "오만"
        case "PAB" : return "파나마"
        case "PEN" : return "페루"
        case "PGK" : return "파푸아뉴기니"
        case "PHP" : return "필리핀"
        case "PKR" : return "파키스탄"
        case "PLN" : return "폴란드"
        case "PYG" : return "파라과이"
        case "QAR" : return "카타르"
        case "RON" : return "루마니아"
        case "RSD" : return "세르비아"
        case "RUB" : return "러시아"
        case "RWF" : return "르완다"
        case "SAR" : return "사우디아라비아"
        case "SBD" : return "솔로몬 제도"
        case "SCR" : return "세이셸"
        case "SDG" : return "수단"
        case "SEK" : return "스웨덴"
        case "SGD" : return "싱가포르"
        case "SHP" : return "세인트헬레나"
        case "SLL" : return "시에라리온"
        case "SOS" : return "소말리아"
        case "SRD" : return "수리남"
        case "SSP" : return "남수단"
        case "STN" : return "상투메 프린시페"
        case "SYP" : return "시리아"
        case "SZL" : return "에스와티니"
        case "THB" : return "태국"
        case "TJS" : return "타지키스탄"
        case "TMT" : return "투르크메니스탄"
        case "TND" : return "튀니지"
        case "TOP" : return "통가"
        case "TRY" : return "터키"
        case "TTD" : return "트리니다드 토바고"
        case "TVD" : return "투발루"
        case "TWD" : return "대만"
        case "TZS" : return "탄자니아"
        case "UAH" : return "우크라이나"
        case "UGX" : return "우간다"
        case "USD" : return "미국"
        case "UYU" : return "우루과이"
        case "UZS" : return "우즈베키스탄"
        case "VES" : return "베네수엘라"
        case "VND" : return "베트남"
        case "VUV" : return "바누아투"
        case "WST" : return "사모아"
        case "XAF" : return "중앙아프리카 CFA 프랑"
        case "XCD" : return "동카리브 달러"
        case "XDR" : return "특별인출권"
        case "XOF" : return "서아프리카 CFA 프랑"
        case "XPF" : return "CFP 프랑"
        case "YER" : return "예멘"
        case "ZAR" : return "남아프리카 공화국"
        case "ZMW" : return "잠비아"
        case "ZWL" : return "짐바브웨"
        default :
            return self
        }
    }
    var toCurrencyName: String {
        switch self {
        case "AED" : return "디르함"
        case "AFN" : return "아프가니"
        case "ALL" : return "레크"
        case "AMD" : return "드람"
        case "ANG" : return "길더"
        case "AOA" : return "콴자"
        case "ARS" : return "페소"
        case "AUD" : return "달러"
        case "AWG" : return "플로린"
        case "AZN" : return "마나트"
        case "BAM" : return "콘버터블 마르크"
        case "BBD" : return "달러"
        case "BDT" : return "타카"
        case "BGN" : return "레프"
        case "BHD" : return "디나르"
        case "BIF" : return "프랑"
        case "BMD" : return "달러"
        case "BND" : return "달러"
        case "BOB" : return "볼리비아노"
        case "BRL" : return "헤알"
        case "BSD" : return "달러"
        case "BTC" : return "비트코인"
        case "BTN" : return "눌트럼"
        case "BWP" : return "풀라"
        case "BYN" : return "루블"
        case "BYR" : return "루블 (2016년까지)"
        case "BZD" : return "달러"
        case "CAD" : return "달러"
        case "CDF" : return "프랑"
        case "CHF" : return "프랑"
        case "CLP" : return "페소"
        case "CNY" : return "위안"
        case "COP" : return "페소"
        case "CRC" : return "콜론"
        case "CUC" : return "전환 페소"
        case "CUP" : return "페소"
        case "CVE" : return "에스쿠도"
        case "CZK" : return "코루나"
        case "DJF" : return "프랑"
        case "DKK" : return "크로네"
        case "DOP" : return "페소"
        case "DZD" : return "디나르"
        case "EGP" : return "파운드"
        case "ERN" : return "낙파"
        case "ETB" : return "비르"
        case "EUR" : return "유로"
        case "FJD" : return "달러"
        case "FKP" : return "파운드"
        case "FOK" : return "크로네"
        case "GBP" : return "파운드"
        case "GEL" : return "라리"
        case "GGP" : return "파운드"
        case "GHS" : return "세디"
        case "GIP" : return "파운드"
        case "GMD" : return "달라시"
        case "GNF" : return "프랑"
        case "GTQ" : return "케찰"
        case "GYD" : return "달러"
        case "HKD" : return "달러"
        case "HNL" : return "렘피라"
        case "HRK" : return "쿠나"
        case "HTG" : return "구르드"
        case "HUF" : return "포린트"
        case "IDR" : return "루피아"
        case "ILS" : return "셰켈"
        case "IMP" : return "파운드"
        case "INR" : return "루피"
        case "IQD" : return "디나르"
        case "IRR" : return "리얄"
        case "ISK" : return "크로나"
        case "JEP" : return "파운드"
        case "JMD" : return "달러"
        case "JOD" : return "디나르"
        case "JPY" : return "엔"
        case "KES" : return "실링"
        case "KGS" : return "솜"
        case "KHR" : return "리엘"
        case "KID" : return "달러"
        case "KMF" : return "프랑"
        case "KRW" : return "원"
        case "KWD" : return "디나르"
        case "KYD" : return "달러"
        case "KZT" : return "텡게"
        case "LAK" : return "킵"
        case "LBP" : return "파운드"
        case "LKR" : return "루피"
        case "LRD" : return "달러"
        case "LSL" : return "로티"
        case "LYD" : return "디나르"
        case "MAD" : return "디르함"
        case "MDL" : return "레우"
        case "MGA" : return "아리아리"
        case "MKD" : return "데나르"
        case "MMK" : return "차트"
        case "MNT" : return "투그릭"
        case "MOP" : return "파타카"
        case "MRU" : return "우기야"
        case "MUR" : return "루피"
        case "MVR" : return "루피아"
        case "MWK" : return "콰차"
        case "MXN" : return "페소"
        case "MYR" : return "링깃"
        case "MZN" : return "메티칼"
        case "NAD" : return "달러"
        case "NGN" : return "나이라"
        case "NIO" : return "코르도바"
        case "NOK" : return "크로네"
        case "NPR" : return "루피"
        case "NZD" : return "달러"
        case "OMR" : return "리얄"
        case "PAB" : return "발보아"
        case "PEN" : return "솔"
        case "PGK" : return "키나"
        case "PHP" : return "페소"
        case "PKR" : return "루피"
        case "PLN" : return "즈워티"
        case "PYG" : return "과라니"
        case "QAR" : return "리얄"
        case "RON" : return "레우"
        case "RSD" : return "디나르"
        case "RUB" : return "루블"
        case "RWF" : return "프랑"
        case "SAR" : return "리얄"
        case "SBD" : return "달러"
        case "SCR" : return "루피"
        case "SDG" : return "파운드"
        case "SEK" : return "크로나"
        case "SGD" : return "달러"
        case "SHP" : return "파운드"
        case "SLL" : return "리온"
        case "SOS" : return "실링"
        case "SRD" : return "달러"
        case "SSP" : return "파운드"
        case "STN" : return "도브라"
        case "SYP" : return "파운드"
        case "SZL" : return "릴랑게니"
        case "THB" : return "바트"
        case "TJS" : return "소모니"
        case "TMT" : return "마나트"
        case "TND" : return "디나르"
        case "TOP" : return "파앙가"
        case "TRY" : return "리라"
        case "TTD" : return "달러"
        case "TVD" : return "달러"
        case "TW" : return "달러"
        case "TWD" : return "달러"
        case "TZS" : return "실링"
        case "UAH" : return "프리브나"
        case "UGX" : return "실링"
        case "USD" : return "달러"
        case "UYU" : return "페소"
        case "UZS" : return "솜"
        case "VES" : return "볼리바르"
        case "VND" : return "동"
        case "VUV" : return "바투"
        case "WST" : return "탈라"
        case "XAF" : return "CFA 프랑"
        case "XCD" : return "달러"
        case "XDR" : return "특별 인출권"
        case "XOF" : return "CFA 프랑"
        case "XPF" : return "CFP 프랑"
        case "YER" : return "리알"
        case "ZAR" : return "랜드"
        case "ZMW" : return "콰차"
        case "ZWL" : return "달러"
        default :
            return self
        }
    }
    
    var toFlag: String? {
        switch self {
        case "AED" : return "🇦🇪"
        case "AFN" : return "🇦🇫"
        case "ALL" : return "🇦🇱"
        case "AMD" : return "🇦🇲"
        case "ANG" : return "🇨🇼"
        case "AOA" : return "🇦🇴"
        case "ARS" : return "🇦🇷"
        case "AUD" : return "🇦🇺"
        case "AWG" : return "🇦🇼"
        case "AZN" : return "🇦🇿"
        case "BAM" : return "🇧🇦"
        case "BBD" : return "🇧🇧"
        case "BDT" : return "🇧🇩"
        case "BGN" : return "🇧🇬"
        case "BHD" : return "🇧🇭"
        case "BIF" : return "🇧🇮"
        case "BMD" : return "🇧🇲"
        case "BND" : return "🇧🇳"
        case "BOB" : return "🇧🇴"
        case "BRL" : return "🇧🇷"
        case "BSD" : return "🇧🇸"
        case "BTC" : return "🪙"
        case "BTN" : return "🇧🇹"
        case "BWP" : return "🇧🇼"
        case "BYN" : return "🇧🇾"
        case "BYR" : return "🇧🇾"
        case "BZD" : return "🇧🇿"
        case "CAD" : return "🇨🇦"
        case "CDF" : return "🇨🇩"
        case "CHF" : return "🇨🇭"
        case "CLP" : return "🇨🇱"
        case "CNY" : return "🇨🇳"
        case "COP" : return "🇨🇴"
        case "CRC" : return "🇨🇷"
        case "CUC" : return "🇨🇺"
        case "CUP" : return "🇨🇺"
        case "CVE" : return "🇨🇻"
        case "CZK" : return "🇨🇿"
        case "DJF" : return "🇩🇯"
        case "DKK" : return "🇩🇰"
        case "DOP" : return "🇩🇴"
        case "DZD" : return "🇩🇿"
        case "EGP" : return "🇪🇬"
        case "ERN" : return "🇪🇷"
        case "ETB" : return "🇪🇹"
        case "EUR" : return "🇪🇺"
        case "FJD" : return "🇫🇯"
        case "FKP" : return "🇫🇰"
        case "FOK" : return "🇫🇴"
        case "GBP" : return "🇬🇧"
        case "GEL" : return "🇬🇪"
        case "GGP" : return "🇬🇬"
        case "GHS" : return "🇬🇭"
        case "GIP" : return "🇬🇮"
        case "GMD" : return "🇬🇲"
        case "GNF" : return "🇬🇳"
        case "GTQ" : return "🇬🇹"
        case "GYD" : return "🇬🇾"
        case "HKD" : return "🇭🇰"
        case "HNL" : return "🇭🇳"
        case "HRK" : return "🇭🇷"
        case "HTG" : return "🇭🇹"
        case "HUF" : return "🇭🇺"
        case "IDR" : return "🇮🇩"
        case "ILS" : return "🇮🇱"
        case "IMP" : return "🇮🇲"
        case "INR" : return "🇮🇳"
        case "IQD" : return "🇮🇶"
        case "IRR" : return "🇮🇷"
        case "ISK" : return "🇮🇸"
        case "JEP" : return "🇯🇪"
        case "JMD" : return "🇯🇲"
        case "JOD" : return "🇯🇴"
        case "JPY" : return "🇯🇵"
        case "KES" : return "🇰🇪"
        case "KGS" : return "🇰🇬"
        case "KHR" : return "🇰🇭"
        case "KID" : return "🇰🇮"
        case "KMF" : return "🇰🇲"
        case "KRW" : return "🇰🇷"
        case "KWD" : return "🇰🇼"
        case "KYD" : return "🇰🇾"
        case "KZT" : return "🇰🇿"
        case "LAK" : return "🇱🇦"
        case "LBP" : return "🇱🇧"
        case "LKR" : return "🇱🇰"
        case "LRD" : return "🇱🇷"
        case "LSL" : return "🇱🇸"
        case "LYD" : return "🇱🇾"
        case "MAD" : return "🇲🇦"
        case "MDL" : return "🇲🇩"
        case "MGA" : return "🇲🇬"
        case "MKD" : return "🇲🇰"
        case "MMK" : return "🇲🇲"
        case "MNT" : return "🇲🇳"
        case "MOP" : return "🇲🇴"
        case "MRU" : return "🇲🇷"
        case "MUR" : return "🇲🇺"
        case "MVR" : return "🇲🇻"
        case "MWK" : return "🇲🇼"
        case "MXN" : return "🇲🇽"
        case "MYR" : return "🇲🇾"
        case "MZN" : return "🇲🇿"
        case "NAD" : return "🇳🇦"
        case "NGN" : return "🇳🇬"
        case "NIO" : return "🇳🇮"
        case "NOK" : return "🇳🇴"
        case "NPR" : return "🇳🇵"
        case "NZD" : return "🇳🇿"
        case "OMR" : return "🇴🇲"
        case "PAB" : return "🇵🇦"
        case "PEN" : return "🇵🇪"
        case "PGK" : return "🇵🇬"
        case "PHP" : return "🇵🇭"
        case "PKR" : return "🇵🇰"
        case "PLN" : return "🇵🇱"
        case "PYG" : return "🇵🇾"
        case "QAR" : return "🇶🇦"
        case "RON" : return "🇷🇴"
        case "RSD" : return "🇷🇸"
        case "RUB" : return "🇷🇺"
        case "RWF" : return "🇷🇼"
        case "SAR" : return "🇸🇦"
        case "SBD" : return "🇸🇧"
        case "SCR" : return "🇸🇨"
        case "SDG" : return "🇸🇩"
        case "SEK" : return "🇸🇪"
        case "SGD" : return "🇸🇬"
        case "SHP" : return "🇸🇭"
        case "SLL" : return "🇸🇱"
        case "SOS" : return "🇸🇴"
        case "SRD" : return "🇸🇷"
        case "SSP" : return "🇸🇸"
        case "STN" : return "🇸🇹"
        case "SYP" : return "🇸🇾"
        case "SZL" : return "🇸🇿"
        case "THB" : return "🇹🇭"
        case "TJS" : return "🇹🇯"
        case "TMT" : return "🇹🇲"
        case "TND" : return "🇹🇳"
        case "TOP" : return "🇹🇴"
        case "TRY" : return "🇹🇷"
        case "TTD" : return "🇹🇹"
        case "TVD" : return "🇹🇻"
        case "TWD" : return "🇹🇼"
        case "TZS" : return "🇹🇿"
        case "UAH" : return "🇺🇦"
        case "UGX" : return "🇺🇬"
        case "USD" : return "🇺🇸"
        case "UYU" : return "🇺🇾"
        case "UZS" : return "🇺🇿"
        case "VES" : return "🇻🇪"
        case "VND" : return "🇻🇳"
        case "VUV" : return "🇻🇺"
        case "WST" : return "🇼🇸"
        case "XAF" : return "🇨🇫"
        case "XCD" : return "🇦🇮"
        case "XDR" : return "🏦"
        case "XOF" : return "🇧🇫"
        case "XPF" : return "🇵🇫"
        case "YER" : return "🇾🇪"
        case "ZAR" : return "🇿🇦"
        case "ZMW" : return "🇿🇲"
        case "ZWL" : return "🇿🇼"
        default :
            return nil
        }
    }
    
}
//MARK: - 한글 은는이가 자연스럽게 적용하기
extension String{
    func hasLastWordBatchimKR() -> Bool {
        guard let lastText = self.last else { return false}
        let unicodeVal = UnicodeScalar(String(lastText))?.value
        guard let value = unicodeVal else { return false }
        if (value < 0xAC00 || value > 0xD7A3) { return false }
        let last = (value - 0xAC00) % 28
        return last > 0
    }
    func addYi() -> String {
        let str = self.hasLastWordBatchimKR() ? "이" : ""
        return self + str
    }
    func addUl() -> String {
        let str = self.hasLastWordBatchimKR() ? "을" : "를"
        return self + str
    }
    func addUn() -> String {
        let str = self.hasLastWordBatchimKR() ? "은" : "는"
        return self + str
    }
    func addRo() -> String {
        let str = self.hasLastWordBatchimKR() ? "으로" : "로"
        return self + str
    }
    func getProfileImageUID() -> String {
        var str = self.components(separatedBy: "images%2F")[1]
        str = str.components(separatedBy: "?")[0]
        return str
    }
}
