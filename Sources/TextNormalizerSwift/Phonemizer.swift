import SwiftyPyRegex
import SwiftyPyString

extension espeak_ng_STATUS {
    func check() throws {
        guard self == ENS_OK else {
            var stringBuffer = [CChar](repeating: 0, count: 512)
            let str = stringBuffer.withUnsafeMutableBufferPointer { buf in
                espeak_ng_GetStatusCodeMessage(self, buf.baseAddress!, buf.count)
                return String(cString: buf.baseAddress!)
            }
            throw NSError(domain: EspeakErrorDomain, code: Int(rawValue), userInfo: [NSLocalizedFailureReasonErrorKey: str])
        }
    }
}

public class Phonemizer: Normalizer {
    public let email_regex = "[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*"
    public let domain_regex = re.compile("(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\\.)+[a-z]{0,61}[a-z]")
    public let _phonemizer_regs = [
        re.compile("[A-Za-z]+"),
        re.compile("\\b([IVXLCDM]+)(-([IVXLCDM]+)|)\\b"),
        re.compile(" +"),
    ]
    public let eng_vowels_mono = ["ɪ", "ʊ", "e", "ə", "æ", "ʌ", "ɒ", "ɑ", "i", "a", "u", "ɔ", "j", "o", "ɜ"]
    public let eng_vowels_di = ["ɪə", "eɪ", "ʊə", "ɔɪ", "əʊ", "eə", "aɪ", "aʊ", "iː", "aː", "ɜː", "ɔː", "uː", "ɑː", "oː",
                                "je", "juː", "ja", "jo", "jɪ"]
    public let eng_consonants = ["p", "b", "t", "d", "f", "v", "θ", "ð", "m", "n", "ŋ", "h", "k", "g", "s", "z", "ʃ", "ʒ",
                                 "l", "r", "w", "j"]

    public let combi_consonants = ["tʃ", "dʒ"]
    public let chars = [".", ",", "!", "?", ":", " "]
    public let phn_map = [
        "ð": "д",
        "ʊ": "өү",
        "ɔ": "өа",
        "ɔː": "өо",
        "ə": "э",
        "f": "ф",
        "o": "о",
        "n": "н",
        "m": "м",
        "a": "а",
        "ɪ": "и",
        "z": "с",
        "ɚ": "эр",
        "ɐ": "ай",
        "l": "л",
        "s": "с",
        "p": "п",
        "e": "э",
        "ᵻ": "и",
        "ʃ": "ш",
        "eɪ": "эй",
        "ɑː": "оа",
        "dʒ": "ж",
        "ɛ": "эй",
        "ɹ": "р",
        "tʃ": "ч",
        "aʊ": "ау",
        "aɪ": "ая",
        "ɔɪ": "оё",
        "əʊ": "өоү",
        "ɒ": "оо",
        "eə": "ээ",
        "juː": "юү",
        "jɪ": "еи",
        "ɾ": "т",
        "iː": "ий",
        "æ": "эай",
        "ʌ": "а",
        "b": "б",
        "t": "т",
        "d": "д",
        "v": "в",
        "θ": "т",
        "ŋ": "н",
        "h": "х",
        "r": "р",
        "k": "к",
        "ɡ": "г",
        "ʒ": "ж",
        "y": "я",
        "w": "в",
        "u": "ү",
        "i": "ы",
        "c": "к",
        "jo": "ё",
        "g": "г",
        "uː": "үү",
        "ɜː": "иоур",
        "oː": "ао",
        "jɑː": "яа",
        "joː": "ёо",
        "ʔ": "тт",
    ]

    override init() {
        let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let root = documentsDirectory
        try! EspeakLib.ensureBundleInstalled(inRoot: root)
        espeak_ng_InitializePath(root.path)
        try! espeak_ng_Initialize(nil).check()
        // try espeak_ng_SetVoiceByName(ESPEAKNG_DEFAULT_VOICE).check()
        try! espeak_ng_SetVoiceByName("en").check()

        super.init()
    }

    public func split_phoneme(_ word: String) -> [String] {
        var char_list: [String] = []
        var skip = false
        var skip_twice = false

        for (i, char) in word.enumerated() {
            if i == 0 {
                skip = false
                skip_twice = false
            }

            if skip {
                skip = false
                continue
            }

            if skip_twice {
                skip_twice = false
                skip = true
                continue
            }

            if char == Character("j") && i != word.count - 2 {
                if word[i + 2] == "ː" {
                    char_list.append("\(char)\(word[i + 1, i + 3])")
                    skip_twice = true
                } else if eng_vowels_di.contains("\(char)\(word[i + 1, i + 2])") {
                    char_list.append("\(char)\(word[i + 1, i + 2])")
                    skip = true
                }
            } else if eng_vowels_mono.contains("\(char)") && i < word.count && eng_vowels_di.contains("\(char)\(word[i + 1, i + 2])") {
                char_list.append("\(char)\(word[i + 1, i + 2])")
                skip = true
            } else if eng_consonants.contains("\(char)") && i < word.count && combi_consonants.contains("\(char)\(word[i + 1, i + 2])") {
                char_list.append("\(char)\(word[i + 1, i + 2])")
                skip = true
            } else {
                char_list.append("\(char)")
            }
        }
        return char_list
    }

    public func latin_phonemes(_ words: [String]) -> [String] {
        let options: Int32 = espeakPHONEMES_IPA | 19

        return words.map { $0.utf8CString.withUnsafeBufferPointer { ptr in
            var textPtr: UnsafeRawPointer? = UnsafeRawPointer(ptr.baseAddress)
            let phonemesPtr = espeak_TextToPhonemes(&textPtr, espeakCHARS_UTF8, options)
            if let phonemes = phonemesPtr {
                let data = String(cString: phonemes)
                return data
            }

            fatalError("can't phonemizer espeak")
        }}
    }

    public func translate_phonemes(_ phonemes: [String]) -> [String] {
        var cyrill = [String]()

        for word in phonemes {
            let split_word = split_phoneme(word)
            var cyr_word = ""
            for phoneme in split_word {
                if chars.contains("\(phoneme)") {
                    cyr_word += phoneme
                } else {
                    if phn_map.keys.contains(phoneme) {
                        cyr_word += phn_map[phoneme]!
                    } else {}
                }
            }
            cyrill.append(" \(cyr_word) ")
        }

        return cyrill
    }

    public func cyrillize(_ regex: String, _ text: String) -> String {
        var text = text
        let matches = re.finditer(regex, text)

        if matches.count == 0 {
            return text
        }

        let match_words = matches.map { $0.group()! }

        let phn = latin_phonemes(match_words)
        let cyrill = translate_phonemes(phn).map { $0.replace(".", new: " цэг ") }

        for (word, c) in zip(matches, cyrill).reversed() {
            text = re.sub("\\b\(word.group()!)\\b", c, text)
        }
        return text
    }

    public func roman_conv(_ s: String, _ use_dugaar: Bool = false) -> String {
        let roman = [
            "I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000, "IV": 4, "IX": 9, "XL": 40, "XC": 90, "CD": 400, "CM": 900,
        ]

        var i = 0
        var num = 0

        while i < s.count {
            if i + 1 < s.count && roman.keys.contains(s[i, i + 2]) {
                num += roman[s[i, i + 2]]!
                i += 2
            } else {
                num += roman[s[i, i + 1]]!
                i += 1
            }
        }

        return use_dugaar ? "\(num)" + MongolianDigitLetter.dugaar("\(num)") : "\(num)"
    }

    public func roman_handler(_ m: re.MatchObject) -> String {
        if (m.group(2) ?? "").count > 1 {
            return roman_conv(m.group(1)!, false) + "-аас " + roman_conv(m.group(3)!)
        }
        return roman_conv(m.group(1)!)
    }

    override public func callAsFunction(_ input_text: [String: Any]) -> [String: Any] {
        var text = input_text["text"] as! String
        var input_text = input_text
        if input_text["read_roman_number"] as! Bool {
            var matches = re.finditer("\\b([IVXLCDM]+)([ ]|-([IVXLCDM]+))\\b", text)

            matches.sort(key: { x in
                let _nsrange = x.match.range(at: 0)
                return _nsrange.location + _nsrange.length
            })

            for m in matches {
                let _nsrange = m.match.range(at: 0)

                let _start = text.index(text.startIndex, offsetBy: _nsrange.location)
                let _end = text.index(_start, offsetBy: _nsrange.length)
                text = "\(text[..<_start])\(roman_handler(m))\(text[_end...])"
            }
        }

        if input_text["use_phonemizer"] as! Bool {
            text = cyrillize(email_regex, text)
            text = cyrillize("[A-Za-z]+", text)
        }

        text = re.sub(_phonemizer_regs[2], " ", text)
        input_text["text"] = text
        return input_text
    }
}
