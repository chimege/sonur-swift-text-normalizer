import Foundation
import SwiftyPyRegex
public enum MongolianDigitLetter {
    public static let number_words = ["тэг", "нэг", "хоёр", "гурав", "дөрөв", "тав", "зургаа", "долоо", "найм", "ес", "мянга", "зуу", "арав", "тэрбум", "сая", "их наяд", "тунамал", "тэг", "арав", "хорь", "гуч", "дөч", "тавь", "жар", "дал", "ная", "ер"]
    public static let float_digit_name = ["мянга": "мянганы", "зуу": "зууны", "арав": "аравны"]
    public static let digit_name: [Int: String] = [1: "", 2: "мянга", 3: "сая", 4: "тэрбум", 5: "их наяд", 6: "тунамал"]
    public static let digit_name_k: [Int: String] = [1: "", 2: "мянган"]
    public static let day_digit: [String: String] = ["1": "нэгэн", "2": "хоёрон", "3": "гурван", "4": "дөрвөн", "5": "таван", "6": "зургаан", "7": "долоон", "8": "найман", "9": "есөн"]
    public static let day_digit2: [String: String] = ["1": "арван", "2": "хорин", "3": "гучин"]
    public static func number2word(_ number: String, _ is_fina: Bool = true, _ force_one_two_end: Bool = false) -> String {
        // var is_fina = !is_fina
        if !number.isdigit() {
            return number
        }

        if number.strip("0") == "" {
            return digit_by_one(number)
        }

        // let zeros_count = number.count - number.lstrip("0").count
        let number = number.lstrip("0")
        // var zeros_result = ""
        // for _ in 0 ..< zeros_count {
        //     zeros_result += digit_by_one("0") + " "
        // }
        let digit_len = number.count
        if force_one_two_end && ["1", "2"].contains(number) {
            if number == "1" {
                return "нэгэн"
            } else {
                return "хоёрон"
            }
        }
        if digit_len == 0 {
            return ""
        }
        if digit_len == 1 {
            return is_fina ? _last_digit_2_str(number) : _1_digit_var_2_str(number)
        }
        if digit_len == 2 {
            return _2_digits_2_str(number, is_fina)
        }
        if digit_len == 3 {
            return _3_digits_to_str(number, is_fina)
        }
        if digit_len < 7 {
            var prk = _3_digits_to_str(number[0, -3], false, true)
            if prk == "нэг" {
                prk = ""
            }
            if number[-3, number.count] == "000" {
                let kname = is_fina ? digit_name[2] : digit_name_k[2]
                return "\(prk) \(kname!)".trimmingCharacters(in: .whitespacesAndNewlines)
            }

            return "\(prk) \(digit_name[2]!) \(_3_digits_to_str(number[-3, number.count], is_fina))".trimmingCharacters(in: .whitespacesAndNewlines)
        }
        // TODO: 7-8 digits
        var digitgroup = [String]()
        for i in stride(from: number.count, to: 0, by: -3).reversed() {
            let start = i - 3
            let end = i
            let digit = number[start < 0 ? 0 : start, end]
            digitgroup.append(digit)
        }

        if digitgroup.count > 6 {
            return digit_by_one(number)
        }

        // split digits into 3 digits from back
        // while last > 0 {
        //     let start = max(0, last - 3)
        //     digitgroup.insert(number[start, last], at: 0)
        //     last = start
        // }

        var i = 0
        var result = ""
        let count = digitgroup.count
        while i < count-1 {
            let read_one = i != 0 ? true : false
            let res = _3_digits_to_str(digitgroup[i], false, true, read_one)
            if res.count > 0 {
                result = "\(result) \(res) \(digit_name[count - i]!)"
            }
            i += 1
        }

        return "\(result.trimmingCharacters(in: .whitespacesAndNewlines)) \(_3_digits_to_str(digitgroup[digitgroup.count - 1], is_fina))".trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public static func time2word(_ match: re.MatchObject) -> String {
        let hour = _2_digits_2_str(match.group(1)!, false) + " цаг "
        var minute = _2_digits_2_str(match.group(2)!, false)

        if minute != "тэг", minute != "тэг тэг", minute != "" {
            minute += " минут"
        } else {
            minute = ""
        }

        return hour + minute
    }

    public static func fraction2word(_ number_str: String, _ is_fina: Bool = true) -> String {
        let number = number_str.replace(".", new: ",")
        if number.count(",") != 1 {
            return number_str
        }

        var parts = number.split(",")
        parts[1] = parts[1].rstrip("0")

        if parts[1].count == 0 {
            return number2word(parts[0], is_fina)
        }

        var result: [String] = []
        result.append(number2word(parts[0], true))

        var fraction_pre = "1"
        var pre_part = ""
        for _ in 0 ..< parts[1].count {
            fraction_pre += "0"
        }

        if fraction_pre.count < 7 {
            pre_part = number2word(fraction_pre, true)
            if pre_part.contains(" ") {
                let _rsplitted = pre_part.rsplit(" ", maxsplit: 1)
                let part_one = _rsplitted[0]
                let part_two = _rsplitted[1]

                pre_part = " ".join([part_one, float_digit_name[part_two]!])
            } else {
                pre_part = float_digit_name[pre_part]!
            }
        } else {
            pre_part = "таслал"
        }

        result.append(pre_part)
        result.append(number2word(parts[1].lstrip("0"), is_fina))
        return " ".join(result)
    }

    public static func digit_by_one(_ numstr: String) -> String {
        return " ".join(numstr.map { _last_digit_2_str("\($0)") })
    }

    public static func date2word(_ numstr: String, _ range: Bool) -> String {
        let date_parts = numstr.split(".")
        if date_parts.count == 4 {
            if range {
                return "\(number2word(date_parts[0], false)) оны \(number2word(date_parts[1], false)) сарын \(_day_number2word(date_parts[2]))N-GARAH \(_day_number2word(date_parts[3]))"
            }
        } else if date_parts.count == 3 {
            if range {
                return "\(number2word(date_parts[0], false)) сарын \(_day_number2word(date_parts[1]))N-GARAH \(_day_number2word(date_parts[2]))"
            } else {
                return "\(number2word(date_parts[0], false)) оны \(number2word(date_parts[1], false)) сарын \(_day_number2word(date_parts[2]))"
            }
        } else if date_parts.count == 2 {
            if range {
                return " сарын \(_day_number2word(date_parts[0]))N-GARAH \(_day_number2word(date_parts[1]))"
            } else {
                return "\(number2word(date_parts[0], false)) сарын \(_day_number2word(date_parts[1]))"
            }
        }
        return _day_number2word(numstr)
    }

    public static func _day_number2word(_ number: String) -> String {
        if number == "0" {
            return ""
        }
        if number.count == 1, Int(number)! > 0 {
            return day_digit[number]!
        }
        if number[0, 1] == "0" {
            return day_digit[number[1, 2]]!
        }
        if number[1, 2] == "0" {
            return day_digit2[number[0, 1]]!
        }
        return "\(day_digit2[number[0, 1]]!) \(day_digit[number[1, 2]]!)".trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public static func dugaar(_ number: String) -> String {
        let num = number2word(number)
        let last_number = num.split(" ").last!

        if ConjDetection.detect_word_gender(last_number) == "feminine" {
            return " дүгээр "
        } else {
            return " дугаар "
        }
    }

    public static func _1_digit_2_str(_ digit: String) -> String {
        return ["0": "", "1": "нэгэн", "2": "хоёр", "3": "гурван", "4": "дөрвөн", "5": "таван", "6": "зургаан", "7": "долоон", "8": "найман", "9": "есөн"][digit]!
    }

    public static func _1_digit_var_2_str(_ digit: String) -> String {
        return ["0": "", "1": "нэг", "2": "хоёр", "3": "гурван", "4": "дөрвөн", "5": "таван", "6": "зургаан", "7": "долоон", "8": "найман", "9": "есөн"][digit]!
    }

    public static func _last_digit_2_str(_ digit: String) -> String {
        return ["0": "тэг", "1": "нэг", "2": "хоёр", "3": "гурав", "4": "дөрөв", "5": "тав", "6": "зургаа", "7": "долоо", "8": "найм", "9": "ес"][digit]!
    }

    public static func _2_digits_2_str(_ digit: String, _ is_fina: Bool = true) -> String {
        let word2 = ["0": "", "1": "арван", "2": "хорин", "3": "гучин", "4": "дөчин", "5": "тавин", "6": "жаран", "7": "далан", "8": "наян", "9": "ерэн"]

        let word2fina = ["00": "тэг", "10": "арав", "20": "хорь", "30": "гуч", "40": "дөч", "50": "тавь", "60": "жар", "70": "дал", "80": "ная", "90": "ер"]

        if digit[1, 2] == "0" {
            return is_fina ? word2fina[digit]! : word2[digit[0, 1]]!
        }

        let digit1 = is_fina ? _last_digit_2_str(digit[1, 2]) : _1_digit_2_str(digit[1, 2])
        return "\(word2[digit[0, 1]]!) \(digit1)".trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public static func _3_digits_to_str(_ digit: String, _ is_fina: Bool = true, _ preK: Bool = false, _ read_one: Bool = false) -> String {
        let digstr = digit.lstrip("0")

        if digstr.count == 0 {
            return ""
        }
        if digstr.count == 1 {
            return preK ? _1_digit_var_2_str(digstr) : _last_digit_2_str(digstr)
        }

        if digstr.count == 2 {
            return _2_digits_2_str(digstr, is_fina)
        }

        if digit[-2, digit.count] == "00" {
            if digit[0, 1] == "1" {
                if read_one {
                    return is_fina ? "нэг зуу" : "нэг зуун"
                }
                return is_fina ? "зуу" : "зуун"
            }

            return is_fina ? _1_digit_var_2_str(digit[0, 1]) + " зуу " : _1_digit_var_2_str(digit[0, 1]) + " зуун "
        }

        if digit[0, 1] == "1" {
            return "зуун " + _2_digits_2_str(digit[-2, digit.count], is_fina)
        }

        return "\(_1_digit_var_2_str(digit[0, 1])) зуун \(_2_digits_2_str(digit[-2, digit.count], is_fina))"
    }
}
