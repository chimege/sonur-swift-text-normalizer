import SwiftyPyRegex
import SwiftyPyString

public enum ConjFunctions {
    public static let conjfunctions_reg = [
        re.compile("[өёүаеиоуэюя]"),
    ]
    public static func conj_long_vowel_ending(_ word: String, _ suffix: String, _ categories: [String: [String: [String]]]) throws -> String {
        guard let vowels = categories["vowels"]?["all"] else {
            throw "all vowels"
        }
        var conjugated: String
        if suffix.startswith(vowels) {
            conjugated = "\(word)г\(suffix)"
        } else {
            conjugated = word + suffix
        }

        return conjugated
    }

    public static func conj_vowel_ending(_ word: String, _ suffix: String, _ categories: [String: [String: [String]]]) throws -> String {
        guard var long_vowels = categories["vowels"]?["long"] else {
            throw "long vowels"
        }
        long_vowels += ["ий"]
        guard let gliding_vowels = categories["vowels"]?["gliding"] else {
            throw "gliding vowels"
        }

        guard let y_vowels = categories["vowels"]?["y_vowels"] else {
            throw " y_vowels"
        }
        guard let consonants = categories["consonants"]?["all"] else {
            throw "consonants"
        }

        var conjugated: String
        if word.endswith(y_vowels) && suffix.startswith(long_vowels) {
            if suffix.startswith("ий") {
                conjugated = word + suffix
            } else {
                conjugated = word + suffix[1, suffix.count]
            }
        } else if word.endswith(long_vowels + gliding_vowels) && suffix.startswith(long_vowels) {
            conjugated = "\(word)г\(suffix)"
        } else if word.count > 1 && consonants.contains(word[-2, -1]) && suffix.startswith(long_vowels) || suffix.startswith(gliding_vowels) {
            if suffix[0, 1] == "ы" || suffix[0, 2] == "ий" {
                conjugated = word[0, -1] + suffix
            } else {
                conjugated = word + suffix[1, suffix.count]
            }
        } else {
            conjugated = word + suffix
        }
        return conjugated
    }

    public static func conj_vocalized_ending(_ word: String, _ suffix: String, _ categories: [String: [String: [String]]], _ conj_vocalized_ending_regex: re.RegexObject) throws -> String {
        var conjugated: String

        guard let consonants = categories["consonants"]?["all"] else {
            throw "all consonants"
        }
        guard let vocalized = categories["consonants"]?["vocalized"] else {
            throw "vocalized consonants"
        }

        guard let non_vocalized = categories["consonants"]?["nonvocalized"] else {
            throw "non-vocalized consonants"
        }
        guard var vowels = categories["vowels"]?["all"] else {
            throw "all vowels "
        }
        vowels += ["ы"]
        guard let y_vowels = categories["vowels"]?["y_vowels"] else {
            throw "y_vowels"
        }

        var l_r_ending = false

        let hassan = word[0, -2] + word[-1, word.count]
        if re.findall(conj_vocalized_ending_regex, word).count > 0 {
            l_r_ending = true
        }

        if l_r_ending && suffix.startswith(vowels) {
            if word.count > 3 {
                conjugated = hassan + suffix
            } else {
                conjugated = word + suffix
            }
        } else if suffix.startswith(vocalized) {
            if suffix.count == 1 {
                if l_r_ending {
                    conjugated = ConjUtils.pad_vowel(hassan, suffix)
                } else {
                    conjugated = ConjUtils.pad_vowel(word, suffix)
                }
            } else if vocalized.contains(suffix[0, 1]) && consonants.contains(suffix[1, 2]) {
                if l_r_ending {
                    conjugated = ConjUtils.pad_vowel(hassan, suffix)
                } else {
                    conjugated = ConjUtils.pad_vowel(word, suffix)
                }
            } else {
                conjugated = word + suffix
            }
        } else if suffix.startswith(non_vocalized) {
            if suffix.startswith("х") {
                if l_r_ending {
                    conjugated = ConjUtils.pad_vowel(hassan, suffix)
                } else {
                    conjugated = ConjUtils.pad_vowel(word, suffix)
                }
            } else {
                conjugated = word + suffix
            }
        } else if y_vowels.contains(suffix) {
            conjugated = ConjUtils.pad_y_vowels(word, suffix)
        } else if suffix.startswith(vowels) {
            if word.count > 3 && vowels.contains(word[-2, -1]) && word[-2, -1] != "и" {
                if vocalized.contains(word[-3, -2]) && !["га", "го", "гу", "гы"].contains(word[-3, -1]) {
                    if word.count < 4 || !(vowels + y_vowels + ["й"]).contains(word[-4, -3]) {
                        conjugated = word + suffix
                    } else {
                        conjugated = hassan + suffix
                    }
                } else if non_vocalized.contains(word[-3, -2]) {
                    if word[-2, -1] != "и" && !["ж", "ч", "ш"].contains(word[-3, -2]) {
                        conjugated = hassan + suffix
                    } else {
                        conjugated = word + suffix
                    }
                } else {
                    conjugated = word + suffix
                }
            } else {
                conjugated = word + suffix
            }
        } else {
            conjugated = word + suffix
        }

        return conjugated
    }

    public static func conj_vocalized_l_r_ending(_ word: String, _ suffix: String, _ categories: [String: [String: [String]]]) throws -> String {
        var conjugated: String
        guard let consonants = categories["consonants"]?["all"] else {
            throw "all consonants"
        }
        guard let vocalized = categories["consonants"]?["vocalized"] else {
            throw "all consonants"
        }
        guard let non_vocalized = categories["consonants"]?["nonvocalized"] else {
            throw "all consonants"
        }
        guard let y_vowels = categories["vowels"]?["y_vowels"] else {
            throw "all consonants"
        }

        if suffix.startswith(vocalized) {
            if suffix.count == 1 {
                conjugated = ConjUtils.pad_vowel(word, suffix)
            } else if suffix.startswith(vocalized) && consonants.contains(suffix[1, 2]) {
                conjugated = ConjUtils.pad_vowel(word[0, -2] + word[-1, word.count], suffix)
            } else {
                conjugated = word + suffix
            }
        } else if suffix.startswith(non_vocalized) {
            if suffix.startswith("х") {
                conjugated = ConjUtils.pad_vowel(word[0, -2] + word[-1, word.count], suffix)
            } else {
                conjugated = word + suffix
            }
        } else if y_vowels.contains(suffix) {
            conjugated = ConjUtils.pad_y_vowels(word, suffix)
        } else {
            conjugated = word + suffix
        }

        return conjugated
    }

    public static func conj_non_vocalized_ending(_ word: String, _ suffix: String, _ categories: [String: [String: [String]]]) throws -> String {
        var conjugated: String
        guard let consonants = categories["consonants"]?["all"] else {
            throw "all consonants"
        }
        guard let vocalized = categories["consonants"]?["vocalized"] else {
            throw "all consonants"
        }
        guard let non_vocalized = categories["consonants"]?["nonvocalized"] else {
            throw "all consonants"
        }
        guard let y_vowels = categories["vowels"]?["y_vowels"] else {
            throw "all consonants"
        }
        guard let vowels = categories["vowels"]?["all"] else {
            throw "all consonants"
        }

        if suffix.startswith(vocalized) {
            if suffix.count == 1 {
                conjugated = ConjUtils.pad_vowel(word, suffix)
            } else if suffix.startswith(vocalized) && consonants.contains(suffix[1, 2]) {
                conjugated = ConjUtils.pad_vowel(word, suffix)
            } else {
                conjugated = word + suffix
            }
        } else if suffix.startswith(non_vocalized) {
            if suffix.startswith("х") || suffix.count == 1 {
                conjugated = ConjUtils.pad_vowel(word, suffix)
            } else {
                conjugated = word + suffix
            }
        } else if y_vowels.contains(suffix) {
            conjugated = ConjUtils.pad_y_vowels(word, suffix)
        } else if suffix.startswith(vowels) {
            if word.count > 3 && vowels.contains(word[-2, -1]) {
                if consonants.contains(word[-3, -2]) {
                    conjugated = "\(word[0, -2])\(word[-1, word.count])\(suffix)"
                } else {
                    conjugated = word + suffix
                }
            } else {
                conjugated = word + suffix
            }
        } else {
            conjugated = word + suffix
        }
        return conjugated
    }

    public static func conj_soft_sign_ending(_ word: String, _ suffix: String, _ categories: [String: [String: [String]]]) throws -> String {
        guard let vocalized = categories["consonants"]?["vocalized"] else {
            throw "vocalized consonants"
        }
        var conjugated: String
        guard let non_vocalized = categories["consonants"]?["nonvocalized"] else {
            throw "non-vocalized consontants"
        }
        guard let vowels = categories["vowels"]?["all"] else {
            throw "all vowels"
        }
        if suffix.startswith(vocalized) || suffix.startswith("х") {
            if suffix == "гүй" {
                conjugated = word + suffix
            } else {
                conjugated = "\(word[0, -1])и\(suffix)"
            }
        } else if suffix.startswith(vowels) {
            conjugated = "\(word[0, -1])и\(suffix[1, suffix.count])"
        } else if non_vocalized.contains(word[-2, -1]) && suffix.startswith(non_vocalized) {
            conjugated = "\(word[0, -1])и\(suffix)"
        } else {
            conjugated = word + suffix
        }
        return conjugated
    }

    public static func conj_non_vocalized_d_ending(_ word: String, _ suffix: String, _ categories: [String: [String: [String]]]) throws -> String {
        var conjugated: String

        guard let consonants = categories["consonants"]?["all"] else {
            throw "all consonants"
        }
        guard let vowels = categories["vowels"]?["all"] else {
            throw "all vowels"
        }
        if suffix.count == 1 {
            conjugated = "\(word[0, -2])\(word[-1, word.count])\(ConjDetection.detect_pad_vowel(word))\(suffix)"
        } else {
            if suffix.startswith("х") || consonants.contains(suffix[1, 2]) {
                conjugated = "\(word[0, -2])\(word[-1, word.count])\(ConjDetection.detect_pad_vowel(word))\(suffix)"
            } else if suffix.startswith(consonants) && vowels.contains(suffix[1, 2]) {
                conjugated = word + suffix
            } else if suffix.startswith(vowels) {
                if word.count > 3 {
                    conjugated = "\(word[0, -2])\(word[-1, word.count])\(suffix)"
                } else {
                    conjugated = word + suffix
                }
            } else {
                conjugated = word + suffix
            }
        }

        return conjugated
    }

    public static func conj_foreign_word(_ word: String, _ suffix: String, _ categories: [String: [String: [String]]], _ word_lists: [String: [String]]) throws -> String {
        var conjugated: String
        guard let vowels = categories["vowels"]?["all"] else {
            throw "all vowels throw"
        }
        guard let long_vowels = categories["vowels"]?["long"] else {
            throw "long vowels"
        }
        guard let gliding_vowels = categories["vowels"]?["gliding"] else {
            throw "gliding vowels"
        }
        guard let consonants = categories["consonants"]?["all"] else {
            throw "all consonants"
        }
        var _suffix = suffix
        let last_syllable = try ConjDetection.get_last_syllable(word, categories)
        let vowels_without_duplicate = Array(Set(re.findall(conjfunctions_reg[0], last_syllable)))

        if vowels_without_duplicate.contains("а") || vowels_without_duplicate.contains("о") {
            if _suffix[0, 2] == "ий" {
                _suffix = "ы" + _suffix[2, _suffix.count]
            }
        }

        if word.endswith(long_vowels + gliding_vowels) && _suffix.startswith(long_vowels) {
            if _suffix[0, 1] == "ы" {
                _suffix = "ий" + _suffix[2, _suffix.count]
            }
            conjugated = "\(word)г\(_suffix)"
        } else if consonants.contains(word[-2, -1]) && word.endswith(vowels) && _suffix.startswith(long_vowels + gliding_vowels) {
            if word[-2, -1] == "и" {
                if _suffix[0, 1] == "ы" || _suffix[0, 2] == "ий" {
                    conjugated = word[0, -1] + _suffix
                } else {
                    conjugated = word + _suffix[1, _suffix.count]
                }
            } else {
                if _suffix[0, 1] == "ы" {
                    _suffix = "ий" + _suffix[1, _suffix.count]
                }
                conjugated = "\(word)г\(_suffix)"
            }
        } else if word.endswith(consonants) && _suffix == "д" {
            let dom_vowel = try ConjDetection.detect_dominating_vowel(word, categories, word_lists, true)
            var pad: String
            if dom_vowel == "e" {
                pad = "э"
            } else if dom_vowel == "u" {
                pad = "ө"
            } else if dom_vowel == "o" {
                pad = "о"
            } else {
                pad = "а"
            }
            conjugated = "\(word)\(pad)\(_suffix)"
        } else {
            conjugated = word + suffix
        }
        return conjugated
    }
}
