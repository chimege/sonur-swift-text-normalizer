import Foundation
import SwiftyPyRegex
import SwiftyPyString

public class PostProcessor: Normalizer {
    init(_ symbolsfile: String) {
        let json = try! JSONSerialization.jsonObject(with: symbolsfile.data(using: .utf8)!, options: []) as! [String: Any]
        symbols_file = json
        escaped_chars = [
            "!": "!",
            "?": "\\?",
            "\"": "\"",
            "...": "\\.\\.\\.",
            "#": "\\#",
            "₮": "₮",
            "$": "\\$",
            "£": "£",
            "€": "€",
            "¢": "¢",
            "¥": "¥",
            "%": "%",
            "&": "\\&",
            "'": "'",
            "(": "\\(",
            ")": "\\)",
            "*": "\\*",
            "+": "\\+",
            ",": ",",
            "-": "\\-",
            ".": "\\.",
            "/": "/",
            ":": ":",
            ";": ";",
            "<": "<",
            ">": ">",
            "=": "=",
            "@": "@",
            "[": "\\[",
            "]": "\\]",
            "\\": "\\\\",
            "^": "\\^",
            "_": "_",
            "`": "`",
            "{": "\\{",
            "}": "\\}",
            "|": "\\|",
            "~": "\\~",
            "№": "№"
        ]
        super.init()
    }

    private func escapechars(_ text: String) -> String {
        return escaped_chars[text] ?? text
    }


    public var escaped_chars: [String: String]

    public let symbols_file: [String: Any]

    override public func callAsFunction(_ input_text: [String: Any]) throws -> [String: Any] {
        var text = input_text["text"] as! String
        var input_text = input_text
        var chars_to_keep: String
        if input_text["read_symbols"] as! String != "unshihgui_custom_temdegt" {
            chars_to_keep = "".join((symbols_file[input_text["read_symbols"] as! String] as! [String: String]).keys.map({escapechars($0)}))
        } else {
            chars_to_keep = "".join((symbols_file["buh_temdegt"] as! [String: String]).keys.filter { !(symbols_file["unshihgui_custom_temdegt"] as! [String]).contains("\($0)") }.map{escapechars($0)})
        }

        text = re.sub("[^-_.,!?:\"' \\-А-ЯӨҮЁа-яөүёA-Za-z" + chars_to_keep + "]", " ", text)
        text = re.sub("\\s+", " ", text)
        // text = re.sub("([!',.:;?\\-\(chars_to_keep)] *)\\1+", {
        //     $0.group(1) ?? ""
        // }, text)
        let regex = try! NSRegularExpression(pattern: "([!',.:;?\\-\(chars_to_keep)] *)\\1+")
        text = regex.stringByReplacingMatches(in: text, range: NSMakeRange(0, text.count), withTemplate: "$1")

        input_text["text"] = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return input_text
    }
}
