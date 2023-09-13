
let casefoldTable: [UInt32: String] = [
    0x0041: "\u{0061}",
    0x0042: "\u{0062}",
    0x0043: "\u{0063}",
    0x0044: "\u{0064}",
    0x0045: "\u{0065}",
    0x0046: "\u{0066}",
    0x0047: "\u{0067}",
    0x0048: "\u{0068}",
    0x0049: "\u{0069}",
    0x004A: "\u{006A}",
    0x004B: "\u{006B}",
    0x004C: "\u{006C}",
    0x004D: "\u{006D}",
    0x004E: "\u{006E}",
    0x004F: "\u{006F}",
    0x0050: "\u{0070}",
    0x0051: "\u{0071}",
    0x0052: "\u{0072}",
    0x0053: "\u{0073}",
    0x0054: "\u{0074}",
    0x0055: "\u{0075}",
    0x0056: "\u{0076}",
    0x0057: "\u{0077}",
    0x0058: "\u{0078}",
    0x0059: "\u{0079}",
    0x005A: "\u{007A}",
    0x00B5: "\u{03BC}",
    0x00C0: "\u{00E0}",
    0x00C1: "\u{00E1}",
    0x00C2: "\u{00E2}",
    0x00C3: "\u{00E3}",
    0x00C4: "\u{00E4}",
    0x00C5: "\u{00E5}",
    0x00C6: "\u{00E6}",
    0x00C7: "\u{00E7}",
    0x00C8: "\u{00E8}",
    0x00C9: "\u{00E9}",
    0x00CA: "\u{00EA}",
    0x00CB: "\u{00EB}",
    0x00CC: "\u{00EC}",
    0x00CD: "\u{00ED}",
    0x00CE: "\u{00EE}",
    0x00CF: "\u{00EF}",
    0x00D0: "\u{00F0}",
    0x00D1: "\u{00F1}",
    0x00D2: "\u{00F2}",
    0x00D3: "\u{00F3}",
    0x00D4: "\u{00F4}",
    0x00D5: "\u{00F5}",
    0x00D6: "\u{00F6}",
    0x00D8: "\u{00F8}",
    0x00D9: "\u{00F9}",
    0x00DA: "\u{00FA}",
    0x00DB: "\u{00FB}",
    0x00DC: "\u{00FC}",
    0x00DD: "\u{00FD}",
    0x00DE: "\u{00FE}",
    0x00DF: "\u{0073}\u{0073}",
    0x0100: "\u{0101}",
    0x0102: "\u{0103}",
    0x0104: "\u{0105}",
    0x0106: "\u{0107}",
    0x0108: "\u{0109}",
    0x010A: "\u{010B}",
    0x010C: "\u{010D}",
    0x010E: "\u{010F}",
    0x0110: "\u{0111}",
    0x0112: "\u{0113}",
    0x0114: "\u{0115}",
    0x0116: "\u{0117}",
    0x0118: "\u{0119}",
    0x011A: "\u{011B}",
    0x011C: "\u{011D}",
    0x011E: "\u{011F}",
    0x0120: "\u{0121}",
    0x0122: "\u{0123}",
    0x0124: "\u{0125}",
    0x0126: "\u{0127}",
    0x0128: "\u{0129}",
    0x012A: "\u{012B}",
    0x012C: "\u{012D}",
    0x012E: "\u{012F}",
    0x0130: "\u{0069}\u{0307}",
    0x0132: "\u{0133}",
    0x0134: "\u{0135}",
    0x0136: "\u{0137}",
    0x0139: "\u{013A}",
    0x013B: "\u{013C}",
    0x013D: "\u{013E}",
    0x013F: "\u{0140}",
    0x0141: "\u{0142}",
    0x0143: "\u{0144}",
    0x0145: "\u{0146}",
    0x0147: "\u{0148}",
    0x0149: "\u{02BC}\u{006E}",
    0x014A: "\u{014B}",
    0x014C: "\u{014D}",
    0x014E: "\u{014F}",
    0x0150: "\u{0151}",
    0x0152: "\u{0153}",
    0x0154: "\u{0155}",
    0x0156: "\u{0157}",
    0x0158: "\u{0159}",
    0x015A: "\u{015B}",
    0x015C: "\u{015D}",
    0x015E: "\u{015F}",
    0x0160: "\u{0161}",
    0x0162: "\u{0163}",
    0x0164: "\u{0165}",
    0x0166: "\u{0167}",
    0x0168: "\u{0169}",
    0x016A: "\u{016B}",
    0x016C: "\u{016D}",
    0x016E: "\u{016F}",
    0x0170: "\u{0171}",
    0x0172: "\u{0173}",
    0x0174: "\u{0175}",
    0x0176: "\u{0177}",
    0x0178: "\u{00FF}",
    0x0179: "\u{017A}",
    0x017B: "\u{017C}",
    0x017D: "\u{017E}",
    0x017F: "\u{0073}",
    0x0181: "\u{0253}",
    0x0182: "\u{0183}",
    0x0184: "\u{0185}",
    0x0186: "\u{0254}",
    0x0187: "\u{0188}",
    0x0189: "\u{0256}",
    0x018A: "\u{0257}",
    0x018B: "\u{018C}",
    0x018E: "\u{01DD}",
    0x018F: "\u{0259}",
    0x0190: "\u{025B}",
    0x0191: "\u{0192}",
    0x0193: "\u{0260}",
    0x0194: "\u{0263}",
    0x0196: "\u{0269}",
    0x0197: "\u{0268}",
    0x0198: "\u{0199}",
    0x019C: "\u{026F}",
    0x019D: "\u{0272}",
    0x019F: "\u{0275}",
    0x01A0: "\u{01A1}",
    0x01A2: "\u{01A3}",
    0x01A4: "\u{01A5}",
    0x01A6: "\u{0280}",
    0x01A7: "\u{01A8}",
    0x01A9: "\u{0283}",
    0x01AC: "\u{01AD}",
    0x01AE: "\u{0288}",
    0x01AF: "\u{01B0}",
    0x01B1: "\u{028A}",
    0x01B2: "\u{028B}",
    0x01B3: "\u{01B4}",
    0x01B5: "\u{01B6}",
    0x01B7: "\u{0292}",
    0x01B8: "\u{01B9}",
    0x01BC: "\u{01BD}",
    0x01C4: "\u{01C6}",
    0x01C5: "\u{01C6}",
    0x01C7: "\u{01C9}",
    0x01C8: "\u{01C9}",
    0x01CA: "\u{01CC}",
    0x01CB: "\u{01CC}",
    0x01CD: "\u{01CE}",
    0x01CF: "\u{01D0}",
    0x01D1: "\u{01D2}",
    0x01D3: "\u{01D4}",
    0x01D5: "\u{01D6}",
    0x01D7: "\u{01D8}",
    0x01D9: "\u{01DA}",
    0x01DB: "\u{01DC}",
    0x01DE: "\u{01DF}",
    0x01E0: "\u{01E1}",
    0x01E2: "\u{01E3}",
    0x01E4: "\u{01E5}",
    0x01E6: "\u{01E7}",
    0x01E8: "\u{01E9}",
    0x01EA: "\u{01EB}",
    0x01EC: "\u{01ED}",
    0x01EE: "\u{01EF}",
    0x01F0: "\u{006A}\u{030C}",
    0x01F1: "\u{01F3}",
    0x01F2: "\u{01F3}",
    0x01F4: "\u{01F5}",
    0x01F6: "\u{0195}",
    0x01F7: "\u{01BF}",
    0x01F8: "\u{01F9}",
    0x01FA: "\u{01FB}",
    0x01FC: "\u{01FD}",
    0x01FE: "\u{01FF}",
    0x0200: "\u{0201}",
    0x0202: "\u{0203}",
    0x0204: "\u{0205}",
    0x0206: "\u{0207}",
    0x0208: "\u{0209}",
    0x020A: "\u{020B}",
    0x020C: "\u{020D}",
    0x020E: "\u{020F}",
    0x0210: "\u{0211}",
    0x0212: "\u{0213}",
    0x0214: "\u{0215}",
    0x0216: "\u{0217}",
    0x0218: "\u{0219}",
    0x021A: "\u{021B}",
    0x021C: "\u{021D}",
    0x021E: "\u{021F}",
    0x0220: "\u{019E}",
    0x0222: "\u{0223}",
    0x0224: "\u{0225}",
    0x0226: "\u{0227}",
    0x0228: "\u{0229}",
    0x022A: "\u{022B}",
    0x022C: "\u{022D}",
    0x022E: "\u{022F}",
    0x0230: "\u{0231}",
    0x0232: "\u{0233}",
    0x023A: "\u{2C65}",
    0x023B: "\u{023C}",
    0x023D: "\u{019A}",
    0x023E: "\u{2C66}",
    0x0241: "\u{0242}",
    0x0243: "\u{0180}",
    0x0244: "\u{0289}",
    0x0245: "\u{028C}",
    0x0246: "\u{0247}",
    0x0248: "\u{0249}",
    0x024A: "\u{024B}",
    0x024C: "\u{024D}",
    0x024E: "\u{024F}",
    0x0345: "\u{03B9}",
    0x0370: "\u{0371}",
    0x0372: "\u{0373}",
    0x0376: "\u{0377}",
    0x037F: "\u{03F3}",
    0x0386: "\u{03AC}",
    0x0388: "\u{03AD}",
    0x0389: "\u{03AE}",
    0x038A: "\u{03AF}",
    0x038C: "\u{03CC}",
    0x038E: "\u{03CD}",
    0x038F: "\u{03CE}",
    0x0390: "\u{03B9}\u{0308}\u{0301}",
    0x0391: "\u{03B1}",
    0x0392: "\u{03B2}",
    0x0393: "\u{03B3}",
    0x0394: "\u{03B4}",
    0x0395: "\u{03B5}",
    0x0396: "\u{03B6}",
    0x0397: "\u{03B7}",
    0x0398: "\u{03B8}",
    0x0399: "\u{03B9}",
    0x039A: "\u{03BA}",
    0x039B: "\u{03BB}",
    0x039C: "\u{03BC}",
    0x039D: "\u{03BD}",
    0x039E: "\u{03BE}",
    0x039F: "\u{03BF}",
    0x03A0: "\u{03C0}",
    0x03A1: "\u{03C1}",
    0x03A3: "\u{03C3}",
    0x03A4: "\u{03C4}",
    0x03A5: "\u{03C5}",
    0x03A6: "\u{03C6}",
    0x03A7: "\u{03C7}",
    0x03A8: "\u{03C8}",
    0x03A9: "\u{03C9}",
    0x03AA: "\u{03CA}",
    0x03AB: "\u{03CB}",
    0x03B0: "\u{03C5}\u{0308}\u{0301}",
    0x03C2: "\u{03C3}",
    0x03CF: "\u{03D7}",
    0x03D0: "\u{03B2}",
    0x03D1: "\u{03B8}",
    0x03D5: "\u{03C6}",
    0x03D6: "\u{03C0}",
    0x03D8: "\u{03D9}",
    0x03DA: "\u{03DB}",
    0x03DC: "\u{03DD}",
    0x03DE: "\u{03DF}",
    0x03E0: "\u{03E1}",
    0x03E2: "\u{03E3}",
    0x03E4: "\u{03E5}",
    0x03E6: "\u{03E7}",
    0x03E8: "\u{03E9}",
    0x03EA: "\u{03EB}",
    0x03EC: "\u{03ED}",
    0x03EE: "\u{03EF}",
    0x03F0: "\u{03BA}",
    0x03F1: "\u{03C1}",
    0x03F4: "\u{03B8}",
    0x03F5: "\u{03B5}",
    0x03F7: "\u{03F8}",
    0x03F9: "\u{03F2}",
    0x03FA: "\u{03FB}",
    0x03FD: "\u{037B}",
    0x03FE: "\u{037C}",
    0x03FF: "\u{037D}",
    0x0400: "\u{0450}",
    0x0401: "\u{0451}",
    0x0402: "\u{0452}",
    0x0403: "\u{0453}",
    0x0404: "\u{0454}",
    0x0405: "\u{0455}",
    0x0406: "\u{0456}",
    0x0407: "\u{0457}",
    0x0408: "\u{0458}",
    0x0409: "\u{0459}",
    0x040A: "\u{045A}",
    0x040B: "\u{045B}",
    0x040C: "\u{045C}",
    0x040D: "\u{045D}",
    0x040E: "\u{045E}",
    0x040F: "\u{045F}",
    0x0410: "\u{0430}",
    0x0411: "\u{0431}",
    0x0412: "\u{0432}",
    0x0413: "\u{0433}",
    0x0414: "\u{0434}",
    0x0415: "\u{0435}",
    0x0416: "\u{0436}",
    0x0417: "\u{0437}",
    0x0418: "\u{0438}",
    0x0419: "\u{0439}",
    0x041A: "\u{043A}",
    0x041B: "\u{043B}",
    0x041C: "\u{043C}",
    0x041D: "\u{043D}",
    0x041E: "\u{043E}",
    0x041F: "\u{043F}",
    0x0420: "\u{0440}",
    0x0421: "\u{0441}",
    0x0422: "\u{0442}",
    0x0423: "\u{0443}",
    0x0424: "\u{0444}",
    0x0425: "\u{0445}",
    0x0426: "\u{0446}",
    0x0427: "\u{0447}",
    0x0428: "\u{0448}",
    0x0429: "\u{0449}",
    0x042A: "\u{044A}",
    0x042B: "\u{044B}",
    0x042C: "\u{044C}",
    0x042D: "\u{044D}",
    0x042E: "\u{044E}",
    0x042F: "\u{044F}",
    0x0460: "\u{0461}",
    0x0462: "\u{0463}",
    0x0464: "\u{0465}",
    0x0466: "\u{0467}",
    0x0468: "\u{0469}",
    0x046A: "\u{046B}",
    0x046C: "\u{046D}",
    0x046E: "\u{046F}",
    0x0470: "\u{0471}",
    0x0472: "\u{0473}",
    0x0474: "\u{0475}",
    0x0476: "\u{0477}",
    0x0478: "\u{0479}",
    0x047A: "\u{047B}",
    0x047C: "\u{047D}",
    0x047E: "\u{047F}",
    0x0480: "\u{0481}",
    0x048A: "\u{048B}",
    0x048C: "\u{048D}",
    0x048E: "\u{048F}",
    0x0490: "\u{0491}",
    0x0492: "\u{0493}",
    0x0494: "\u{0495}",
    0x0496: "\u{0497}",
    0x0498: "\u{0499}",
    0x049A: "\u{049B}",
    0x049C: "\u{049D}",
    0x049E: "\u{049F}",
    0x04A0: "\u{04A1}",
    0x04A2: "\u{04A3}",
    0x04A4: "\u{04A5}",
    0x04A6: "\u{04A7}",
    0x04A8: "\u{04A9}",
    0x04AA: "\u{04AB}",
    0x04AC: "\u{04AD}",
    0x04AE: "\u{04AF}",
    0x04B0: "\u{04B1}",
    0x04B2: "\u{04B3}",
    0x04B4: "\u{04B5}",
    0x04B6: "\u{04B7}",
    0x04B8: "\u{04B9}",
    0x04BA: "\u{04BB}",
    0x04BC: "\u{04BD}",
    0x04BE: "\u{04BF}",
    0x04C0: "\u{04CF}",
    0x04C1: "\u{04C2}",
    0x04C3: "\u{04C4}",
    0x04C5: "\u{04C6}",
    0x04C7: "\u{04C8}",
    0x04C9: "\u{04CA}",
    0x04CB: "\u{04CC}",
    0x04CD: "\u{04CE}",
    0x04D0: "\u{04D1}",
    0x04D2: "\u{04D3}",
    0x04D4: "\u{04D5}",
    0x04D6: "\u{04D7}",
    0x04D8: "\u{04D9}",
    0x04DA: "\u{04DB}",
    0x04DC: "\u{04DD}",
    0x04DE: "\u{04DF}",
    0x04E0: "\u{04E1}",
    0x04E2: "\u{04E3}",
    0x04E4: "\u{04E5}",
    0x04E6: "\u{04E7}",
    0x04E8: "\u{04E9}",
    0x04EA: "\u{04EB}",
    0x04EC: "\u{04ED}",
    0x04EE: "\u{04EF}",
    0x04F0: "\u{04F1}",
    0x04F2: "\u{04F3}",
    0x04F4: "\u{04F5}",
    0x04F6: "\u{04F7}",
    0x04F8: "\u{04F9}",
    0x04FA: "\u{04FB}",
    0x04FC: "\u{04FD}",
    0x04FE: "\u{04FF}",
    0x0500: "\u{0501}",
    0x0502: "\u{0503}",
    0x0504: "\u{0505}",
    0x0506: "\u{0507}",
    0x0508: "\u{0509}",
    0x050A: "\u{050B}",
    0x050C: "\u{050D}",
    0x050E: "\u{050F}",
    0x0510: "\u{0511}",
    0x0512: "\u{0513}",
    0x0514: "\u{0515}",
    0x0516: "\u{0517}",
    0x0518: "\u{0519}",
    0x051A: "\u{051B}",
    0x051C: "\u{051D}",
    0x051E: "\u{051F}",
    0x0520: "\u{0521}",
    0x0522: "\u{0523}",
    0x0524: "\u{0525}",
    0x0526: "\u{0527}",
    0x0528: "\u{0529}",
    0x052A: "\u{052B}",
    0x052C: "\u{052D}",
    0x052E: "\u{052F}",
    0x0531: "\u{0561}",
    0x0532: "\u{0562}",
    0x0533: "\u{0563}",
    0x0534: "\u{0564}",
    0x0535: "\u{0565}",
    0x0536: "\u{0566}",
    0x0537: "\u{0567}",
    0x0538: "\u{0568}",
    0x0539: "\u{0569}",
    0x053A: "\u{056A}",
    0x053B: "\u{056B}",
    0x053C: "\u{056C}",
    0x053D: "\u{056D}",
    0x053E: "\u{056E}",
    0x053F: "\u{056F}",
    0x0540: "\u{0570}",
    0x0541: "\u{0571}",
    0x0542: "\u{0572}",
    0x0543: "\u{0573}",
    0x0544: "\u{0574}",
    0x0545: "\u{0575}",
    0x0546: "\u{0576}",
    0x0547: "\u{0577}",
    0x0548: "\u{0578}",
    0x0549: "\u{0579}",
    0x054A: "\u{057A}",
    0x054B: "\u{057B}",
    0x054C: "\u{057C}",
    0x054D: "\u{057D}",
    0x054E: "\u{057E}",
    0x054F: "\u{057F}",
    0x0550: "\u{0580}",
    0x0551: "\u{0581}",
    0x0552: "\u{0582}",
    0x0553: "\u{0583}",
    0x0554: "\u{0584}",
    0x0555: "\u{0585}",
    0x0556: "\u{0586}",
    0x0587: "\u{0565}\u{0582}",
    0x10A0: "\u{2D00}",
    0x10A1: "\u{2D01}",
    0x10A2: "\u{2D02}",
    0x10A3: "\u{2D03}",
    0x10A4: "\u{2D04}",
    0x10A5: "\u{2D05}",
    0x10A6: "\u{2D06}",
    0x10A7: "\u{2D07}",
    0x10A8: "\u{2D08}",
    0x10A9: "\u{2D09}",
    0x10AA: "\u{2D0A}",
    0x10AB: "\u{2D0B}",
    0x10AC: "\u{2D0C}",
    0x10AD: "\u{2D0D}",
    0x10AE: "\u{2D0E}",
    0x10AF: "\u{2D0F}",
    0x10B0: "\u{2D10}",
    0x10B1: "\u{2D11}",
    0x10B2: "\u{2D12}",
    0x10B3: "\u{2D13}",
    0x10B4: "\u{2D14}",
    0x10B5: "\u{2D15}",
    0x10B6: "\u{2D16}",
    0x10B7: "\u{2D17}",
    0x10B8: "\u{2D18}",
    0x10B9: "\u{2D19}",
    0x10BA: "\u{2D1A}",
    0x10BB: "\u{2D1B}",
    0x10BC: "\u{2D1C}",
    0x10BD: "\u{2D1D}",
    0x10BE: "\u{2D1E}",
    0x10BF: "\u{2D1F}",
    0x10C0: "\u{2D20}",
    0x10C1: "\u{2D21}",
    0x10C2: "\u{2D22}",
    0x10C3: "\u{2D23}",
    0x10C4: "\u{2D24}",
    0x10C5: "\u{2D25}",
    0x10C7: "\u{2D27}",
    0x10CD: "\u{2D2D}",
    0x13F8: "\u{13F0}",
    0x13F9: "\u{13F1}",
    0x13FA: "\u{13F2}",
    0x13FB: "\u{13F3}",
    0x13FC: "\u{13F4}",
    0x13FD: "\u{13F5}",
    0x1E00: "\u{1E01}",
    0x1E02: "\u{1E03}",
    0x1E04: "\u{1E05}",
    0x1E06: "\u{1E07}",
    0x1E08: "\u{1E09}",
    0x1E0A: "\u{1E0B}",
    0x1E0C: "\u{1E0D}",
    0x1E0E: "\u{1E0F}",
    0x1E10: "\u{1E11}",
    0x1E12: "\u{1E13}",
    0x1E14: "\u{1E15}",
    0x1E16: "\u{1E17}",
    0x1E18: "\u{1E19}",
    0x1E1A: "\u{1E1B}",
    0x1E1C: "\u{1E1D}",
    0x1E1E: "\u{1E1F}",
    0x1E20: "\u{1E21}",
    0x1E22: "\u{1E23}",
    0x1E24: "\u{1E25}",
    0x1E26: "\u{1E27}",
    0x1E28: "\u{1E29}",
    0x1E2A: "\u{1E2B}",
    0x1E2C: "\u{1E2D}",
    0x1E2E: "\u{1E2F}",
    0x1E30: "\u{1E31}",
    0x1E32: "\u{1E33}",
    0x1E34: "\u{1E35}",
    0x1E36: "\u{1E37}",
    0x1E38: "\u{1E39}",
    0x1E3A: "\u{1E3B}",
    0x1E3C: "\u{1E3D}",
    0x1E3E: "\u{1E3F}",
    0x1E40: "\u{1E41}",
    0x1E42: "\u{1E43}",
    0x1E44: "\u{1E45}",
    0x1E46: "\u{1E47}",
    0x1E48: "\u{1E49}",
    0x1E4A: "\u{1E4B}",
    0x1E4C: "\u{1E4D}",
    0x1E4E: "\u{1E4F}",
    0x1E50: "\u{1E51}",
    0x1E52: "\u{1E53}",
    0x1E54: "\u{1E55}",
    0x1E56: "\u{1E57}",
    0x1E58: "\u{1E59}",
    0x1E5A: "\u{1E5B}",
    0x1E5C: "\u{1E5D}",
    0x1E5E: "\u{1E5F}",
    0x1E60: "\u{1E61}",
    0x1E62: "\u{1E63}",
    0x1E64: "\u{1E65}",
    0x1E66: "\u{1E67}",
    0x1E68: "\u{1E69}",
    0x1E6A: "\u{1E6B}",
    0x1E6C: "\u{1E6D}",
    0x1E6E: "\u{1E6F}",
    0x1E70: "\u{1E71}",
    0x1E72: "\u{1E73}",
    0x1E74: "\u{1E75}",
    0x1E76: "\u{1E77}",
    0x1E78: "\u{1E79}",
    0x1E7A: "\u{1E7B}",
    0x1E7C: "\u{1E7D}",
    0x1E7E: "\u{1E7F}",
    0x1E80: "\u{1E81}",
    0x1E82: "\u{1E83}",
    0x1E84: "\u{1E85}",
    0x1E86: "\u{1E87}",
    0x1E88: "\u{1E89}",
    0x1E8A: "\u{1E8B}",
    0x1E8C: "\u{1E8D}",
    0x1E8E: "\u{1E8F}",
    0x1E90: "\u{1E91}",
    0x1E92: "\u{1E93}",
    0x1E94: "\u{1E95}",
    0x1E96: "\u{0068}\u{0331}",
    0x1E97: "\u{0074}\u{0308}",
    0x1E98: "\u{0077}\u{030A}",
    0x1E99: "\u{0079}\u{030A}",
    0x1E9A: "\u{0061}\u{02BE}",
    0x1E9B: "\u{1E61}",
    0x1E9E: "\u{0073}\u{0073}",
    0x1EA0: "\u{1EA1}",
    0x1EA2: "\u{1EA3}",
    0x1EA4: "\u{1EA5}",
    0x1EA6: "\u{1EA7}",
    0x1EA8: "\u{1EA9}",
    0x1EAA: "\u{1EAB}",
    0x1EAC: "\u{1EAD}",
    0x1EAE: "\u{1EAF}",
    0x1EB0: "\u{1EB1}",
    0x1EB2: "\u{1EB3}",
    0x1EB4: "\u{1EB5}",
    0x1EB6: "\u{1EB7}",
    0x1EB8: "\u{1EB9}",
    0x1EBA: "\u{1EBB}",
    0x1EBC: "\u{1EBD}",
    0x1EBE: "\u{1EBF}",
    0x1EC0: "\u{1EC1}",
    0x1EC2: "\u{1EC3}",
    0x1EC4: "\u{1EC5}",
    0x1EC6: "\u{1EC7}",
    0x1EC8: "\u{1EC9}",
    0x1ECA: "\u{1ECB}",
    0x1ECC: "\u{1ECD}",
    0x1ECE: "\u{1ECF}",
    0x1ED0: "\u{1ED1}",
    0x1ED2: "\u{1ED3}",
    0x1ED4: "\u{1ED5}",
    0x1ED6: "\u{1ED7}",
    0x1ED8: "\u{1ED9}",
    0x1EDA: "\u{1EDB}",
    0x1EDC: "\u{1EDD}",
    0x1EDE: "\u{1EDF}",
    0x1EE0: "\u{1EE1}",
    0x1EE2: "\u{1EE3}",
    0x1EE4: "\u{1EE5}",
    0x1EE6: "\u{1EE7}",
    0x1EE8: "\u{1EE9}",
    0x1EEA: "\u{1EEB}",
    0x1EEC: "\u{1EED}",
    0x1EEE: "\u{1EEF}",
    0x1EF0: "\u{1EF1}",
    0x1EF2: "\u{1EF3}",
    0x1EF4: "\u{1EF5}",
    0x1EF6: "\u{1EF7}",
    0x1EF8: "\u{1EF9}",
    0x1EFA: "\u{1EFB}",
    0x1EFC: "\u{1EFD}",
    0x1EFE: "\u{1EFF}",
    0x1F08: "\u{1F00}",
    0x1F09: "\u{1F01}",
    0x1F0A: "\u{1F02}",
    0x1F0B: "\u{1F03}",
    0x1F0C: "\u{1F04}",
    0x1F0D: "\u{1F05}",
    0x1F0E: "\u{1F06}",
    0x1F0F: "\u{1F07}",
    0x1F18: "\u{1F10}",
    0x1F19: "\u{1F11}",
    0x1F1A: "\u{1F12}",
    0x1F1B: "\u{1F13}",
    0x1F1C: "\u{1F14}",
    0x1F1D: "\u{1F15}",
    0x1F28: "\u{1F20}",
    0x1F29: "\u{1F21}",
    0x1F2A: "\u{1F22}",
    0x1F2B: "\u{1F23}",
    0x1F2C: "\u{1F24}",
    0x1F2D: "\u{1F25}",
    0x1F2E: "\u{1F26}",
    0x1F2F: "\u{1F27}",
    0x1F38: "\u{1F30}",
    0x1F39: "\u{1F31}",
    0x1F3A: "\u{1F32}",
    0x1F3B: "\u{1F33}",
    0x1F3C: "\u{1F34}",
    0x1F3D: "\u{1F35}",
    0x1F3E: "\u{1F36}",
    0x1F3F: "\u{1F37}",
    0x1F48: "\u{1F40}",
    0x1F49: "\u{1F41}",
    0x1F4A: "\u{1F42}",
    0x1F4B: "\u{1F43}",
    0x1F4C: "\u{1F44}",
    0x1F4D: "\u{1F45}",
    0x1F50: "\u{03C5}\u{0313}",
    0x1F52: "\u{03C5}\u{0313}\u{0300}",
    0x1F54: "\u{03C5}\u{0313}\u{0301}",
    0x1F56: "\u{03C5}\u{0313}\u{0342}",
    0x1F59: "\u{1F51}",
    0x1F5B: "\u{1F53}",
    0x1F5D: "\u{1F55}",
    0x1F5F: "\u{1F57}",
    0x1F68: "\u{1F60}",
    0x1F69: "\u{1F61}",
    0x1F6A: "\u{1F62}",
    0x1F6B: "\u{1F63}",
    0x1F6C: "\u{1F64}",
    0x1F6D: "\u{1F65}",
    0x1F6E: "\u{1F66}",
    0x1F6F: "\u{1F67}",
    0x1F80: "\u{1F00}\u{03B9}",
    0x1F81: "\u{1F01}\u{03B9}",
    0x1F82: "\u{1F02}\u{03B9}",
    0x1F83: "\u{1F03}\u{03B9}",
    0x1F84: "\u{1F04}\u{03B9}",
    0x1F85: "\u{1F05}\u{03B9}",
    0x1F86: "\u{1F06}\u{03B9}",
    0x1F87: "\u{1F07}\u{03B9}",
    0x1F88: "\u{1F00}\u{03B9}",
    0x1F89: "\u{1F01}\u{03B9}",
    0x1F8A: "\u{1F02}\u{03B9}",
    0x1F8B: "\u{1F03}\u{03B9}",
    0x1F8C: "\u{1F04}\u{03B9}",
    0x1F8D: "\u{1F05}\u{03B9}",
    0x1F8E: "\u{1F06}\u{03B9}",
    0x1F8F: "\u{1F07}\u{03B9}",
    0x1F90: "\u{1F20}\u{03B9}",
    0x1F91: "\u{1F21}\u{03B9}",
    0x1F92: "\u{1F22}\u{03B9}",
    0x1F93: "\u{1F23}\u{03B9}",
    0x1F94: "\u{1F24}\u{03B9}",
    0x1F95: "\u{1F25}\u{03B9}",
    0x1F96: "\u{1F26}\u{03B9}",
    0x1F97: "\u{1F27}\u{03B9}",
    0x1F98: "\u{1F20}\u{03B9}",
    0x1F99: "\u{1F21}\u{03B9}",
    0x1F9A: "\u{1F22}\u{03B9}",
    0x1F9B: "\u{1F23}\u{03B9}",
    0x1F9C: "\u{1F24}\u{03B9}",
    0x1F9D: "\u{1F25}\u{03B9}",
    0x1F9E: "\u{1F26}\u{03B9}",
    0x1F9F: "\u{1F27}\u{03B9}",
    0x1FA0: "\u{1F60}\u{03B9}",
    0x1FA1: "\u{1F61}\u{03B9}",
    0x1FA2: "\u{1F62}\u{03B9}",
    0x1FA3: "\u{1F63}\u{03B9}",
    0x1FA4: "\u{1F64}\u{03B9}",
    0x1FA5: "\u{1F65}\u{03B9}",
    0x1FA6: "\u{1F66}\u{03B9}",
    0x1FA7: "\u{1F67}\u{03B9}",
    0x1FA8: "\u{1F60}\u{03B9}",
    0x1FA9: "\u{1F61}\u{03B9}",
    0x1FAA: "\u{1F62}\u{03B9}",
    0x1FAB: "\u{1F63}\u{03B9}",
    0x1FAC: "\u{1F64}\u{03B9}",
    0x1FAD: "\u{1F65}\u{03B9}",
    0x1FAE: "\u{1F66}\u{03B9}",
    0x1FAF: "\u{1F67}\u{03B9}",
    0x1FB2: "\u{1F70}\u{03B9}",
    0x1FB3: "\u{03B1}\u{03B9}",
    0x1FB4: "\u{03AC}\u{03B9}",
    0x1FB6: "\u{03B1}\u{0342}",
    0x1FB7: "\u{03B1}\u{0342}\u{03B9}",
    0x1FB8: "\u{1FB0}",
    0x1FB9: "\u{1FB1}",
    0x1FBA: "\u{1F70}",
    0x1FBB: "\u{1F71}",
    0x1FBC: "\u{03B1}\u{03B9}",
    0x1FBE: "\u{03B9}",
    0x1FC2: "\u{1F74}\u{03B9}",
    0x1FC3: "\u{03B7}\u{03B9}",
    0x1FC4: "\u{03AE}\u{03B9}",
    0x1FC6: "\u{03B7}\u{0342}",
    0x1FC7: "\u{03B7}\u{0342}\u{03B9}",
    0x1FC8: "\u{1F72}",
    0x1FC9: "\u{1F73}",
    0x1FCA: "\u{1F74}",
    0x1FCB: "\u{1F75}",
    0x1FCC: "\u{03B7}\u{03B9}",
    0x1FD2: "\u{03B9}\u{0308}\u{0300}",
    0x1FD3: "\u{03B9}\u{0308}\u{0301}",
    0x1FD6: "\u{03B9}\u{0342}",
    0x1FD7: "\u{03B9}\u{0308}\u{0342}",
    0x1FD8: "\u{1FD0}",
    0x1FD9: "\u{1FD1}",
    0x1FDA: "\u{1F76}",
    0x1FDB: "\u{1F77}",
    0x1FE2: "\u{03C5}\u{0308}\u{0300}",
    0x1FE3: "\u{03C5}\u{0308}\u{0301}",
    0x1FE4: "\u{03C1}\u{0313}",
    0x1FE6: "\u{03C5}\u{0342}",
    0x1FE7: "\u{03C5}\u{0308}\u{0342}",
    0x1FE8: "\u{1FE0}",
    0x1FE9: "\u{1FE1}",
    0x1FEA: "\u{1F7A}",
    0x1FEB: "\u{1F7B}",
    0x1FEC: "\u{1FE5}",
    0x1FF2: "\u{1F7C}\u{03B9}",
    0x1FF3: "\u{03C9}\u{03B9}",
    0x1FF4: "\u{03CE}\u{03B9}",
    0x1FF6: "\u{03C9}\u{0342}",
    0x1FF7: "\u{03C9}\u{0342}\u{03B9}",
    0x1FF8: "\u{1F78}",
    0x1FF9: "\u{1F79}",
    0x1FFA: "\u{1F7C}",
    0x1FFB: "\u{1F7D}",
    0x1FFC: "\u{03C9}\u{03B9}",
    0x2126: "\u{03C9}",
    0x212A: "\u{006B}",
    0x212B: "\u{00E5}",
    0x2132: "\u{214E}",
    0x2160: "\u{2170}",
    0x2161: "\u{2171}",
    0x2162: "\u{2172}",
    0x2163: "\u{2173}",
    0x2164: "\u{2174}",
    0x2165: "\u{2175}",
    0x2166: "\u{2176}",
    0x2167: "\u{2177}",
    0x2168: "\u{2178}",
    0x2169: "\u{2179}",
    0x216A: "\u{217A}",
    0x216B: "\u{217B}",
    0x216C: "\u{217C}",
    0x216D: "\u{217D}",
    0x216E: "\u{217E}",
    0x216F: "\u{217F}",
    0x2183: "\u{2184}",
    0x24B6: "\u{24D0}",
    0x24B7: "\u{24D1}",
    0x24B8: "\u{24D2}",
    0x24B9: "\u{24D3}",
    0x24BA: "\u{24D4}",
    0x24BB: "\u{24D5}",
    0x24BC: "\u{24D6}",
    0x24BD: "\u{24D7}",
    0x24BE: "\u{24D8}",
    0x24BF: "\u{24D9}",
    0x24C0: "\u{24DA}",
    0x24C1: "\u{24DB}",
    0x24C2: "\u{24DC}",
    0x24C3: "\u{24DD}",
    0x24C4: "\u{24DE}",
    0x24C5: "\u{24DF}",
    0x24C6: "\u{24E0}",
    0x24C7: "\u{24E1}",
    0x24C8: "\u{24E2}",
    0x24C9: "\u{24E3}",
    0x24CA: "\u{24E4}",
    0x24CB: "\u{24E5}",
    0x24CC: "\u{24E6}",
    0x24CD: "\u{24E7}",
    0x24CE: "\u{24E8}",
    0x24CF: "\u{24E9}",
    0x2C00: "\u{2C30}",
    0x2C01: "\u{2C31}",
    0x2C02: "\u{2C32}",
    0x2C03: "\u{2C33}",
    0x2C04: "\u{2C34}",
    0x2C05: "\u{2C35}",
    0x2C06: "\u{2C36}",
    0x2C07: "\u{2C37}",
    0x2C08: "\u{2C38}",
    0x2C09: "\u{2C39}",
    0x2C0A: "\u{2C3A}",
    0x2C0B: "\u{2C3B}",
    0x2C0C: "\u{2C3C}",
    0x2C0D: "\u{2C3D}",
    0x2C0E: "\u{2C3E}",
    0x2C0F: "\u{2C3F}",
    0x2C10: "\u{2C40}",
    0x2C11: "\u{2C41}",
    0x2C12: "\u{2C42}",
    0x2C13: "\u{2C43}",
    0x2C14: "\u{2C44}",
    0x2C15: "\u{2C45}",
    0x2C16: "\u{2C46}",
    0x2C17: "\u{2C47}",
    0x2C18: "\u{2C48}",
    0x2C19: "\u{2C49}",
    0x2C1A: "\u{2C4A}",
    0x2C1B: "\u{2C4B}",
    0x2C1C: "\u{2C4C}",
    0x2C1D: "\u{2C4D}",
    0x2C1E: "\u{2C4E}",
    0x2C1F: "\u{2C4F}",
    0x2C20: "\u{2C50}",
    0x2C21: "\u{2C51}",
    0x2C22: "\u{2C52}",
    0x2C23: "\u{2C53}",
    0x2C24: "\u{2C54}",
    0x2C25: "\u{2C55}",
    0x2C26: "\u{2C56}",
    0x2C27: "\u{2C57}",
    0x2C28: "\u{2C58}",
    0x2C29: "\u{2C59}",
    0x2C2A: "\u{2C5A}",
    0x2C2B: "\u{2C5B}",
    0x2C2C: "\u{2C5C}",
    0x2C2D: "\u{2C5D}",
    0x2C2E: "\u{2C5E}",
    0x2C60: "\u{2C61}",
    0x2C62: "\u{026B}",
    0x2C63: "\u{1D7D}",
    0x2C64: "\u{027D}",
    0x2C67: "\u{2C68}",
    0x2C69: "\u{2C6A}",
    0x2C6B: "\u{2C6C}",
    0x2C6D: "\u{0251}",
    0x2C6E: "\u{0271}",
    0x2C6F: "\u{0250}",
    0x2C70: "\u{0252}",
    0x2C72: "\u{2C73}",
    0x2C75: "\u{2C76}",
    0x2C7E: "\u{023F}",
    0x2C7F: "\u{0240}",
    0x2C80: "\u{2C81}",
    0x2C82: "\u{2C83}",
    0x2C84: "\u{2C85}",
    0x2C86: "\u{2C87}",
    0x2C88: "\u{2C89}",
    0x2C8A: "\u{2C8B}",
    0x2C8C: "\u{2C8D}",
    0x2C8E: "\u{2C8F}",
    0x2C90: "\u{2C91}",
    0x2C92: "\u{2C93}",
    0x2C94: "\u{2C95}",
    0x2C96: "\u{2C97}",
    0x2C98: "\u{2C99}",
    0x2C9A: "\u{2C9B}",
    0x2C9C: "\u{2C9D}",
    0x2C9E: "\u{2C9F}",
    0x2CA0: "\u{2CA1}",
    0x2CA2: "\u{2CA3}",
    0x2CA4: "\u{2CA5}",
    0x2CA6: "\u{2CA7}",
    0x2CA8: "\u{2CA9}",
    0x2CAA: "\u{2CAB}",
    0x2CAC: "\u{2CAD}",
    0x2CAE: "\u{2CAF}",
    0x2CB0: "\u{2CB1}",
    0x2CB2: "\u{2CB3}",
    0x2CB4: "\u{2CB5}",
    0x2CB6: "\u{2CB7}",
    0x2CB8: "\u{2CB9}",
    0x2CBA: "\u{2CBB}",
    0x2CBC: "\u{2CBD}",
    0x2CBE: "\u{2CBF}",
    0x2CC0: "\u{2CC1}",
    0x2CC2: "\u{2CC3}",
    0x2CC4: "\u{2CC5}",
    0x2CC6: "\u{2CC7}",
    0x2CC8: "\u{2CC9}",
    0x2CCA: "\u{2CCB}",
    0x2CCC: "\u{2CCD}",
    0x2CCE: "\u{2CCF}",
    0x2CD0: "\u{2CD1}",
    0x2CD2: "\u{2CD3}",
    0x2CD4: "\u{2CD5}",
    0x2CD6: "\u{2CD7}",
    0x2CD8: "\u{2CD9}",
    0x2CDA: "\u{2CDB}",
    0x2CDC: "\u{2CDD}",
    0x2CDE: "\u{2CDF}",
    0x2CE0: "\u{2CE1}",
    0x2CE2: "\u{2CE3}",
    0x2CEB: "\u{2CEC}",
    0x2CED: "\u{2CEE}",
    0x2CF2: "\u{2CF3}",
    0xA640: "\u{A641}",
    0xA642: "\u{A643}",
    0xA644: "\u{A645}",
    0xA646: "\u{A647}",
    0xA648: "\u{A649}",
    0xA64A: "\u{A64B}",
    0xA64C: "\u{A64D}",
    0xA64E: "\u{A64F}",
    0xA650: "\u{A651}",
    0xA652: "\u{A653}",
    0xA654: "\u{A655}",
    0xA656: "\u{A657}",
    0xA658: "\u{A659}",
    0xA65A: "\u{A65B}",
    0xA65C: "\u{A65D}",
    0xA65E: "\u{A65F}",
    0xA660: "\u{A661}",
    0xA662: "\u{A663}",
    0xA664: "\u{A665}",
    0xA666: "\u{A667}",
    0xA668: "\u{A669}",
    0xA66A: "\u{A66B}",
    0xA66C: "\u{A66D}",
    0xA680: "\u{A681}",
    0xA682: "\u{A683}",
    0xA684: "\u{A685}",
    0xA686: "\u{A687}",
    0xA688: "\u{A689}",
    0xA68A: "\u{A68B}",
    0xA68C: "\u{A68D}",
    0xA68E: "\u{A68F}",
    0xA690: "\u{A691}",
    0xA692: "\u{A693}",
    0xA694: "\u{A695}",
    0xA696: "\u{A697}",
    0xA698: "\u{A699}",
    0xA69A: "\u{A69B}",
    0xA722: "\u{A723}",
    0xA724: "\u{A725}",
    0xA726: "\u{A727}",
    0xA728: "\u{A729}",
    0xA72A: "\u{A72B}",
    0xA72C: "\u{A72D}",
    0xA72E: "\u{A72F}",
    0xA732: "\u{A733}",
    0xA734: "\u{A735}",
    0xA736: "\u{A737}",
    0xA738: "\u{A739}",
    0xA73A: "\u{A73B}",
    0xA73C: "\u{A73D}",
    0xA73E: "\u{A73F}",
    0xA740: "\u{A741}",
    0xA742: "\u{A743}",
    0xA744: "\u{A745}",
    0xA746: "\u{A747}",
    0xA748: "\u{A749}",
    0xA74A: "\u{A74B}",
    0xA74C: "\u{A74D}",
    0xA74E: "\u{A74F}",
    0xA750: "\u{A751}",
    0xA752: "\u{A753}",
    0xA754: "\u{A755}",
    0xA756: "\u{A757}",
    0xA758: "\u{A759}",
    0xA75A: "\u{A75B}",
    0xA75C: "\u{A75D}",
    0xA75E: "\u{A75F}",
    0xA760: "\u{A761}",
    0xA762: "\u{A763}",
    0xA764: "\u{A765}",
    0xA766: "\u{A767}",
    0xA768: "\u{A769}",
    0xA76A: "\u{A76B}",
    0xA76C: "\u{A76D}",
    0xA76E: "\u{A76F}",
    0xA779: "\u{A77A}",
    0xA77B: "\u{A77C}",
    0xA77D: "\u{1D79}",
    0xA77E: "\u{A77F}",
    0xA780: "\u{A781}",
    0xA782: "\u{A783}",
    0xA784: "\u{A785}",
    0xA786: "\u{A787}",
    0xA78B: "\u{A78C}",
    0xA78D: "\u{0265}",
    0xA790: "\u{A791}",
    0xA792: "\u{A793}",
    0xA796: "\u{A797}",
    0xA798: "\u{A799}",
    0xA79A: "\u{A79B}",
    0xA79C: "\u{A79D}",
    0xA79E: "\u{A79F}",
    0xA7A0: "\u{A7A1}",
    0xA7A2: "\u{A7A3}",
    0xA7A4: "\u{A7A5}",
    0xA7A6: "\u{A7A7}",
    0xA7A8: "\u{A7A9}",
    0xA7AA: "\u{0266}",
    0xA7AB: "\u{025C}",
    0xA7AC: "\u{0261}",
    0xA7AD: "\u{026C}",
    0xA7B0: "\u{029E}",
    0xA7B1: "\u{0287}",
    0xA7B2: "\u{029D}",
    0xA7B3: "\u{AB53}",
    0xA7B4: "\u{A7B5}",
    0xA7B6: "\u{A7B7}",
    0xAB70: "\u{13A0}",
    0xAB71: "\u{13A1}",
    0xAB72: "\u{13A2}",
    0xAB73: "\u{13A3}",
    0xAB74: "\u{13A4}",
    0xAB75: "\u{13A5}",
    0xAB76: "\u{13A6}",
    0xAB77: "\u{13A7}",
    0xAB78: "\u{13A8}",
    0xAB79: "\u{13A9}",
    0xAB7A: "\u{13AA}",
    0xAB7B: "\u{13AB}",
    0xAB7C: "\u{13AC}",
    0xAB7D: "\u{13AD}",
    0xAB7E: "\u{13AE}",
    0xAB7F: "\u{13AF}",
    0xAB80: "\u{13B0}",
    0xAB81: "\u{13B1}",
    0xAB82: "\u{13B2}",
    0xAB83: "\u{13B3}",
    0xAB84: "\u{13B4}",
    0xAB85: "\u{13B5}",
    0xAB86: "\u{13B6}",
    0xAB87: "\u{13B7}",
    0xAB88: "\u{13B8}",
    0xAB89: "\u{13B9}",
    0xAB8A: "\u{13BA}",
    0xAB8B: "\u{13BB}",
    0xAB8C: "\u{13BC}",
    0xAB8D: "\u{13BD}",
    0xAB8E: "\u{13BE}",
    0xAB8F: "\u{13BF}",
    0xAB90: "\u{13C0}",
    0xAB91: "\u{13C1}",
    0xAB92: "\u{13C2}",
    0xAB93: "\u{13C3}",
    0xAB94: "\u{13C4}",
    0xAB95: "\u{13C5}",
    0xAB96: "\u{13C6}",
    0xAB97: "\u{13C7}",
    0xAB98: "\u{13C8}",
    0xAB99: "\u{13C9}",
    0xAB9A: "\u{13CA}",
    0xAB9B: "\u{13CB}",
    0xAB9C: "\u{13CC}",
    0xAB9D: "\u{13CD}",
    0xAB9E: "\u{13CE}",
    0xAB9F: "\u{13CF}",
    0xABA0: "\u{13D0}",
    0xABA1: "\u{13D1}",
    0xABA2: "\u{13D2}",
    0xABA3: "\u{13D3}",
    0xABA4: "\u{13D4}",
    0xABA5: "\u{13D5}",
    0xABA6: "\u{13D6}",
    0xABA7: "\u{13D7}",
    0xABA8: "\u{13D8}",
    0xABA9: "\u{13D9}",
    0xABAA: "\u{13DA}",
    0xABAB: "\u{13DB}",
    0xABAC: "\u{13DC}",
    0xABAD: "\u{13DD}",
    0xABAE: "\u{13DE}",
    0xABAF: "\u{13DF}",
    0xABB0: "\u{13E0}",
    0xABB1: "\u{13E1}",
    0xABB2: "\u{13E2}",
    0xABB3: "\u{13E3}",
    0xABB4: "\u{13E4}",
    0xABB5: "\u{13E5}",
    0xABB6: "\u{13E6}",
    0xABB7: "\u{13E7}",
    0xABB8: "\u{13E8}",
    0xABB9: "\u{13E9}",
    0xABBA: "\u{13EA}",
    0xABBB: "\u{13EB}",
    0xABBC: "\u{13EC}",
    0xABBD: "\u{13ED}",
    0xABBE: "\u{13EE}",
    0xABBF: "\u{13EF}",
    0xFB00: "\u{0066}\u{0066}",
    0xFB01: "\u{0066}\u{0069}",
    0xFB02: "\u{0066}\u{006C}",
    0xFB03: "\u{0066}\u{0066}\u{0069}",
    0xFB04: "\u{0066}\u{0066}\u{006C}",
    0xFB05: "\u{0073}\u{0074}",
    0xFB06: "\u{0073}\u{0074}",
    0xFB13: "\u{0574}\u{0576}",
    0xFB14: "\u{0574}\u{0565}",
    0xFB15: "\u{0574}\u{056B}",
    0xFB16: "\u{057E}\u{0576}",
    0xFB17: "\u{0574}\u{056D}",
    0xFF21: "\u{FF41}",
    0xFF22: "\u{FF42}",
    0xFF23: "\u{FF43}",
    0xFF24: "\u{FF44}",
    0xFF25: "\u{FF45}",
    0xFF26: "\u{FF46}",
    0xFF27: "\u{FF47}",
    0xFF28: "\u{FF48}",
    0xFF29: "\u{FF49}",
    0xFF2A: "\u{FF4A}",
    0xFF2B: "\u{FF4B}",
    0xFF2C: "\u{FF4C}",
    0xFF2D: "\u{FF4D}",
    0xFF2E: "\u{FF4E}",
    0xFF2F: "\u{FF4F}",
    0xFF30: "\u{FF50}",
    0xFF31: "\u{FF51}",
    0xFF32: "\u{FF52}",
    0xFF33: "\u{FF53}",
    0xFF34: "\u{FF54}",
    0xFF35: "\u{FF55}",
    0xFF36: "\u{FF56}",
    0xFF37: "\u{FF57}",
    0xFF38: "\u{FF58}",
    0xFF39: "\u{FF59}",
    0xFF3A: "\u{FF5A}",
    0x10400: "\u{10428}",
    0x10401: "\u{10429}",
    0x10402: "\u{1042A}",
    0x10403: "\u{1042B}",
    0x10404: "\u{1042C}",
    0x10405: "\u{1042D}",
    0x10406: "\u{1042E}",
    0x10407: "\u{1042F}",
    0x10408: "\u{10430}",
    0x10409: "\u{10431}",
    0x1040A: "\u{10432}",
    0x1040B: "\u{10433}",
    0x1040C: "\u{10434}",
    0x1040D: "\u{10435}",
    0x1040E: "\u{10436}",
    0x1040F: "\u{10437}",
    0x10410: "\u{10438}",
    0x10411: "\u{10439}",
    0x10412: "\u{1043A}",
    0x10413: "\u{1043B}",
    0x10414: "\u{1043C}",
    0x10415: "\u{1043D}",
    0x10416: "\u{1043E}",
    0x10417: "\u{1043F}",
    0x10418: "\u{10440}",
    0x10419: "\u{10441}",
    0x1041A: "\u{10442}",
    0x1041B: "\u{10443}",
    0x1041C: "\u{10444}",
    0x1041D: "\u{10445}",
    0x1041E: "\u{10446}",
    0x1041F: "\u{10447}",
    0x10420: "\u{10448}",
    0x10421: "\u{10449}",
    0x10422: "\u{1044A}",
    0x10423: "\u{1044B}",
    0x10424: "\u{1044C}",
    0x10425: "\u{1044D}",
    0x10426: "\u{1044E}",
    0x10427: "\u{1044F}",
    0x10C80: "\u{10CC0}",
    0x10C81: "\u{10CC1}",
    0x10C82: "\u{10CC2}",
    0x10C83: "\u{10CC3}",
    0x10C84: "\u{10CC4}",
    0x10C85: "\u{10CC5}",
    0x10C86: "\u{10CC6}",
    0x10C87: "\u{10CC7}",
    0x10C88: "\u{10CC8}",
    0x10C89: "\u{10CC9}",
    0x10C8A: "\u{10CCA}",
    0x10C8B: "\u{10CCB}",
    0x10C8C: "\u{10CCC}",
    0x10C8D: "\u{10CCD}",
    0x10C8E: "\u{10CCE}",
    0x10C8F: "\u{10CCF}",
    0x10C90: "\u{10CD0}",
    0x10C91: "\u{10CD1}",
    0x10C92: "\u{10CD2}",
    0x10C93: "\u{10CD3}",
    0x10C94: "\u{10CD4}",
    0x10C95: "\u{10CD5}",
    0x10C96: "\u{10CD6}",
    0x10C97: "\u{10CD7}",
    0x10C98: "\u{10CD8}",
    0x10C99: "\u{10CD9}",
    0x10C9A: "\u{10CDA}",
    0x10C9B: "\u{10CDB}",
    0x10C9C: "\u{10CDC}",
    0x10C9D: "\u{10CDD}",
    0x10C9E: "\u{10CDE}",
    0x10C9F: "\u{10CDF}",
    0x10CA0: "\u{10CE0}",
    0x10CA1: "\u{10CE1}",
    0x10CA2: "\u{10CE2}",
    0x10CA3: "\u{10CE3}",
    0x10CA4: "\u{10CE4}",
    0x10CA5: "\u{10CE5}",
    0x10CA6: "\u{10CE6}",
    0x10CA7: "\u{10CE7}",
    0x10CA8: "\u{10CE8}",
    0x10CA9: "\u{10CE9}",
    0x10CAA: "\u{10CEA}",
    0x10CAB: "\u{10CEB}",
    0x10CAC: "\u{10CEC}",
    0x10CAD: "\u{10CED}",
    0x10CAE: "\u{10CEE}",
    0x10CAF: "\u{10CEF}",
    0x10CB0: "\u{10CF0}",
    0x10CB1: "\u{10CF1}",
    0x10CB2: "\u{10CF2}",
    0x118A0: "\u{118C0}",
    0x118A1: "\u{118C1}",
    0x118A2: "\u{118C2}",
    0x118A3: "\u{118C3}",
    0x118A4: "\u{118C4}",
    0x118A5: "\u{118C5}",
    0x118A6: "\u{118C6}",
    0x118A7: "\u{118C7}",
    0x118A8: "\u{118C8}",
    0x118A9: "\u{118C9}",
    0x118AA: "\u{118CA}",
    0x118AB: "\u{118CB}",
    0x118AC: "\u{118CC}",
    0x118AD: "\u{118CD}",
    0x118AE: "\u{118CE}",
    0x118AF: "\u{118CF}",
    0x118B0: "\u{118D0}",
    0x118B1: "\u{118D1}",
    0x118B2: "\u{118D2}",
    0x118B3: "\u{118D3}",
    0x118B4: "\u{118D4}",
    0x118B5: "\u{118D5}",
    0x118B6: "\u{118D6}",
    0x118B7: "\u{118D7}",
    0x118B8: "\u{118D8}",
    0x118B9: "\u{118D9}",
    0x118BA: "\u{118DA}",
    0x118BB: "\u{118DB}",
    0x118BC: "\u{118DC}",
    0x118BD: "\u{118DD}",
    0x118BE: "\u{118DE}",
    0x118BF: "\u{118DF}",
]
