import Foundation
import SwiftyPyRegex
import SwiftyPyString

public class Abbreviations: Normalizer {
    public let suffix_code_map: [String: [String]] = [
        "N-HARIYALAH ": ["ний", "ны", "ийн", "ын", "н", "ий", "ы"],
        "N-UGUH_ORSHIH ": ["д", "т", "нд"],
        "N-ZAAH ": ["ыг", "ийг", "г"],
        "N-GARAH ": ["с", "ээс", "өөс", "аас", "оос", "нээс", "нөөс", "наас", "ноос"],
        "N-UILDEH ": ["р", "ээр", "өөр", "аар", "оор"],
        "N-HAMTRAH ": ["тэй", "тай", "той"],
        "N-CHIGLEH ": ["руу", "рүү"],
    ]
    public let not_uildeh_regx = re.compile("([0-9])(_p)")

    public let letter_vocal_map: [String: String] = [
        "Е": "ЕЕ",
        "Щ": "",
        "Ъ": "",
        "К": "КА",
        "З": "ЗЭ",
        "Ү": "ҮҮ",
        "Ш": "ИШ",
        "Г": "ГЭ",
        "Н": "ЭН",
        "Э": "ЭЭ",
        "Ж": "ЖЭ",
        "У": "УУ",
        "Ц": "ЦЭ",
        "Ф": "ФФ",
        "Й": "ХАГАС ИЙ",
        "Ы": "",
        "Б": "БЭ",
        "Ө": "ӨӨ",
        "А": "АА",
        "Х": "ХЭ",
        "Р": "ЭР",
        "О": "ОО",
        "Л": "ИЛ",
        "Д": "ДЭ",
        "П": "ПЭ",
        "Ю": "ЮҮ",
        "В": "ВЭ",
        "Ь": "",
        "Т": "ТЭ",
        "И": "ИЙ",
        "М": "ИМ",
        "С": "ЭС",
        "Ё": "ЁО",
        "Ч": "ЧЭ",
        "Я": "ЯА",
    ]

    public let abbrs: [String: String]

    public let conjugator: Conjugator
    public let _abbrRegs: [re.RegexObject]

    init(_ abbreviation_file: String, _ conjugator: Conjugator) {
        let lines = abbreviation_file.split("\n")
        var abbr_map = [String: String]()

        for line in lines {
            let l = line.trimmingCharacters(in: .whitespacesAndNewlines).split("|")
            if l.count == 2 {
                abbr_map[l[0]] = l[1]
            }
        }
        abbrs = abbr_map
        self.conjugator = conjugator
        let _keys = Array(metrics.keys).map { String($0) }
        let re_allowed_str = "|".join(_keys.reversed()).replace(".", new: "\\.")
        let __keys = Array(conj_metr.keys).map { String($0) }.sorted(by: { $0.count > $1.count }).reversed()
        let str = "|".join(__keys)
        _abbrRegs = [
            re.compile("([^А-ЯӨҮЁа-яөүё]|^)(\(re_allowed_str))([^А-ЯӨҮЁа-яөүё+]|$)"),
            re.compile("([^А-ЯӨҮЁа-яөүё\\s]|^])(\(str))([^А-ЯӨҮЁа-яөүё+]|$)"),
            re.compile("[,.!?]"),
            re.compile("^[^А-ЯӨҮЁа-яөүё]+"),
            re.compile("[^А-ЯӨҮЁа-яөүё]+$"),
            re.compile("(\\s)"),
            re.compile("[\\.,?!]"),
            re.compile("\\b[IVXLCDMХХ]+\\b"),
            re.compile("([А-ЯӨҮЁ]{3,}[^а-яөүёА-ЯӨҮЁ]){3,}"),
            re.compile("([А-ЯӨҮЁ] ?\\-[А-ЯӨҮЁа-яөүё])"),
            re.compile(" +"),
            re.compile("([А-ЯӨҮЁа-яөүё]+)-([а-яөүё]+)"),
            re.compile("^[А-Яа-яӨөҮүЁё]+\\s*[,\\.]+$"),
            re.compile("([А-ЯӨҮЁа-яөүё]+)-([а-яөүё]+|[А-ЯӨҮЁ]+)(\\b|[-])"),
        ]
        super.init()
    }

    public let signs: [String: String] = [
        " -": "-", "Чимэгэ": "Чимээгээ", "chimege": "чимээгээ",
        "Chimege": "Чимээгээ", "чаямж": "чимээгээ", "мян. ": "мянган ",
    ]

    public let metrics = [
        "мкв": " метр квадрат", "гр": " грамм", "кг": " килограмм", "тн": " тонн", "км": " километр",
        "мм": " миллиметр",
        "см": " сантиметр", "°": " градус", "м3": " метр куб", "мл": " миллиграмм",
        "вт": " ватт",
        "квт": " киловатт", "сек": " секунд", "%": " хувь",
        "мин": " минут", "₮": " төгрөг", "\\$": " доллар", "€": " евро", "¥": " иен", "£": " фунт",
        "мвт": " мегаватт", "дм": " дециметр", "дм3": " дециметр куб",
        "дм2": " дециметр квадрат", "ам.доллар": " америк доллар", "ам доллар": " америк доллар",
        "м2": " метр квадрат",
    ]

    public let conj_metr = [
        "л": " литр", "в": "вольт", "А": "ампер", "м": " метр",
    ]

    public let numbers = "|".join([
        "нэг", "хоёр", "гурван", "дөрвөн", "таван", "зургаан", "долоон", "найман",
    ])

    public func replace_signs(_ text: String) -> String {
        var text = text
        for (key, value) in signs {
            text = text.replace(key, new: value)
        }
        return text
    }

    public func expand_all_metrics(_ text: String) throws -> String {
        let matches = re.finditer(_abbrRegs[0], text)
        var text = text
        for match in matches.reversed() {
            guard let match_second_group = match.group(2) else {
                continue
            }

            var metric_str: String

            if match_second_group == "$" {
                metric_str = " доллар"
            } else {
                metric_str = metrics[match_second_group]!
            }

            let _nsrange = match.match.range(at: 2)

            let _start = text.index(text.startIndex, offsetBy: _nsrange.location)
            let _end = text.index(_start, offsetBy: _nsrange.length)

            text = "\(text[..<_start])\(metric_str)\(text[_end...])"
        }
        for key in conj_metr.keys {
            if text.contains(key) {
                let matches = re.finditer(_abbrRegs[1], text)
                for match in matches.reversed() {
                    guard let match_second_group = match.group(2) else {
                        throw "error here"
                    }

                    guard let metric_str = conj_metr[match_second_group] else {
                        throw "\(match_second_group) key not exists"
                    }
                    let _nsrange = match.match.range(at: 2)

                    let _start = text.index(text.startIndex, offsetBy: _nsrange.location)
                    let _end = text.index(_start, offsetBy: _nsrange.length)

                    text = "\(text[..<_start])\(metric_str)\(text[_end...])"

                }
            }
        }

        return text
    }

    public func combine_suffix(_ word: String, _ suffix: String) throws -> (String, String) {
        var suffix_code = ""

        for code in suffix_code_map {
            if code.value.contains(re.sub(_abbrRegs[2], "", suffix)) {
                suffix_code = code.key
                break
            }
        }

        var conjugated: String

        if suffix_code != "" {
            conjugated = try conjugator.form_conjugations(word, suffix_code.trimmingCharacters(in: .whitespacesAndNewlines))[0]
        } else {
            conjugated = try conjugator.conjugate(word, suffix)
        }

        return (conjugated, suffix_code)
    }

    public func expand_abbreviations(_ words: String, _ option: String) throws -> [String] {
        if option == "skip" {
            return [words.lower()]
        }
        
        var result = [String]()

        for _word in re.split(_abbrRegs[5], words) {
            var word = _word!
            if word.contains("▁") {
                if re.findall(not_uildeh_regx, word).count > 0 {
                    continue
                }

                let __d = word.split("▁", maxsplit: 1)
                word = __d[0]
                var suff = __d[1]
                suff = suff.replace("-", new: "")
                var found: Bool
                (word, found) = try find_abbr(word, option)
                if found {
                    if option == "letter" {
                        word = "\(word) \(suff)"
                    } else if option == "abbreviation" {
                        let _words = word.split(" ")
                        let last = _words[_words.count - 1]
                        var (conjugated, code) = try combine_suffix(last, suff.lower())
                        if code != "" {
                            let _f = Array(re.finditer(_abbrRegs[2], suff.lower()))
                            if _f.count > 0 {
                                conjugated = "\(conjugated)\(_f[0].group()!)"
                            }
                        }

                        word = " ".join(_words[0..<_words.count - 1] + [conjugated])
                    } else {
                        word = "\(word) \(suff)"
                    }
                } else {
                    word = "\(word) \(suff)"
                }
            } else {
                (word, _) = try find_abbr(word, option)
            }
            result.append(word)
        }
        return result
    }

    func find_abbr(_ word: String, _ option: String) throws -> (String, Bool) {
        var eval_word = word

        let pref = re.search(_abbrRegs[3], word)
        let _prefix: String
        if let _ = pref {
            _prefix = pref?.group() ?? ""
            eval_word = eval_word[_prefix.count, eval_word.count]

        } else {
            _prefix = ""
        }
        let suffix = re.search(_abbrRegs[4], word)
        var _suffix = ""
        if suffix == nil {
            _suffix = ""
        } else {
            _suffix = suffix?.group() ?? ""
            eval_word = eval_word[0, -_suffix.count]
        }

        if abbrs.keys.contains(eval_word) {
            if option == "letter" {
                return ("\(_prefix)\(" ".join(eval_word.map { (letter_vocal_map[String($0)]?.lowercased())! }))\(_suffix)", true)
            } else if option == "abbreviation" {
                guard let _evalword = abbrs[eval_word]?.lowercased() else {
                    throw "eval word not found"
                }
                return ("\(_prefix)\(_evalword)\(_suffix)", true)
            } else {
                return (word, true)
            }
        } else {
            return (word, false)
        }
    }

    override public func callAsFunction(_ input_text: [String: Any]) throws -> [String: Any] {
        var text = input_text["text"] as! String
        var input_text = input_text

        if text.upper() == text && text.count > 5 {
            text = text.lower()
        } else {
            text = re.sub(_abbrRegs[8], { x -> String in
                x.group()!.lower()
            }, text)
        }

        text = re.sub(_abbrRegs[10], " ", text)

        let abbr_suffixes = re.finditer(_abbrRegs[9], text)

        for match in abbr_suffixes.reversed() {
            let _start = match.match.range(at: 0).location
            let idx = text.index(text.startIndex, offsetBy: _start + 1)
            text.remove(at: idx)
            text.insert("▁", at: idx)
        }
        let components = text.components(separatedBy: .whitespaces)
        text = components.joined(separator: " ")
        text = replace_signs(text)
        text = try expand_all_metrics(text)
        let _text = try expand_abbreviations(text, input_text["abbreviation_level"] as! String)
        text = "".join(_text)
        let suffix_match_after_metrics = re.finditer(_abbrRegs[13], text)
        for match in suffix_match_after_metrics.reversed() {
            guard let word = match.group(1) else {
                throw "process match 1 word"
            }
            guard let suffix = match.group(2) else {
                throw "process match 2 word"
            }
            let (conjugated, _) = try combine_suffix(word, suffix)
            let _nsrange = match.match.range(at: 0)

            let _start = text.index(text.startIndex, offsetBy: _nsrange.location)
            let _end = text.index(_start, offsetBy: _nsrange.length)

            text = "\(text[..<_start])\(conjugated)\(text[_end...])"
        }
        
        if re.match(_abbrRegs[12], text.trimmingCharacters(in: .whitespacesAndNewlines)) != nil {
            text = text.trimmingCharacters(in: .whitespacesAndNewlines).rstrip(",.")
        }

        input_text["text"] = text

        return input_text
    }
}
