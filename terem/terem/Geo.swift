//
//  Geo.swift
//  terem
//
//  Created by svitlana vykhor on 26/01/2020.
//  Copyright © 2020 svitlana vykhor. All rights reserved.
//
import MapKit
import AddressBook
import SwiftyJSON
import Alamofire

class Element{
    var title: String = ""
    var selected: Bool

    init(_ t: String) {
        self.title = t
        self.selected = true
    }

    init(_ t: String, s: Bool) {
        self.title = t
        self.selected = s
    }
}

extension Element: Equatable {
    static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.title == rhs.title
    }
}

var Countries: [String: String] = ["Andorra": "AD",
            "United Arab Emirates": "AE",
            "Afghanistan": "AF",
            "Antigua and Barbuda": "AG",
            "Anguilla": "AI",
            "Albania": "AL",
            "Armenia": "AM",
            "Netherlands Antilles": "AN",
            "Angola": "AO",
            "Antarctica": "AQ",
            "Argentina": "AR",
            "American Samoa": "AS",
            "Austria": "AT",
            "Australia": "AU",
            "North of Macquarie Island": "AU",
            "Aruba": "AW",
            "Åland": "AX",
            "Azerbaijan": "AZ",
            "Bosnia and Herzegovina": "BA",
            "Barbados": "BB",
            "Bangladesh": "BD",
            "Belgium": "BE",
            "Burkina Faso": "BF",
            "Bulgaria": "BG",
            "Bahrain": "BH",
            "Burundi": "BI",
            "Benin": "BJ",
            "Saint Barthélemy": "BL",
            "Bermuda": "BM",
            "Brunei": "BN",
            "Bolivia": "BO",
            "Bonaire, Sint Eustatius, and Saba": "BQ",
            "Brazil": "BR",
            "Bahamas": "BS",
            "Bhutan": "BT",
            "Bouvet Island": "BV",
            "Botswana": "BW",
            "Belarus": "BY",
            "Belize": "BZ",
            "Canada": "CA",
            "Cocos [Keeling] Islands": "CC",
            "DR Congo": "CD",
            "Central African Republic": "CF",
            "Congo Republic": "CG",
            "Switzerland": "CH",
            "Ivory Coast": "CI",
            "Cook Islands": "CK",
            "Chile": "CL",
            "Cameroon": "CM",
            "China": "CN",
            "Colombia": "CO",
            "Costa Rica": "CR",
            "Serbia and Montenegro": "CS",
            "Cuba": "CU",
            "Cabo Verde": "CV",
            "Curaçao": "CW",
            "Christmas Island": "CX",
            "Cyprus": "CY",
            "Czechia": "CZ",
            "Germany": "DE",
            "Djibouti": "DJ",
            "Denmark": "DK",
            "Dominica": "DM",
            "Dominican Republic": "DO",
            "Algeria": "DZ",
            "Ecuador": "EC",
            "Estonia": "EE",
            "Egypt": "EG",
            "Western Sahara": "EH",
            "Eritrea": "ER",
            "Spain": "ES",
            "Drake Passage": "ES",
            "Ethiopia": "ET",
            "Finland": "FI",
            "Fiji": "FJ",
            "Falkland Islands": "FK",
            "Micronesia": "FM",
            "Faroe Islands": "FO",
            "France": "FR",
            "Gabon": "GA",
            "United Kingdom": "GB",
            "Grenada": "GD",
            "Georgia": "GE",
            "French Guiana": "GF",
            "Guernsey": "GG",
            "Ghana": "GH",
            "Gibraltar": "GI",
            "Greenland": "GL",
            "Gambia": "GM",
            "Guinea": "GN",
            "Guadeloupe": "GP",
            "Equatorial Guinea": "GQ",
            "Greece": "GR",
            "South Georgia and South Sandwich Islands": "GS",
            "South Sandwich Islands": "GS",
            "Guatemala": "GT",
            "Guam": "GU",
            "Guinea-Bissau": "GW",
            "Guyana": "GY",
            "Hong Kong": "HK",
            "Heard Island and McDonald Islands": "HM",
            "Honduras": "HN",
            "Croatia": "HR",
            "Haiti": "HT",
            "Hungary": "HU",
            "Indonesia": "ID",
            "Ireland": "IE",
            "Israel": "IL",
            "Isle of Man": "IM",
            "India": "IN",
            "British Indian Ocean Territory": "IO",
            "Iraq": "IQ",
            "Iran": "IR",
            "Iceland": "IS",
            "Reykjanes Ridge": "IS",
            "Italy": "IT",
            "Jersey": "JE",
            "Jamaica": "JM",
            "Jordan": "JO",
            "Japan": "JP",
            "Kenya": "KE",
            "Kyrgyzstan": "KG",
            "Cambodia": "KH",
            "Kiribati": "KI",
            "Comoros": "KM",
            "St Kitts and Nevis": "KN",
            "North Korea": "KP",
            "South Korea": "KR",
            "Kuwait": "KW",
            "Cayman Islands": "KY",
            "Kazakhstan": "KZ",
            "Laos": "LA",
            "Lebanon": "LB",
            "Saint Lucia": "LC",
            "Liechtenstein": "LI",
            "Sri Lanka": "LK",
            "Liberia": "LR",
            "Lesotho": "LS",
            "Lithuania": "LT",
            "Luxembourg": "LU",
            "Latvia": "LV",
            "Libya": "LY",
            "Morocco": "MA",
            "Monaco": "MC",
            "Moldova": "MD",
            "Montenegro": "ME",
            "Saint Martin": "MF",
            "Madagascar": "MG",
            "Marshall Islands": "MH",
            "North Macedonia": "MK",
            "Mali": "ML",
            "Myanmar": "MM",
            "Burma": "MM",
            "Mongolia": "MN",
            "Macao": "MO",
            "Northern Mariana Islands": "MP",
            "Martinique": "MQ",
            "Mauritania": "MR",
            "Montserrat": "MS",
            "Malta": "MT",
            "Mauritius": "MU",
            "Maldives": "MV",
            "Malawi": "MW",
            "Mexico": "MX",
            "Malaysia": "MY",
            "Mozambique": "MZ",
            "Namibia": "NA",
            "New Caledonia": "NC",
            "Niger": "NE",
            "Norfolk Island": "NF",
            "Nigeria": "NG",
            "Nicaragua": "NI",
            "Netherlands": "NL",
            "Norway": "NO",
            "Nepal": "NP",
            "Nauru": "NR",
            "Niue": "NU",
            "New Zealand": "NZ",
            "Oman": "OM",
            "Panama": "PA",
            "Peru": "PE",
            "French Polynesia": "PF",
            "Papua New Guinea": "PG",
            "Philippines": "PH",
            "Pakistan": "PK",
            "Poland": "PL",
            "Saint Pierre and Miquelon": "PM",
            "Pitcairn Islands": "PN",
            "Puerto Rico": "PR",
            "Palestine": "PS",
            "Portugal": "PT",
            "Palau": "PW",
            "Paraguay": "PY",
            "Qatar": "QA",
            "Réunion": "RE",
            "Romania": "RO",
            "Serbia": "RS",
            "Russia": "RU",
            "Kuril Islands": "RU",
            "Rwanda": "RW",
            "Saudi Arabia": "SA",
            "Solomon Islands": "SB",
            "Seychelles": "SC",
            "Sudan": "SD",
            "Sweden": "SE",
            "Singapore": "SG",
            "Saint Helena": "SH",
            "Slovenia": "SI",
            "Svalbard and Jan Mayen": "SJ",
            "Slovakia": "SK",
            "Sierra Leone": "SL",
            "San Marino": "SM",
            "Senegal": "SN",
            "Somalia": "SO",
            "Suriname": "SR",
            "South Sudan": "SS",
            "São Tomé and Príncipe": "ST",
            "El Salvador": "SV",
            "Sint Maarten": "SX",
            "Syria": "SY",
            "Eswatini": "SZ",
            "Turks and Caicos Islands": "TC",
            "Chad": "TD",
            "French Southern Territories": "TF",
            "Togo": "TG",
            "Thailand": "TH",
            "Tajikistan": "TJ",
            "Tokelau": "TK",
            "Timor-Leste": "TL",
            "Turkmenistan": "TM",
            "Tunisia": "TN",
            "Tonga": "TO",
            "Turkey": "TR",
            "Trinidad and Tobago": "TT",
            "Tuvalu": "TV",
            "Taiwan": "TW",
            "Tanzania": "TZ",
            "Ukraine": "UA",
            "Uganda": "UG",
            "U.S. Minor Outlying Islands": "UM",
            "United States": "US",
            "Uruguay": "UY",
            "Uzbekistan": "UZ",
            "Vatican City": "VA",
            "St Vincent and Grenadines": "VC",
            "Venezuela": "VE",
            "British Virgin Islands": "VG",
            "U.S. Virgin Islands": "VI",
            "Vietnam": "VN",
            "Vanuatu": "VU",
            "Vanuatu region": "VU",
            "Wallis and Futuna": "WF",
            "Samoa": "WS",
            "Kosovo": "XK",
            "Yemen": "YE",
            "Mayotte": "YT",
            "South Africa": "ZA",
            "Zambia": "ZM",
            "Zimbabwe": "ZW",
            "MX": "US",
            "AL": "US", "AK": "US", "AZ": "US", "AR": "US", "CA": "US", "CO": "US", "CT": "US", "DE": "US", "FL": "US", "GA": "US", "HI": "US", "ID": "US", "IL": "US", "IN": "US", "IA": "US", "KS": "US", "KY": "US", "LA": "US", "ME": "US", "MD": "US", "MA": "US", "MI": "US", "MN": "US", "MS": "US", "MO": "US", "MT": "US", "NE": "US", "NV": "US", "NH": "US", "NJ": "US", "NM": "US", "NY": "US", "NC": "US", "ND": "US", "OH": "US", "OK": "US", "OR": "US", "PA": "US", "RI": "US", "SC": "US", "SD": "US", "TN": "US", "TX": "US", "UT": "US", "VT": "US", "VA": "US", "WA": "US", "WV": "US", "WI": "US", "WY": "US",
            "Alabama": "AL", "Alaska": "AK", "Arizona": "AZ", "Arkansas": "AR", "California": "CA", "Colorado": "CO", "Connecticut": "CT", "Delaware": "DE", "Florida": "FL", "Hawaii": "HI", "Idaho": "ID", "Illinois": "IL", "Indiana": "IN", "Iowa": "IA", "Kansas": "KS", "Kentucky": "KY", "Louisiana": "LA", "Maine": "ME", "Maryland": "MD", "Massachusetts": "MA", "Michigan": "MI", "Minnesota": "MN", "Mississippi": "MS", "Missouri": "MO", "Montana": "MT", "Nebraska": "NE", "Nevada": "NV", "New Hampshire": "NH", "New Jersey": "NJ", "New Mexico": "NM", "New York": "NY", "North Carolina": "NC", "North Dakota": "ND", "Ohio": "OH", "Oklahoma": "OK", "Oregon": "OR", "Pennsylvania": "PA", "Rhode Island": "RI", "South Carolina": "SC", "South Dakota": "SD", "Tennessee": "TN", "Texas": "TX", "Utah": "UT", "Vermont": "VT", "Virginia": "VA", "Washington": "WA", "West Virginia": "WV", "Wisconsin": "WI", "Wyoming": "UA",
            "": "US",]

var CategoriaMag: [Element] = [Element("< 2.5"), Element("2.5 - 4.5"),  Element("> 4.5")]
var Pais: [Element] = []
var infoArray: [Geo] = []
var data: [Geo] = []

class Geo: NSObject, MKAnnotation
{
    let title: String?  // properties/title
    let locationName: String?  // properties/place
    let date: Date?  // properties/time
    let mag: Double? // properties/mag
    let coordinate: CLLocationCoordinate2D
    
    var pais: String? = nil
    
    init(title: String, locationName: String, date: Date?, mag: Double?, coordinate:CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.date = date
        self.mag = mag
        self.coordinate = coordinate
        
        let ts = locationName.components(separatedBy: ",")
        let a: String = ts.last ?? ""
        let p = Countries[a.trimmingCharacters(in: .whitespacesAndNewlines)]
        self.pais = p
        
        if (p != nil && p != "" && !Pais.contains(Element(p!))) {
            Pais.append(Element(p!))
        }

        super.init()
    }
    
    func getMag() -> String {
        if self.mag != nil {
            switch (self.mag!) {
            case ...2.5:
                return CategoriaMag[0].title
            case 2.5...4.5:
                return CategoriaMag[1].title
            case 4.5...:
                return CategoriaMag[2].title
            default:
                return CategoriaMag[0].title
            }
        }
        return CategoriaMag[0].title
    }
    
    var subtitle: String? {
        return locationName
    }

    func show() -> Bool {
        var s: Bool = true
        
        if(self.pais != nil) {
            let indP = Pais.firstIndex(of: Element(self.pais!))
            if(self.pais != nil && Pais[indP!].selected == false) {
                s = false
            }
        }

        let indM = CategoriaMag.firstIndex(of: Element(self.getMag()))
        if(indM == nil){
            return false
        }

        if(s && CategoriaMag[indM!].selected == false) {
            s = false
        }
        return s
    }
}

