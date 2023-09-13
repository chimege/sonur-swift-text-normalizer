import Foundation
import SwiftyPyRegex
import SwiftyPyString

public class PreProcessor: Normalizer {
    override init() {
        super.init()
    }

    override public func callAsFunction(_ input_text: [String: Any]) throws -> [String: Any] {
        var text = input_text["text"] as! String
        var input_text = input_text
        if input_text["read_balarhai_egshig_clearly"] as! Bool {
            let options: NSRegularExpression.Options = [.caseInsensitive]

            let masc_vowels = ["а", "у", "о", "и"]

            let replace12435: (_ m: re.MatchObject) -> String = { m in
                if m.group(2)! == "г" && masc_vowels.contains(m.group(1)!) && masc_vowels.contains(m.group(4)!) {
                    return m.group(1)! + m.group(2)! + m.group(3)! + m.group(5)!
                } else {
                    return m.group(1)! + m.group(2)! + m.group(4)! + m.group(3)! + m.group(5)!
                }
            }
            let replace124358: (_ m: re.MatchObject) -> String = { m in
                if m.group(2)! == "г" && masc_vowels.contains(m.group(1)!) && masc_vowels.contains(m.group(4)!) {
                    return m.group(1)! + m.group(2)! + m.group(3)! + m.group(5)! + m.group(8)!
                } else {
                    return m.group(1)! + m.group(2)! + m.group(4)! + m.group(3)! + m.group(5)! + m.group(8)!
                }
            }

            let replace124: (_ m: re.MatchObject) -> String = { m in
                m.group(1)! + m.group(2)! + m.group(4)!
            }

            let replace1246: (_ m: re.MatchObject) -> String = { m in
               return m.group(1)! + m.group(2)! + m.group(4)! + m.group(6)!
            }

            text = re.sub("([а-яөүё])([а-яөүё])([л])([аэоуө])([с]\\4[н])", replace12435, text, 0, flags: options)
            text = re.sub("([а-яөүё])([а-яөүё])([л])([аэоуө])([л]\\4\\4)", replace12435, text, 0, flags: options)
            text = re.sub("([а-яөүё])([г][ү])(й) ([э]{2})\\b", replace124, text, 0, flags: options)
            text = re.sub("([а-яөүё])([а-яөүё])([л])([аэоуө])([л](уу|үү)[д])", replace12435, text, 0, flags: options)
            text = re.sub("([а-яөүё])([а-яөүё])([л])([аэоуө])([ж][аэоу]{2})", replace12435, text, 0, flags: options)
            text = re.sub("([а-яөүё])([а-яөүё])([л])([аэоуө])([д]\\4[г])", replace12435, text, 0, flags: options)
            text = re.sub("([а-яөүё])([а-яөүё])([л])([аэоуө])([н])(\\4)( )(уу|үү)\\b", replace124358, text, 0, flags: options)
            text = re.sub("([а-яөүё])([а-яөүё])([л])([аэоуө])([х]\\4[д])", replace12435, text, 0, flags: options)
            text = re.sub("([а-яөүё])([а-яөүё])([н])([аэоуө])([ч][л]\\4[х])", replace12435, text, 0, flags: options)
            text = re.sub("([а-яөүё])([л])([аэоуө])([л](ы|ий)[н])", replace124, text, 0, flags: options)
            text = re.sub("([а-яөүё])([а-яөүё])([л])([аэоуө])([с][н]\\4\\4[р])", replace12435, text, 0, flags: options)
            text = re.sub("([а-яөүё])([а-яөүё])([л])([аэоуө])([с][н](ы|ий))", replace12435, text, 0, flags: options)
            text = re.sub("([а-яөүё])([а-яөүё])([л])([аэоуө])([с]\\4\\4[р])", replace12435, text, 0, flags: options)
            text = re.sub("([а-яөүё])([л])([аэоуө])(дгийг)", replace124, text, 0, flags: options)
            text = re.sub("([а-яөүё])(ын|ийн)( )(уу|үү)\\b", replace124, text, 0, flags: options)
            text = re.sub("([а-яөүё])([с])([аэоуө])([н])( )(уу|үү)\\b", replace1246, text, 0, flags: options)
            text = re.sub("([а-яөүё])([аэоуө][н])( )(уу|үү)\\b", replace124, text, 0, flags: options)
        }

        text = text.replace("Щ", new: "Ш").replace("щ", new: "ш")
        text = re.sub("[\"`”“‘’]", "'", text)
        text = re.sub("[^А-ЯӨҮЁа-яөүёA-Za-z0-9!\'(),\\.:;\\?\\ \\-°$₮¥€£%¢+*~&()#=%№@<>\\[\\]{}\\|~№/\n]", " ", text)
        input_text["text"] = text
        return input_text
    }
}
