import Foundation
import SwiftyPyRegex
import SwiftyPyString

public enum ConjDetection {
    public static let masculine_vowels_reg = re.compile("[ауояё]")
    public static let feminine_vowels_reg = re.compile("[эөүею]")
    public static let word_vowels = re.compile("([ыаэоүөуи])")
    public static let _all_vowels = re.compile("[аэиоөуүяеёю]")
    static let _detection_regs = [
        re.compile("[и]"),
        re.compile("([аэоүөу][аэоүөу])"),
        re.compile("[аэиоөуү]"),
    ]

    public static func detect_word_gender(_ word: String) -> String {
        let mas_vowels = re.findall(masculine_vowels_reg, word)
        let fem_vowels = re.findall(feminine_vowels_reg, word)
        let neutral_vowels = re.findall(_detection_regs[0], word)

        if mas_vowels.count >= fem_vowels.count {
            if mas_vowels.count == 0, neutral_vowels.count > 0 {
                return "feminine"
            }
            return "masculine"
        } else {
            return "feminine"
        }
    }

    public static func count_syllables(_ word: String) -> Int {
        let word_vowels_c = re.findall(word_vowels, word)
        let urt = re.findall(_detection_regs[1], word)
        let syllables_c = word_vowels_c.count - urt.count

        return syllables_c
    }

    public static func get_last_syllable(_ word: String, _ categories: [String: [String: [String]]]) throws -> String {
        guard let _vowels = categories["vowels"]?["all"] else {
            throw "vowels not found"
        }

        guard let _yvowels = categories["vowels"]?["y_vowels"] else {
            throw "yvowels not found"
        }
        let vowels = _vowels + _yvowels
        var last_vowel = -1

        // for i in 0 ..< word.count {
        //     if vowels.contains(word[-i, -i + 1]) {
        //         last_vowel = i

        //         if vowels.contains(word[-i + 1, -i + 2]) {
        //             last_vowel = i + 1
        //         }
        //         break
        //     }
        // }

        for i in 0 ..< word.count {
            let letter = word.count - i
            if vowels.contains(word[letter, letter + 1]) {
                last_vowel = i

                if vowels.contains(word[-i + 1, -i + 2]) {
                    last_vowel = i + 1
                }
                break
            }
        }

        return word[-last_vowel - 1, word.count]
    }

    public static func detect_dominating_vowel(_ word: String, _ categories: [String: [String: [String]]], _ word_lists: [String: [String]], _ is_foreign: Bool) throws -> String {
        var all_vowels: [String]
        var word = word
        if is_foreign {
            guard let foreign_odd_words = word_lists["foreign_odd_words"] else {
                throw "foreign_odd_words"
            }
            if foreign_odd_words.contains(word) {
                return "a"
            }

            var last_syl = try get_last_syllable(word, categories)

            if last_syl[-1, last_syl.count] == "и" {
                last_syl = try get_last_syllable(word[0, -1], categories)
            }
            all_vowels = re.findall(_all_vowels, last_syl)

            let vowels_without_duplicate = Array(Set(re.findall(_all_vowels, last_syl)))

            if vowels_without_duplicate.count == 1, vowels_without_duplicate[0] == "у" {
                var without_duplicate = Array(Set(re.findall(_all_vowels, word)))

                if without_duplicate.count == 1 {
                    return "e"
                } else {
                    without_duplicate = without_duplicate.filter { $0 != "у" }
                    word = word.replace("у", new: "")
                    all_vowels = without_duplicate
                }
            }
        } else {
            all_vowels = re.findall(_all_vowels, word)
        }

        if detect_word_gender(word) == "feminine" {
            if all_vowels.count == 1, all_vowels.contains("е") {
                if is_foreign {
                    return "e"
                } else {
                    return "u"
                }
            }
            if !all_vowels.contains("э"), all_vowels.contains("ө") {
                return "u"
            } else {
                return "e"
            }
        } else {
            if !all_vowels.contains("а"), all_vowels.contains("о") {
                if all_vowels.contains("у") {
                    return "a"
                } else {
                    return "o"
                }
            } else {
                return "a"
            }
        }
    }

    public static func detect_pad_vowel(_ word: String) -> String {
        if word.endswith(["ж", "ч", "ш"]) {
            return "и"
        }
        let all_vowels = re.findall(_detection_regs[2], word)

        if detect_word_gender(word) == "feminine" {
            if !all_vowels.contains("э"), all_vowels.contains("ө") {
                return "ө"
            } else {
                if word.endswith("с") {
                    return "ө"
                } else {
                    return "э"
                }
            }
        } else {
            if !all_vowels.contains("а"), all_vowels.contains("о") {
                if all_vowels.contains("у") {
                    return "а"
                } else {
                    return "о"
                }
            } else {
                return "а"
            }
        }
    }

    public static func has_vowels(_ text: String, _ vowels: String) -> Bool {
        for char in text {
            if vowels.contains(char) {
                return true
            }
        }
        return false
    }

    public static func provides_condition(_ word: String, _ sp_obj: [String: Any], _ categories: [String: [String: [String]]], _ word_lists: [String: [String]], _ is_foreign: Bool) throws -> Bool {
        guard let gliding_vowels = categories["vowels"]?["gliding"] else {
            throw "gliding vowels"
        }
        guard let long_vowels = categories["vowels"]?["long"] else {
            throw "long vowels"
        }

        var provides_end = false
        var provides_cond = false

        let spkeys = sp_obj.keys
        if (sp_obj["after"] as! [String]).count > 0 || spkeys.contains("word_lists") {
            let endings = (sp_obj["after"] as! [String])

            var inspobj = false

            for ending in endings {
                if word.endswith(ending) {
                    inspobj = true
                    break
                }
            }

            if inspobj {
                provides_end = true
            }

            if spkeys.contains("word_lists") {
                var word_list: [String] = sp_obj["word_lists"] as! [String]

                for l in word_list {
                    word_list += word_lists[l]!
                }

                if word_list.contains(word) {
                    provides_end = true
                }
            }
        } else {
            provides_end = true
        }

        if spkeys.contains("conditions"), (sp_obj["conditions"] as? [String] ?? []).count > 0 {
            let conditions = sp_obj["conditions"] as! [String]

            for cond_str in conditions {
                let conds = cond_str.split("&")
                var cond_bools: [Bool] = []

                for cond in conds {
                    let key = cond.split("=")[0]
                    let kond = cond.split("=")[1]

                    if key == "vowels" {
                        if kond == "gliding_or_long" {
                            if word.count > 3 && gliding_vowels.contains(word[-3, -1]) || long_vowels.contains(word[-3, -1]) {
                                cond_bools.append(true)
                            }
                        }
                    } else if key == "is_foreign", is_foreign {
                        cond_bools.append(true)
                    }
                }

                if cond_bools.count > 0, !cond_bools.contains(false) {
                    provides_cond = true
                    break
                }
            }
        } else {
            provides_cond = true
        }

        return provides_end && provides_cond
    }
}
