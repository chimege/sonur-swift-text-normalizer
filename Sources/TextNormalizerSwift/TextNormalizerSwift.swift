import Foundation
@_exported import libespeak_ng
@_exported import libsonic

public class TextNormalizerSwift {
    let tts_normalizers: [Normalizer]
    public static func fileContentByName(_ name: String) -> String {
        var content = ""
        autoreleasepool {
            let bundle = Bundle.module
            let path = bundle.path(forResource: name, ofType: nil)
            content = try! String(contentsOfFile: path!, encoding: .utf8)
        }
       
        return content
    }

    public func fill_details(_ options: [String: Any]) -> [String: Any] {
        var options = options
        default_options.keys.forEach { key in
            if options[key] ?? nil == nil {
                options[key] = default_options[key]
            }
        }

        return options
    }

    public let default_options: [String: Any]
    public init() {
        let emoji_list = TextNormalizerSwift.fileContentByName("emoji_list.json")
        let abbreviation_file = TextNormalizerSwift.fileContentByName("m_abbrev.csv")
        let symbols_file = TextNormalizerSwift.fileContentByName("symbols.json")
        let config_file = TextNormalizerSwift.fileContentByName("config.json")
        let conf = try! JSONSerialization.jsonObject(with: config_file.data(using: .utf8)!, options: []) as! [String: Any]
        let config = conf["initial_config"] as! [String: Any]
        default_options = conf["default_options"] as! [String: Any]

        let conjugator_json_file = config["noun_conj"] as! String
        let conjugator = Conjugator(conjugator_json_file)
        let emo_replacer = Emoji(emoji_list)
        let prep = PreProcessor()
        let phonemizer = Phonemizer()
        let abbreviation = Abbreviations(abbreviation_file, conjugator)
        let numeric = Numeric(conjugator)
        let postp = PostProcessor(symbols_file)
        let sentence_splitter = Splitter(symbols_file, conjugator)
        tts_normalizers = [emo_replacer, prep, phonemizer, abbreviation, numeric, postp, sentence_splitter]
    }

    public func text_with_default_options(_ text: String) -> [String: Any] {
        let data = ["text": text]
        return fill_details(data)
    }

    public func normalize_tts_text(_ input_text: [String: Any]) throws -> [String] {
        // NSLog("Text normalizer: \(input_text)")
        var input_text = input_text
        for normalizer in tts_normalizers {
            input_text = try normalizer(input_text)
        }
        let result = input_text["new_sentences"] as! [String]
        // NSLog("Text normalizer result: \(result)")
        return result
    }
}
