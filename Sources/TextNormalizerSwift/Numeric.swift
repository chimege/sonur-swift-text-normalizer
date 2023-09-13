import Foundation
import SwiftyPyRegex
import SwiftyPyString
extension String: Error {}

public class Numeric: Normalizer {
    init(_ conjugator: Conjugator) {
        self.conjugator = conjugator

        suffix_code_map = [
            "N-HARIYALAH ": ["ийн", "ын", "ий", "ы"],
            "n-hariyalah ": ["ний", "ны"],
            "N-UGUH_ORSHIH ": ["д", "т"],
            "n-uguh_orshih ": ["нд"],
            "N-ZAAH ": ["ыг", "ийг", "г"],
            "N-GARAH ": ["с", "ээс", "өөс", "аас", "оос", "нээс", "нөөс", "наас", "ноос"],
            "N-UILDEH ": ["р", "ээр", "өөр", "аар", "оор"],
            "N-HAMTRAH ": ["тэй", "тай", "той"],
            "N-CHIGLEH ": [" руу", " рүү"],
        ]
        NUM_ENDED = " *([^a-zA-Zа-яА-ЯөӨүҮ0-9%°\\$₮ ]|$|дугаар|дүгээр|орчим|хавьцаа|N-HARIYALAH|N-UGUH_ORSHIH|N-ZAAH|N-GARAH|N-UILDEH|N-HAMTRAH|N-CHIGLEH|нэмэх|хасах|үржих|хуваах|тэнцүү|хүртэлх|хүртэл|илүүтэй|илүү|гаруй|хүрнэ|дахь|дэх|уулаа|үүлээ|байна|бол*)"
        l = []

        conjugation_codes = ["N-HARIYALAH", "N-UGUH_ORSHIH", "N-ZAAH", "N-GARAH", "N-UILDEH", "N-HAMTRAH", "N-CHIGLEH"]
        conjugation_merger_regex = re.compile("(\\w+) *(N-HARIYALAH|n-hariyalah|N-UGUH_ORSHIH|n-uguh_orshih|N-ZAAH|N-GARAH|N-UILDEH|N-HAMTRAH|N-CHIGLEH)")
        super.init()
        l = [
            [
                re.compile("([0-9]+)(-р|р)\\b"), 2,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 00")
                    return MongolianDigitLetter.dugaar(x.group(1)!)
                },
            ],
            [
                re.compile("( {0,1}(#|№) {0,1})([0-9]+)"), 1,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 01")
                    return MongolianDigitLetter.dugaar(x.group(2)!)
                },
            ],
            [
                re.compile("([0-9]+)(-*(ы|ий)*г)\\b"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 02")
                    return "N-ZAAH "
                },
            ],
            [
                re.compile("([0-9]+)(-*(ийн|ын|ий|ы))\\b"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 03")
                    return "N-HARIYALAH "
                },
            ],
            [
                re.compile("([0-9]+)(-*(ний|ны))\\b"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 04")
                    return "n-hariyalah "
                },
            ],
            [
                re.compile("([0-9]+)(-*т(а|э|о|ө)й)\\b"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 05")
                    return "N-HAMTRAH "
                },
            ],
            [
                re.compile("([0-9]+)(-*(д|т))\\b"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 06")
                    return "N-UGUH_ORSHIH "
                },
            ],
            [
                re.compile("([0-9]+)(-*(нд))\\b"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 07")
                    return "n-uguh_orshih "
                },
            ],
            [
                re.compile("([0-9]+)(-*н*(аа|ээ|оо|өө)*с)\\b"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 08")
                    return "N-GARAH "
                },
            ],
            [
                re.compile("([0-9]+)(-*(аа|ээ|оо|өө)*р)\\b"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 09")
                    return "N-UILDEH "
                },
            ],
            [
                re.compile("([0-9]+)(-*(руу|рүү))\\b"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 010")
                    return "N-CHIGLEH "
                },
            ],
            [
                re.compile("[^A-Za-zА-ЯӨҮЁа-яөүё0-9▁\\- ](-*(ы|ий)*г)\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 011")
                    return "N-ZAAH "
                },
            ],
            [
                re.compile("[^A-Za-zА-ЯӨҮЁа-яөүё0-9▁\\- ](-(ийн|ын|ий|ы))\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 012")
                    return "N-HARIYALAH "
                },
            ],
            [
                re.compile("[^A-Za-zА-ЯӨҮЁа-яөүё0-9▁\\- ](-*(ний|ны))\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 013")
                    return "n-hariyalah "
                },
            ],
            [
                re.compile("[^A-Za-zА-ЯӨҮЁа-яөүё0-9▁\\- ](-*т(а|э|о|ө)й)\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 014")
                    return "N-HAMTRAH "
                },
            ],
            [
                re.compile("[^A-Za-zА-ЯӨҮЁа-яөүё0-9▁\\- ](-*(д|т))\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 015")
                    return "N-UGUH_ORSHIH "
                },
            ],
            [
                re.compile("[^A-Za-zА-ЯӨҮЁа-яөүё0-9▁\\- ](-*(нд))\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 016")
                    return "n-uguh_orshih "
                },
            ],
            [
                re.compile("[^A-Za-zА-ЯӨҮЁа-яөүё0-9▁\\- ](-*н*(аа|ээ|оо|өө)*с)\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 017")
                    return "N-GARAH "
                },
            ],
            [
                re.compile("[^A-Za-zА-ЯӨҮЁа-яөүё0-9▁\\- ](-*(аа|ээ|оо|өө)*р)\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 018")
                    return "N-UILDEH "
                },
            ],
            [
                re.compile("[^A-Za-zА-ЯӨҮЁа-яөүё0-9▁\\- ](-*(руу|рүү))\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 019")
                    return "N-CHIGLEH "
                },
            ],
            [
                re.compile("\\b([0-9]{1,3}[.])([0-9]{1,3}[.])([0-9]{1,3}[.])([0-9]{1,3})([:][0-9]{1,5}|)\\b"), 0,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 020")
                    return self.ip_address(x)
                },
            ],
            [
                re.compile("(-(ы|ий)*г)\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 021")
                    return "N-ZAAH "
                },
            ],
            [
                re.compile("(-(ийн|ын|ий|ы))\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 022")
                    return "N-HARIYALAH "
                },
            ],
            [
                re.compile("(-(ний|ны))\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 023")
                    return "n-hariyalah "
                },
            ],
            [
                re.compile("(-т(а|э|о|ө)й)\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 024")
                    return "N-HAMTRAH "
                },
            ],
            [
                re.compile("(-(д|т))\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 025")
                    return "N-UGUH_ORSHIH "
                },
            ],
            [
                re.compile("(-(нд))\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 026")
                    return "n-uguh_orshih "
                },
            ],
            [
                re.compile("(-н*(аа|ээ|оо|өө)*с)\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 027")
                    return "N-GARAH "
                },
            ],
            [
                re.compile("(-(аа|ээ|оо|өө)*р)\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 028")
                    return "N-UILDEH "
                },
            ],
            [
                re.compile("(-(руу|рүү))\\b"), 1,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 029")
                    return "N-CHIGLEH "
                },
            ],
            [
                re.compile("\\b([0-9]{3})-([0-9]{8})\\b"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 030")
                    return "\(MongolianDigitLetter.number2word(x.group(1)!.trimmingCharacters(in: .whitespacesAndNewlines))) \(self.eight_digit(x.group(2)!.trimmingCharacters(in: .whitespacesAndNewlines)))"
                },
            ],
            [
                re.compile("([0-9]{4}|\\b[А-ЯӨҮЁа-яөүё]+\\b) *оны *([0-1]{0,1}[0-9]|\\b[А-ЯӨҮЁа-яөүё]+\\b) *сарын *([0-3]{0,1}[0-9])( өдөр|)"),
                0,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 031")
                    return self.date(args: [x.group(1)!, x.group(2)!, x.group(3)!], end: x.group(4)!) // something
                },
            ],
            [
                re.compile("\\b([0-3]{0,1}[0-9])(/|\\\\|\\.)([0-1]{0,1}[0-9])(\\2)([0-9]{4})( өдөр|)"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 032")
                    return self.date(args: [x.group(5)!, x.group(3)!, x.group(1)!], end: x.group(6)!)
                },
            ],
            [
                re.compile("\\b([0-9]{4})(/|\\\\|\\.)([0-1]{0,1}[0-9])(\\2)(([0-3]{0,1}[0-9])-([0-3]{0,1}[0-9]))( өдөр|)"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 033")
                    return self.date(args: [x.group(1)!, x.group(3)!, x.group(6)!, x.group(7)!], end: x.group(6)!, range: true)
                },
            ],
            [
                re.compile("\\b([0-9]{4})(/|\\\\|\\.|-)([0-1]{0,1}[0-9])(\\2)([0-3]{0,1}[0-9])( өдөр|)"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 034")
                    return self.date(args: [x.group(1)!, x.group(3)!, x.group(5)!], end: x.group(6)!)
                },
            ],
            [
                re.compile("([0-1]{0,1}[0-9]) *(сарын) *(([0-3]{0,1}[0-9])-([0-3]{0,1}[0-9]))( өдөр|)"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 035")
                    return self.date(args: [x.group(1)!, x.group(4)!, x.group(5)!], end: x.group(6)!, range: true)
                },
            ],
            [
                re.compile("([0-1]{0,1}[0-9]) *(сарын) *([0-3]{0,1}[0-9])( өдөр|)"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 036")
                    return self.date(args: [x.group(1)!, x.group(3)!], end: x.group(4)!)
                },
            ],
            [
                re.compile("\\b(сарын) *(([0-3]{0,1}[0-9])-([0-3]{0,1}[0-9]))( өдөр|)"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 037")
                    return self.date(args: [x.group(3)!, x.group(4)!], end: x.group(5)!, range: true)
                },
            ],
            [
                re.compile("\\b(сарын) *([0-3]{0,1}[0-9]) *[Nn]"), 2,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 038")
                    return MongolianDigitLetter.number2word(x.group(2)!, false, true)
                },
            ],
            [
                re.compile("харьцаа (([0-9]+)[:]([0-9]+[\\.,][0-9]+))\\b"), 1,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 039")
                    return self.ratio(x, true)
                },
            ],
            [
                re.compile("харьцаа (([0-9]+)[:]([0-9]+))\\b"), 1,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 040")
                    return self.ratio(x)
                },
            ],
            [
                re.compile("([0-9]{1,2}:[0-9]{1,2})-([0-9]{1,2}:[0-9]{1,2})"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 041")
                    return "\(x.group(1)!)N-GARAH \(x.group(2)!)"
                },
            ],
            [
                re.compile("([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2})( *секунд|)"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 042")
                    return self.time_writer(x.group(1)!, x.group(2)!, x.group(3)!)
                },
            ],
            [
                re.compile("([0-9]{1,2}):([0-9]{1,2})( *минут|)"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 043")
                    return self.time_writer(x.group(1)!, x.group(2)!)
                },
            ],
            [
                re.compile("\\b[0-9]{2}-[0-9]{6}\\b"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 044")
                    return x.group()!.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                },
            ],
            [
                re.compile("\\b(88|81|85|89|77|75|95|99|91|11|98|96|94|65|80)[0-9]{2}-[0-9]{4}\\b"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 045")
                    return x.group()!.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                },
            ],
            [
                re.compile("\\b(([0-9]{4})-([0-9]{4})) *(он|онуудад|онд)"), 1,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 046")
                    return "\(MongolianDigitLetter.number2word(x.group(2)!))N-GARAH \(MongolianDigitLetter.number2word(x.group(3)!, false))"
                },
            ],
            [
                re.compile("([0-9]+)( {0,1}\\* {0,1})"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 047")
                    return " үржих нь "
                },
            ],
            [
                re.compile("([0-9]+)( {0,1}\\+ {0,1})"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 048")
                    return " нэмэх нь "
                },
            ],
            [
                re.compile("([А-ЯӨҮЁа-яөүё]+|^) ([-])[0-9]+"), 2,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 049")
                    return " хасах "
                },
            ],
            [
                re.compile("([0-9]+[\\.,]*[0-9]*)( {0,1}[А-ЯӨҮЁа-яөүё]*)( {0,1}- {0,1})([0-9]+[\\.,]*[0-9]*)(\\2)"), 3,
                { (_: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 050")
                    return "N-GARAH "
                },
            ],
            [
                re.compile("\\b[A-ZА-ЯӨҮЁ]{2} [0-9]{8}\\b"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 051")
                    return self.register(x.group()!.trimmingCharacters(in: .whitespacesAndNewlines))
                },
            ],
            [
                re.compile("\\b([0-9]{2}):([0-9]{2})"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 052")
                    return MongolianDigitLetter.time2word(x)
                },
            ],
            [
                re.compile("\\b([0-9]{4})([А-ЯӨҮЁ]{3})"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 053")
                    return try self.car_plate_num(x)
                },
            ],
            [
                re.compile("\\+([0-9]{2,3})[ -][0-9]{8}"), 1,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 054")
                    return MongolianDigitLetter.number2word(x.group(1)!.trimmingCharacters(in: .whitespacesAndNewlines))
                },
            ],
            [
                re.compile("\\b([0-9]{8})" + NUM_ENDED), 1,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 055")
                    return self.eight_digit(x.group(1)!.trimmingCharacters(in: .whitespacesAndNewlines))
                },
            ],
            [
                re.compile("\\b([0-9]{8})\\b"), 1,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 056")
                    return self.eight_digit(x.group(1)!.trimmingCharacters(in: .whitespacesAndNewlines))
                },
            ],
            [
                re.compile("[0-9]{1,3}(,[0-9]{3,3})+"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 057")
                    return x.group()!.replace(",", new: "")
                },
            ],
            [
                re.compile("[0-9]{1,2}(\\.[0-9]{1,2}){2,}"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 058")
                    return self.law_zuil(x.group()!)
                },
            ],
            [
                re.compile("\\b(зүйл|зүйлийн|дүрмийн|дүрэм) ?(\\b[0-9]+(\\.|,)[0-9]+)"), 2,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 059")
                    return self.law_zuil(x.group(2)!)
                },
            ],
            [
                re.compile("([0-9]+)/([0-9]+)"),
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 060")
                    return try self.proper_fraction(x)
                },
            ],
            [
                re.compile("\\b([0-9]+[\\.,][0-9]+)" + NUM_ENDED), 1,
                { (_ x: re.MatchObject, _ options: [String: Bool]) -> String in
                    print("regex 061")
                    return (options["read_legal_number"] ?? false)
                        ? self.law_zuil(x.group(1)!) : MongolianDigitLetter.fraction2word(x.group(1)!.trimmingCharacters(in: .whitespacesAndNewlines))
                },
            ],
            // return  law_zuil(x.group(1)) if options["read_legal_number"] else MongolianDigitLetter.fraction2word(x.group(1).trimmingCharacters(in: .whitespacesAndNewlines)) })),
            [
                re.compile("\\b[0-9]+(\\.|,)[0-9]+"),
                { (_ x: re.MatchObject, _ options: [String: Bool]) -> String in
                    print("regex 062")
                    return (options["read_legal_number"] ?? false)
                        ? self.law_zuil(x.group()!) : MongolianDigitLetter.fraction2word(x.group()!.trimmingCharacters(in: .whitespacesAndNewlines), false)
                },
            ],
            // return  law_zuil(x.group()) if options["read_legal_number"] else MongolianDigitLetter.fraction2word(x.group().trimmingCharacters(in: .whitespacesAndNewlines), false) })),
            [
                re.compile("(^|\n)\\s*([0-9]{1,2}\\.) (.*)"), 2,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 063")
                    if let _ = re.search(self._numeric_regs[3], x.group(2)!) {
                        return x.group(2)!
                    } else {
                        return "\(MongolianDigitLetter.number2word(x.group(2)![0, -1]))-т"
                    }
                },
            ],
            // return  x.group(2) if re.search(#"\s([0-9]{1,2}\.)\s", x.group(3)) else MongolianDigitLetter.number2word(x.group(2)[:-1]) + "-т" })),
            [
                re.compile("\\b([0-9]+)" + NUM_ENDED), 1,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 064")
                    return " \(MongolianDigitLetter.number2word(x.group(1)!.trimmingCharacters(in: .whitespacesAndNewlines)))"
                },
            ],
            [
                re.compile("\\b(шинийн|Шинийн|билгийн|Билгийн) *([0-9]{1,2})"), 2,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 065")
                    return MongolianDigitLetter.number2word(x.group(2)!, false, true)
                },
            ],
            [
                re.compile("(?=\\b([0-9]+) +([0-9]+|нэг|хоёр|гурав|дөрөв|тав|зургаа|долоо|найм|ес)(\\b|$))"), 1,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 066")
                    return MongolianDigitLetter.number2word(x.group(1)!.trimmingCharacters(in: .whitespacesAndNewlines))
                },
            ],
            [
                re.compile("\\b[0-9]+"), 0,
                { (_ x: re.MatchObject, _ options: [String: Bool]) -> String in
                    print("regex 067")
                    return "\(MongolianDigitLetter.number2word(x.group()!.trimmingCharacters(in: .whitespacesAndNewlines), options["dont_read_number_n"] ?? false)) "
                },
            ],
            [
                re.compile("([0-9]+)"), 1,
                { (_ x: re.MatchObject, _: [String: Bool]) -> String in
                    print("regex 068")
                    return " \(MongolianDigitLetter.number2word(x.group(1)!.trimmingCharacters(in: .whitespacesAndNewlines))) "
                },
            ],
        ]
    }

    public func register(_ txt: String) -> String {
        return " ".join(txt.split()[0]) + " " + eight_digit(txt.split()[1])
    }

    public func ratio(_ match: re.MatchObject, _ second_fraction: Bool = false) -> String {
        let first_num = MongolianDigitLetter.number2word(match.group(2)!)
        var second_num: String
        if !second_fraction {
            second_num = MongolianDigitLetter.number2word(match.group(3)!)
        } else {
            second_num = MongolianDigitLetter.fraction2word(match.group(3)!)
        }

        return first_num + "N-ZAAH харьцах нь " + second_num
    }

    public func car_plate_num(_ plate: re.MatchObject) throws -> String {
        guard let numbers = plate.group(1) else {
            throw "plate group1"
        }
        guard let chars = plate.group(2) else {
            throw "plate group2"
        }

        let nums = " ".join([0, 1].map { MongolianDigitLetter.number2word(numbers[$0 * 2, $0 * 2 + 2]) })

        return nums + " " + chars
    }

    public func eight_digit(_ txt: String) -> String {
        var tmp: [String] = []

        for i in 0 ..< 4 {
            if txt[i * 2, i * 2 + 1] == "0" {
                tmp.append("тэг " + MongolianDigitLetter.number2word(txt[i * 2 + 1, i * 2 + 2]))
            } else {
                tmp.append(MongolianDigitLetter.number2word(txt[i * 2, i * 2 + 2]))
            }
        }

        return " ".join(tmp)
    }

    public func four_digit(_ txt: String) -> String {
        var tmp: [String] = []

        for i in 0 ..< 2 {
            if txt[i * 2, i * 2 + 1] == "0" {
                tmp.append("тэг " + MongolianDigitLetter.number2word(txt[i * 2 + 1, i * 2 + 2]))
            } else {
                tmp.append(MongolianDigitLetter.number2word(txt[i * 2, i * 2 + 2]))
            }
        }

        return " ".join(tmp)
    }

    public func time_writer(_ hour: String = "00", _ minute: String = "00", _ second: String = "00") -> String {
        var result = MongolianDigitLetter.number2word(hour, false) + " цаг"
        if minute != "00" {
            result += " " + MongolianDigitLetter.number2word(minute, false) + " минут"
        }
        if second != "00" {
            result += " " + MongolianDigitLetter.number2word(second, false) + " секунд"
        }

        return result
    }

    public func date(args: [String], end: String = "", range: Bool = false) -> String {
        var text = MongolianDigitLetter.date2word(".".join(args), range)
        if end != "" {
            text = text + "n-hariyalah өдөр"
        }

        return text
    }

    public func law_zuil(_ zuil: String) -> String {
        if zuil.contains(".") {
            let zuils = zuil.components(separatedBy: ".")

            let need_suffix = zuils[0 ..< (zuils.count - 1)]
            var attached_suffix: [String] = []

            for zui in need_suffix {
                let zuil_str = MongolianDigitLetter.number2word(zui)
                attached_suffix.append(zuil_str + "N-HARIYALAH")
            }

            attached_suffix.append(MongolianDigitLetter.number2word(zuils[zuils.count - 1]))

            return " ".join(attached_suffix)
        } else {
            return zuil
        }
    }

    public func pad(_ txt: String) -> String {
        var txt = txt
        txt = re.sub(_numeric_regs[0], "$1 $2", txt)

        return " \(txt) "
    }

    public func combine_suffix(_ word: String, _ suffix: String) throws -> String {
        var suffix_code = ""

        for code in suffix_code_map.keys {
            guard let _suff = suffix_code_map[code] else {
                throw "code not in suffix code map"
            }
            if _suff.contains(re.sub(_numeric_regs[1], "", suffix)) {
                suffix_code = code
                break
            }
        }

        if suffix_code != "" {
            return try conjugator.form_conjugations(word, suffix_code.trimmingCharacters(in: .whitespacesAndNewlines))[0]
        } else {
            return try conjugator.conjugate(word, suffix)
        }
    }

    public func resolve_conjugations(_ text: String) throws -> String {
        var text = text
        let conjugation_matches = re.finditer(conjugation_merger_regex, text)
        for match in conjugation_matches.reversed() {
            guard let _1 = match.group(1) else {
                throw "resolve conj match1"
            }
            guard let _2 = match.group(2) else {
                throw "resolve conj match1"
            }

            var conjugated_word = _1

            conjugated_word = try conjugator.form_conjugations(conjugated_word, _2)[0] + " "
            let _nsrange = match.match.range(at: 0)

            let _start = text.index(text.startIndex, offsetBy: _nsrange.location)
            let _end = text.index(_start, offsetBy: _nsrange.length)
            text = "\(text[..<_start])\(conjugated_word.trimmingCharacters(in: .whitespacesAndNewlines))\(text[_end...])"
        }
        let suffix_match_after_metrics = re.finditer(_numeric_regs[2], text).reversed()
        for match in suffix_match_after_metrics {
            guard let word = match.group(1) else {
                throw "resolve conj match1 "
            }
            guard let suffix = match.group(2) else {
                throw "resolve conj match1 "
            }

            if !MongolianDigitLetter.number_words.contains(suffix) {
                let conjugated = try combine_suffix(word, suffix)
                let _nsrange = match.match.range(at: 0)

                let _start = text.index(text.startIndex, offsetBy: _nsrange.location)
                let _end = text.index(_start, offsetBy: _nsrange.length)
                
                text = "\(text[..<_start]) \(conjugated.trimmingCharacters(in: .whitespacesAndNewlines)) \(text[_end...])"
            }
        }
        return text
    }

    public func proper_fraction(_ fraction: re.MatchObject) throws -> String {
        guard let grp1 = fraction.group(1) else {
            throw "fraction1"
        }

        guard let grp2 = fraction.group(2) else {
            throw "fraction2"
        }
        let numerator = MongolianDigitLetter.number2word(grp1)
        var dominator = MongolianDigitLetter.number2word(grp2, false)

        if dominator == "нэг" {
            dominator = "нэгэн"
        }
        if dominator == "хоёр" {
            dominator = "хоёрон"
        }

        return dominator + "n-hariyalah " + numerator
    }

    public let suffix_code_map: [String: [String]]
    private let NUM_ENDED: String
    private var l: [[Any]]

    private let conjugation_codes: [String]
    private let conjugation_merger_regex: re.RegexObject
    private let conjugator: Conjugator

    public func ip_address(_ match: re.MatchObject) -> String {
        var replacement = ""

        let ips = [match.group(1)!, match.group(2)!, match.group(3)!]
        var port = match.group(5)!

        for ip in ips {
            let _ip = re.sub(_numeric_regs[4], "", ip)

            replacement = "\(replacement)\(MongolianDigitLetter.number2word(_ip)) N-HARIYALAH "
        }

        let last_ip = match.group(4)!
        replacement = "\(replacement)\(MongolianDigitLetter.number2word(last_ip))"

        if port != "" {
            replacement = "\(replacement) N-HARIYALAH "
            port = re.sub(_numeric_regs[5], "", port)
            replacement = "\(replacement)\(MongolianDigitLetter.number2word(port)) порт"
        }

        return replacement
    }

    let _numeric_regs = [
        re.compile("([А-ЯӨҮЁа-яөүё])([0-9])"),
        re.compile("[,.!?]"),
        re.compile("([А-ЯӨҮЁа-яөүё]+)-([а-яөүё]+)"),
        re.compile("\\s([0-9]{1,2}\\.)\\s"),
        re.compile("[.]"),
        re.compile("[:]"),
        re.compile("([0-9]{1}|[.,])"),
        re.compile("\\b([0-9]+)\\b"),
        re.compile(" +"),
        re.compile("([А-ЯӨҮЁа-яөүё])-([0-9]+) "),
        re.compile("( доллар| төгрөг| евро| иен| фунт)(([0-9]+[.][0-9]+|[0-9]+) *(сая|мянга|зуу|тэрбум|))(-)\\1([0-9]+ *(сая|мянга|зуу|тэрбум|))"),
        // re.compile("( доллар| төгрөг| евро| иен| фунт)(([0-9]+[.][0-9]+|[0-9]+) *(сая|мянга|зуу|тэрбум|))(-)\\1([0-9]+ *(сая|мянга|зуу|тэрбум|))"),
        re.compile("( доллар| төгрөг| евро| иен| фунт)(([0-9]+[.][0-9]+|[0-9]+) *(сая|мянга|зуу|тэрбум|)([а-яөүё]+\\b))"),
        re.compile("\\s+"),
        re.compile("([0-9]{2}|[.,])"),
        re.compile("([ ]|^)([0]+)([0-9]+)\\b"),
    ]

    override public func callAsFunction(_ input_text: [String: Any]) throws -> [String: Any] {
        var text = input_text["text"] as! String
        let number_chunker = input_text["number_chunker"] as! String
        var input_text = input_text
        // var dont_read_number_n = input_text["dont_read_number_n"] as! Bool
        // let read_legal_number = read_legal_number
        if number_chunker == "single" {
            text = re.sub(_numeric_regs[6], " $1 ", text)
        } else if number_chunker == "double" {
            text = re.sub(_numeric_regs[13], " $1 ", text)
            input_text["dont_read_number_n"] = true
        } else if number_chunker == "whole" {
            text = re.sub(_numeric_regs[7], {m -> String in 
                return MongolianDigitLetter.number2word(m.group(1)!)
            }, text)
        } else if number_chunker != "default" {
            throw "Unsupported number chunking option"
        }
        text = re.sub(_numeric_regs[8], " ", text)
        text = re.sub(_numeric_regs[9], { x in
            "\(x.group(1)!) \(x.group(2)!)[END] "
        }, text)
        // re.compile("([ ]|^)([0]+)([0-9]+)\\b"),

        let heading_zero_matches = re.finditer(_numeric_regs[14], text).reversed()
        for m in heading_zero_matches {
            let _nsrange = m.match.range(at: 2)

            let _start = text.index(text.startIndex, offsetBy: _nsrange.location)
            let _end = text.index(_start, offsetBy: _nsrange.length)
            text = "\(text[..<_start])\(m.group(2)!.replacingOccurrences(of: "0", with: "~ZERO~"))\(text[_end...])"
        }

        // text = re.sub(_numeric_regs[14], { m -> String in
        //     let zeros = m.group(2)!
        //     let zeros_count = zeros.count
        //     return "\(m.group(1)!)\(" энчээ баахан тэгнүүд байх ёстой " * zeros_count)\(m.group(3)!)"
        // }, text)
        text = re.sub(_numeric_regs[10], "$2$5$6 $1", text)
        text = re.sub(_numeric_regs[11], "$2$1", text)
        text = pad(text)
        let opts = [
                    "read_legal_number": input_text["read_legal_number"] as! Bool,
                    "dont_read_number_n": input_text["dont_read_number_n"] as! Bool,
                ]
        for z in l {
            var reg: re.RegexObject
            var g: Int
            var repl: (_: re.MatchObject, _: [String: Bool]) throws -> String
            if z.count == 4 {
                reg = z[0] as! re.RegexObject
                g = z[1] as! Int
                repl = z[2] as! (_: re.MatchObject, _: [String: Bool]) throws -> String
            } else if z.count == 3 {
                reg = z[0] as! re.RegexObject
                g = z[1] as! Int
                repl = z[2] as! (_: re.MatchObject, _: [String: Bool]) throws -> String
            } else {
                reg = z[0] as! re.RegexObject
                g = 0
                repl = z[1] as! (_: re.MatchObject, _: [String: Bool]) throws -> String
            }

            var matches = re.finditer(reg, text)

            matches.sort(key: { x in
                -x.match.range(at: 0).location
            })

            for m in matches {
                if m.group(g) == nil {
                    continue
                }
                let res = try repl(m, opts)
                let nsrange = m.match.range(at: g)
                let startIndex = text.index(text.startIndex, offsetBy: nsrange.location)
                let endIndex = text.index(startIndex, offsetBy: nsrange.length)
                text = "\(text[..<startIndex])\(res)\(text[endIndex...])"
            }
        }
        text = try resolve_conjugations(text)
        text = re.sub(_numeric_regs[12], " ", text)
        text = text
            .replacingOccurrences(of: "цаг цаг", with: "цаг")
            .replacingOccurrences(of: "минут минут", with: "минут")

        input_text["text"] = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "[END]", with: "")
            .replacingOccurrences(of: "~ZERO~", with: "тэг ")

        return input_text
    }
}
