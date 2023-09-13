import Foundation
import SwiftyPyRegex
import SwiftyPyString

public class Emoji: Normalizer {
    public let emoji_reg = try! NSRegularExpression(pattern: "[\\U000000a9\\U000000ae\\U0000200d\\U0000203c\\U00002049\\U000020e3\\U00002122\\U00002139\\U00002194-\\U00002199\\U000021a9\\U000021aa\\U0000231a\\U0000231b\\U00002328\\U000023cf\\U000023e9\\U000023ea-\\U000023fa\\U000024c2\\U000025aa\\U000025ab\\U000025b6\\U000025c0\\U000025fb-\\U000025fe\\U00002600-\\U00002604\\U0000260e\\U00002611\\U00002614\\U00002615\\U00002618\\U0000261d\\U00002620\\U00002622\\U00002623\\U00002626\\U0000262a\\U0000262e\\U0000262f\\U00002638\\U00002639\\U0000263a\\U00002640\\U00002642\\U00002648\\U00002649\\U0000264a-\\U00002653\\U0000265f\\U00002660\\U00002663\\U00002665\\U00002666\\U00002668\\U0000267b\\U0000267e\\U0000267f\\U00002692-\\U00002697\\U00002699\\U0000269b\\U0000269c\\U000026a0\\U000026a1\\U000026a7\\U000026aa\\U000026ab\\U000026b0\\U000026b1\\U000026bd\\U000026be\\U000026c4\\U000026c5\\U000026c8\\U000026ce\\U000026cf\\U000026d1\\U000026d3\\U000026d4\\U000026e9\\U000026ea\\U000026f0-\\U000026fa\\U000026fd\\U00002702\\U00002705\\U00002708\\U00002709\\U0000270a\\U0000270b-\\U0000270f\\U00002712\\U00002714\\U00002716\\U0000271d\\U00002721\\U00002728\\U00002733\\U00002734\\U00002744\\U00002747\\U0000274c\\U0000274e\\U00002753-\\U00002763\\U00002764\\U00002795-\\U00002797\\U000027a1\\U000027b0\\U000027bf\\U00002934\\U00002935\\U00002b05-\\U00002b07\\U00002b1b\\U00002b1c\\U00002b50\\U00002b55\\U00003030\\U0000303d\\U00003297\\U00003299\\U0000fe0f\\U0001f004\\U0001f0cf\\U0001f170\\U0001f171\\U0001f17e\\U0001f17f\\U0001f18e\\U0001f191-\\U0001f19a\\U0001f1e6-\\U0001f202\\U0001f21a\\U0001f22f\\U0001f232-\\U0001f23a\\U0001f250\\U0001f251\\U0001f300-\\U0001f321\\U0001f324-\\U0001f393\\U0001f396\\U0001f397\\U0001f399-\\U0001f39b\\U0001f39e-\\U0001f3f0\\U0001f3f3-\\U0001f3f5\\U0001f3f7-\\U0001f3fa\\U0001f400-\\U0001f53d\\U0001f549-\\U0001f54e\\U0001f550-\\U0001f567\\U0001f56f\\U0001f570\\U0001f573-\\U0001f57a\\U0001f587\\U0001f58a-\\U0001f58d\\U0001f590\\U0001f595\\U0001f596\\U0001f5a4\\U0001f5a5\\U0001f5a8\\U0001f5b1\\U0001f5b2\\U0001f5bc\\U0001f5c2\\U0001f5c3\\U0001f5c4\\U0001f5d1\\U0001f5d2\\U0001f5d3\\U0001f5dc\\U0001f5dd\\U0001f5de\\U0001f5e1\\U0001f5e3\\U0001f5e8\\U0001f5ef\\U0001f5f3\\U0001f5fa\\U0001f5fb-\\U0001f64f\\U0001f680-\\U0001f6c5\\U0001f6cb-\\U0001f6d2\\U0001f6d5-\\U0001f6d7\\U0001f6dd-\\U0001f6e5\\U0001f6e9\\U0001f6eb\\U0001f6ec\\U0001f6f0\\U0001f6f3-\\U0001f6fc\\U0001f7e0-\\U0001f7eb\\U0001f7f0\\U0001f90c-\\U0001f93c\\U0001f93d-\\U0001f9ff\\U0001fa70-\\U0001fa74\\U0001fa78-\\U0001fa7c\\U0001fa80-\\U0001fa86\\U0001fa90-\\U0001faac\\U0001fab0-\\U0001faba\\U0001fac0-\\U0001fac5\\U0001fad0-\\U0001fad9\\U0001fae0-\\U0001fae7\\U0001faf0-\\U0001faf6\\U000e0062\\U000e0063\\U000e0065\\U000e0067\\U000e006c\\U000e006e\\U000e0073\\U000e0074\\U000e0077]")
    init(_ emojis_json: String) {
        let json = try! JSONSerialization.jsonObject(with: emojis_json.data(using: .utf8)!, options: []) as! [String: String]
        emoji_description_map = json
        super.init()
    }

    public var emoji_description_map: [String: String]

    override public func callAsFunction(_ input_text: [String: Any]) -> [String: Any] {
        var input_text = input_text
        let text = input_text["text"] as! String
        if input_text["read_emojis"] as? Bool ?? true {
            // let matches = emoji_reg.matches(in: text , range: NSRange(text.startIndex..., in: text)).filter{Range($0.range, in: text) ?? nil != nil}.map({String(text[Range($0.range, in: text)!])})
            // let matches = re.findall(emoji_reg, text).map({$0.group(0)!})
            let scalars = text.unicodeScalars.map {emoji_description_map[String($0)] == nil ? String($0) : " \(emoji_description_map[String($0)]!) "}.reduce("") {$0 + $1}
            input_text["text"] = String(scalars)
            // var desc = ""
            // for match in matches.reversed() {
            //     if emoji_description_map.keys.contains(match) {
            //         desc = emoji_description_map[match]!
            //     }

            //     if desc.count > 0 {
            //         let index = text.find(match)
            //         if index != 0 && text[index - 1, index] != " " && desc[1, 2] != " " {
            //             desc = " " + desc
            //         }
            //         if index != text.count - 1 && text[index + 1, index + 2] != " " {
            //             desc = desc + " "
            //         }
            //     }

            //     text = text.replace(match, new: desc, count: 1)
            // }
        }

        return input_text
    }
}
