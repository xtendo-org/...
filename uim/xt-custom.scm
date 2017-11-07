(require-module "byeoru")

(byeoru-define-layout byeoru-layout-generous3final
 ;; Unshifted keys
 ("`" . "*")
 ("1" (jongseong-hieuh	     . (1 4)))
 ("2" (jongseong-ssangsios   . 5))
 ("3" (jongseong-bieub	     . (3 4)))
 ("4" (jungseong-yo	     . 1))
 ("5" (jungseong-yu	     . 1))
 ("6" (jungseong-ya	     . 1))
 ("7" (jungseong-ye	     . 1))
 ("8" (jungseong-ui	     . 4))
 ("9" (jungseong-u	     . 3))
 ("0" (choseong-kieuk	     . 1))
 ("-" . "-")
 ("=" . "=")
 ("q" (jongseong-sios	     . (3 4 5)))
 ("w" (jongseong-rieul	     . 3))
 ("e" (jungseong-yeo	     . 1))
 ("r" (jungseong-ae	     . (1 4)))
 ("t" (jungseong-eo	     . (1 4)))
 ("y" (choseong-rieul	     . 1))
 ("u" (choseong-digeud	     . (3 5)))
 ("i" (choseong-mieum	     . 1))
 ("o" (choseong-chieuch	     . 1))
 ("p" (choseong-pieup	     . 1))
 ("[" . "[")
 ("]" . "]")
 ("\\" . ":")
 ("a" (jongseong-ieung	     . 1))
 ("s" (jongseong-nieun	     . 3))
 ("d" (jungseong-i	     . (1 4)))
 ("f" (jungseong-a	     . (1 4)))
 ("g" (jungseong-eu	     . 3))
 ("h" (choseong-nieun	     . 1))
 ("j" (choseong-ieung	     . 1))
 ("k" (choseong-giyeog	     . (3 5)))
 ("l" (choseong-jieuj	     . (3 5)))
 (";" (choseong-bieub	     . (3 5)))
 ("'" (choseong-tieut	     . 1))
 ("z" (jongseong-mieum	     . (1 4)))
 ("x" (jongseong-giyeog	     . (3 4 5)))
 ("c" (jungseong-e	     . (1 4)))
 ("v" (jungseong-o	     . 1))
 ("b" (jungseong-u	     . 1))
 ("n" (choseong-sios	     . (3 5)))
 ("m" (choseong-hieuh	     . 1))
 ("/" (jungseong-o	     . 3))
 ;; Shifted keys
 ("~" . #x2026)		    ; U+203B, REFERENCE MARK
 ("!" (jongseong-ssanggiyeog . 5))
 ("@" (jongseong-rieulgiyeog . 4))
 ("#" (jongseong-jieuj	     . (1 4)))
 ("$" (jongseong-rieulpieup  . 4))
 ("%" (jongseong-rieultieut  . 4))
 ("^" . "^")
 ("&" . #x201c)		    ; U+201C, LEFT DOUBLE QUOTATION MARK
 ("*" . #x201d)		    ; U+201D, RIGHT DOUBLE QUOTATION MARK
 ("(" . "(")
 (")" . ")")
 ("_" . "_")
 ("Q" (jongseong-pieup	     . (1 4)))
 ("W" (jongseong-tieut	     . (1 4)))
 ("E" (jongseong-nieunjieuj  . 4))
 ("R" (jongseong-rieulhieuh  . 4))
 ("T" (jongseong-rieulsios   . 4))
 ("Y" . "5")
 ("U" . "6")
 ("I" . "7")
 ("O" . "8")
 ("P" . "9")
 ("{" . "%")
 ("}" . "/")
 ("|" . "\\")
 ;;	("|" . #x20a9)	    ; U+20A9, WON SIGN
 ("A" (jongseong-digeud	     . 1))
 ("S" (jongseong-nieunhieuh  . 4))
 ("D" (jongseong-rieulbieub  . 4))
 ("F" (jongseong-rieulmieum  . 4))
 ("G" (jungseong-yae	     . 1))
 ("H" . "0")
 ("J" . "1")
 ("K" . "2")
 ("L" . "3")
 (":" . "4")
 ("\"". #x00b7)		    ; U+00B7, MIDDLE DOT
 ("Z" (jongseong-chieuch     . 1))
 ("X" (jongseong-bieubsios   . 4))
 ("C" (jongseong-kieuk	     . 1))
 ("V" (jongseong-giyeogsios  . 4))
 ("B" . "?")
 ("N" . "-")
 ("M" . "\"")
 ("<" . "<")
 (">" . ">")
 ("?" . "!"))