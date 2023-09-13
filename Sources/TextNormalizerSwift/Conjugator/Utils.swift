// import ConjDetection

public enum ConjUtils {
    public static func pad_vowel(_ word: String, _ suffix: String) -> String {
        let d_vowel = ConjDetection.detect_pad_vowel(word)
        return "\(word)\(d_vowel)\(suffix)"
    }

    public static func check_is_foreign(_: String, _ conj_operation: String) -> Bool {
        var is_foreign = false
        if conj_operation == "conj_foreign_word" {
            is_foreign = true
        }

        return is_foreign
    }

    public static func pad_y_vowels(_ word: String, _ suffix: String) -> String {
        var hard_soft_sign = ""
        if ConjDetection.detect_word_gender(word) == "feminine" {
            hard_soft_sign = "ь"
        } else {
            hard_soft_sign = "ъ"
        }

        return "\(word)\(hard_soft_sign)\(suffix)"
    }

    public static func to_imperative(_ word: String, _ consonants: [String], _ vowels: [String]) -> String {
        var word = word
        if ConjDetection.count_syllables(word) > 1 && word[-1] == "х" {
            word = word[0, -1]

            if vowels.contains(word[-1, word.count]) && consonants.contains(word[-2, -1]) {
                if !(["л", "г"].contains(word[-2, -1]) && consonants.contains(word[-3, -2])) {
                    word = word[0, -1]
                }
            }
        }

        return word
    }

    public static func generate_code_string(_ word: String, _ categories: [String: [String: [String]]], _ word_lists: [String: [String]], _ is_foreign: Bool) throws -> (code: String, endswith: String) {
        guard let vocalized = categories["consonants"]?["vocalized"] else {
            throw "vocalized consonants"
        }
        guard let non_vocalized = categories["consonants"]?["nonvocalized"] else {
            throw "nonvocalized consonants"
        }

        let d_vowel = try ConjDetection.detect_dominating_vowel(word, categories, word_lists, is_foreign)

        var endswith = ""
        if vocalized.contains(word[-1, word.count]) {
            endswith = "vocalized_consonant"
        } else if non_vocalized.contains(word[-1, word.count]) {
            endswith = "non_vocalized_consonant"
        } else {
            endswith = "vowel"
        }

        return ("endswith=\(endswith)&\(d_vowel)_dominated", endswith)
    }
}
