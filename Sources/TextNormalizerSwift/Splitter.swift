import Foundation
import SwiftyPyRegex
import SwiftyPyString

public class Splitter: Normalizer {
    private let letter_vocal_map = [
        "Е": "ЕЕ",
        "Щ": "ИШ",
        "Ъ": "ХАТУУГИЙН ТЭМДЭГ",
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
        "Ф": "ФЭ",
        "Й": "ХАГАС ИЙ",
        "Ы": "ЭР ҮГИЙН ИЙ",
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
        "Ь": "ЗӨӨЛНИЙ ТЭМДЭГ",
        "Т": "ТЭ",
        "И": "ИЙ",
        "М": "ИМ",
        "С": "ЭС",
        "Ё": "ЁО",
        "Ч": "ЧЭ",
        "Я": "ЯА",
    ]
    private let conjugation_merger_regex: re.RegexObject
    private let conjugator: Conjugator
    private let symbols_file: [String: Any]

    init(_ symbols_file: String, _ conjugator: Conjugator) {
        self.conjugator = conjugator
        conjugation_merger_regex = re.compile("(\\w+) *(N-HARIYALAH|n-hariyalah|N-UGUH_ORSHIH|n-uguh_orshih|N-ZAAH|N-GARAH|N-UILDEH|N-HAMTRAH|N-CHIGLEH)")
        let json = try! JSONSerialization.jsonObject(with: symbols_file.data(using: .utf8)!, options: []) as! [String: Any]
        self.symbols_file = json
        super.init()
    }

    let _splitter_reg = [
        re.compile("(\\w) ([!,\\.:;\\?\\-])"), // 0
        re.compile("[\\.!\\?]"), // 1
        re.compile("^[\\.!\\?:;,]+"), // 2
        re.compile("([А-ЯӨҮЁ])\\.([А-ЯӨҮЁ])"), // 3
        re.compile("\\.['\"]"), // 4
        re.compile("\\b[А-ЯӨҮЁ]+\\b"), // 5
        re.compile("([А-ЯӨҮЁ][а-яөүё]+)[\\-]([А-ЯӨҮЁ])"), // 6
        re.compile("(\\([А-ЯӨҮЁа-яөүё ]+\\))(N-[A-Za-z]+)"), // 7
        re.compile("(N-HARIYALAH|n-hariyalah|N-UGUH_ORSHIH|n-uguh_orshih|N-ZAAH|N-GARAH|N-UILDEH|N-HAMTRAH|N-CHIGLEH)"), //
    ]
    public func after_split(_ text: String, _ options: [String: Any]) throws -> String {
        var text = text
        text = text.replace("●", new: " ")
        text = text.replace("[QUOTA]", new: ".")

        if options["abbreviation_level"] as! String != "word" {
            for match in re.finditer(_splitter_reg[5], text).reversed() {
                if match.group()!.count < 5 {
                    let _nsrange = match.match.range(at: 0)
                    let _start = text.index(text.startIndex, offsetBy: _nsrange.location)
                    let _end = text.index(_start, offsetBy: _nsrange.length)
                    text = "\(text[..<_start])\(" ".join(match.group()!.map { letter_vocal_map["\($0)"] ?? "\($0)" }))\(text[_end...])"
                }
            }
        }

        var symbols: [String: String]

        if options["read_symbols"] as! String == "unshihgui_custom_temdegt" {
            symbols = (symbols_file["buh_temdegt"] as! [String: String]).filter { !(symbols_file["unshihgui_custom_temdegt"] as! [String]).contains($0.key) }
        } else {
            symbols = symbols_file[options["read_symbols"] as! String] as! [String: String]
        }

        for (key, value) in symbols {
            if key == "-" || key == "_" {
                continue
            }
            text = text.replace(key, new: " \(value) ")
        }

        text = re.sub(_splitter_reg[7], "$1 $2", text)
        let conjugation_matches = re.finditer(conjugation_merger_regex, text)

        for match in conjugation_matches.reversed() {
            let conjugated_word = try conjugator.form_conjugations(match.group(1)!, match.group(2)!)[0] + " "

            let _nsrange = match.match.range(at: 0)

            let _start = text.index(text.startIndex, offsetBy: _nsrange.location)
            let _end = text.index(_start, offsetBy: _nsrange.length)

            text = "\(text[..<_start])\(conjugated_word)\(text[_end...])"
        }

        text = re.sub(_splitter_reg[8], " ", text)

        if text.contains("-") && symbols.keys.contains("-") {
            text = text.replace("-", new: " хасах ")
        }
        if text.contains("_") && symbols.keys.contains("_") {
            text = text.replace("_", new: " доогуур зураас ")
        }

        let chars_to_keep = (options["use_phonemizer"] as! Bool) ? "" : "A-Za-z"

        for match in re.finditer("(^|\\b[А-ЯӨҮЁа-яөүё]{1} |\\s{2,})([а-яөүё]{1})\\b", text).reversed() {
            let _nsrange = match.match.range(at: 2)

            let _start = text.index(text.startIndex, offsetBy: _nsrange.location)
            let _end = text.index(_start, offsetBy: _nsrange.length)
            text = "\(text[..<_start])\(letter_vocal_map[match.group(2)!.uppercased()]!)\(text[_end...])"
        }

        text = re.sub("^[^а-яөүёА-ЯӨҮЁ" + chars_to_keep + "]+(.*)", "$1", text).trimmingCharacters(in: .whitespacesAndNewlines)
        text = re.sub("( )+", " ", text).trimmingCharacters(in: .whitespacesAndNewlines)
        text = re.sub("(\\w) ([!,\\.:;\\?\\-])", "$1$2", text)
        return text
    }

    public func can_add(_ current_buffer: String, _ new_buffer: String, _ sentence: String, _ soft_threshold: Int, _ hard_threshold: Int) -> Bool {
        let before_join_distance = soft_threshold - current_buffer.count
        let after_join_distance = new_buffer.count - soft_threshold
        var should_join: Bool

        if re.search(_splitter_reg[1], sentence) != nil && re.search(_splitter_reg[1], current_buffer) == nil {
            should_join = true
        } else {
            should_join = after_join_distance < before_join_distance
        }

        return should_join && new_buffer.count < hard_threshold
    }

    public func join_to_optimal_val(_ elements: [String], _ soft_threshold: Int, _ hard_threshold: Int) -> [String] {
        var optimal_splits = [String]()
        var buffer = ""

        for sentence in elements {
            let _sentence = re.sub(_splitter_reg[2], "", sentence)
            let new_buffer = buffer + _sentence
            if can_add(buffer, new_buffer, sentence, soft_threshold, hard_threshold) {
                buffer = new_buffer
            } else {
                optimal_splits.append(buffer)
                buffer = _sentence
            }
        }
        optimal_splits.append(buffer)
        return optimal_splits
    }

    override public func callAsFunction(_ input_text: [String: Any]) throws -> [String: Any] {
        var text = input_text["text"] as! String
        var input_text = input_text
        while re.search(_splitter_reg[3], text) != nil {
            text = re.sub(_splitter_reg[3], "$1●$2", text)
        }

        text = re.sub(_splitter_reg[4], "[QUOTA]", text)
        text = re.sub(_splitter_reg[6], "$1 $2", text)
        var sentences = [text]

        let hard_threshold = input_text["hard_threshold"] as! Int
        let soft_threshold = input_text["soft_threshold"] as! Int
        if input_text["split_sentences"] as! Bool {
            for pattern in ".!?'\"():;, " {
                var splitted_sentences = [String]()
                for sentence in sentences {
                    if sentence.count > hard_threshold && sentence.contains(pattern) {
                        var arr = sentence.split(separator: pattern).map { x in "\(x)\(pattern)" }
                        arr[arr.count - 1] = arr.filter { $0.count > 0 }[arr.count - 1][0, -1]
                        if "\(pattern)" == " " {
                            arr = join_to_optimal_val(arr, soft_threshold, hard_threshold)
                        }

                        splitted_sentences += arr
                    } else {
                        splitted_sentences.append(sentence)
                    }
                }

                sentences = splitted_sentences
            }
            var splitted_sentences = [String]()

            for sentence in sentences {
                if sentence.count > hard_threshold {
                    splitted_sentences += stride(from: 0, to: sentence.count, by: soft_threshold).map { i in
                        sentence[i, i + soft_threshold]
                    }
                } else {
                    splitted_sentences.append(sentence)
                }
            }

            var new_sentences = join_to_optimal_val(splitted_sentences, soft_threshold, hard_threshold)
            new_sentences = new_sentences.filter { x in x != "" }.map { x in
                try! after_split(x, input_text)
            }
            input_text["new_sentences"] = new_sentences
            return input_text
        } else {
            input_text["new_sentences"] = [try! after_split(text, input_text)]
            return input_text
        }
    }
}
