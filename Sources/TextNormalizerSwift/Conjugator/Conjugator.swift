import Foundation
import SwiftyPyRegex
public class Conjugator {
    public let conjugations: [String: Any]
    public let categories: [String: [String: [String]]]
    public let word_lists: [String: [String]]

    public init(_ conjugatorFile: String) {
        guard let url = Bundle.module.url(forResource: conjugatorFile, withExtension: "") else {
            fatalError()
        }
        let data = try! Data(contentsOf: url)
        let json: [String: Any] = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        conjugations = json["conjugations"] as! [String: Any]
        categories = json["categories"] as! [String: [String: [String]]]
        word_lists = json["word_lists"] as! [String: [String]]
        let foreign_letters_str = (categories["consonants"]!["foreign"]!).joined()
        let all_vowels_str = (categories["vowels"]!["all"]! + categories["vowels"]!["y_vowels"]!).joined()
        let vowels_str = (categories["vowels"]!["all"]!).joined()
        let vocalized_str = (categories["consonants"]!["vocalized"]!).joined()
        let non_vocalized_str = (categories["consonants"]!["nonvocalized"]!).joined()

        _conjregs = [
            re.compile("[\(foreign_letters_str)]"),
            re.compile("[\(vocalized_str)]$"),
            re.compile("[\(non_vocalized_str)]$"),
            re.compile("[\(non_vocalized_str)][\(vowels_str)][ж|ч|ш|д]$"),
            re.compile("[\(all_vowels_str)]"),
            re.compile("ь|ъ$"),
            re.compile("([\(non_vocalized_str)][\(vowels_str)])(л|р)$"),
        ]
    }

    public let _conjregs: [re.RegexObject]

    func determine_conj_operation(_ word: String) -> String {
        if re.findall(_conjregs[0], word).count > 0 || word_lists["foreign_words"]!.contains(word) {
            return "conj_foreign_word"
        } else if re.findall(_conjregs[5], word).count > 0 {
            return "conj_soft_sign_ending"
        } else if re.findall(_conjregs[1], word).count > 0 {
            return "conj_vocalized_ending"
        } else if re.findall(_conjregs[2], word).count > 0 {
            if re.findall(_conjregs[3], word).count > 0 {
                return "conj_non_vocalized_d_ending"
            } else {
                return "conj_non_vocalized_ending"
            }
        } else if re.findall(_conjregs[4], word).count > 0 {
            return "conj_vowel_ending"
        } else {
            return "conj_foreign_word"
        }
    }

    func conjugate(_ word: String, _ suffix: String) throws -> String {
        let conj_operation = determine_conj_operation(word)
        if ConjUtils.check_is_foreign(word, conj_operation) {
            switch conj_operation {
            case "conj_foreign_word":
                return try ConjFunctions.conj_foreign_word(word, suffix, categories, word_lists)

            default:
                return word
            }
        } else {
            switch conj_operation {
            case "conj_vocalized_ending":
                return try ConjFunctions.conj_vocalized_ending(word, suffix, categories, _conjregs[6])

            case "conj_non_vocalized_ending":
                return try ConjFunctions.conj_non_vocalized_ending(word, suffix, categories)

            case "conj_non_vocalized_d_ending":
                return try ConjFunctions.conj_non_vocalized_d_ending(word, suffix, categories)

            case "conj_vowel_ending":
                return try ConjFunctions.conj_vowel_ending(word, suffix, categories)

            case "conj_soft_sign_ending":
                return try ConjFunctions.conj_soft_sign_ending(word, suffix, categories)

            default:
                return word
            }
        }
    }

    func get_suffixes(_ word: String, _ code: String, _ is_foreign: Bool) throws -> [String] {
        let conjugations = self.conjugations as [String: Any]
        var (code_str, endswith) = try ConjUtils.generate_code_string(word, categories, word_lists, is_foreign)
        let codes = conjugations[code] as! [String: Any]
        if !codes.keys.contains(code_str) {
            code_str = code_str.replace("endswith=\(endswith)&", new: "")
        }

        let conjs = codes[code_str.trimmingCharacters(in: .whitespacesAndNewlines)] as! [String: Any]

        var suffixes = conjs["default"] as! [String]

        if conjs.keys.contains("special") {
            for sp_obj in conjs["special"] as! [[String: Any]] {
                if sp_obj.keys.contains("replace") {
                    let provides_cond_ = try ConjDetection.provides_condition(word, sp_obj, categories, word_lists, is_foreign)
                    if provides_cond_ {
                        for suffix_to_replace in sp_obj["replace"] as! [String] {
                            if suffixes.contains(suffix_to_replace) {
                                let i = suffixes.firstIndex(of: suffix_to_replace)!
                                suffixes[i] = sp_obj["suffix"] as! String
                            }
                        }
                    }
                }
            }
        }
        return suffixes
    }

    func form_conjugations(_ word: String, _ code: String) throws -> [String] {
        let _code = code.uppercased()
        var _word = word
        guard let _allconsonants = categories["consonants"]?["all"] else {
            throw "allconsonants"
        }

        guard let _all_vowels = categories["vowels"]?["all"] else {
            throw "allvowels"
        }
        if _code[0, 1] == "v" {
            _word = ConjUtils.to_imperative(_word, _allconsonants, _all_vowels)
        }

        let conj_operation = determine_conj_operation(_word)
        let is_foreign = ConjUtils.check_is_foreign(_word, conj_operation)

        let suffixes = try get_suffixes(_word, _code, is_foreign)
        var variations: [String] = []

        for suffix in suffixes {
            variations.append(try conjugate(_word, suffix))
        }

        return variations
    }
}
