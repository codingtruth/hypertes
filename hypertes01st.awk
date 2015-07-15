#!/bin/awk -f

function tes_init()
{
	tes_n = "01"
	title_book = "תלמוד עשר הספירות"
    title_helek = "חלק ראשון צמצום וקו"
    title_questions_words = "לוח שאלות לפירוש המלות"
    title_answers_words = "לוח התשובות לפירוש המלות"
	title_questions_inyanim = "לוח שאלות לענינים"
	title_answers_inyanim = "לוח התשובות לענינים"
	colontitle_regex = "תלמוד עשר הספירות"
	colontitle_regex1 = "חלק"

    manual_typos[1] =        "זה) עי\' לעיל תשובה ס\"ד."
    manual_typos_fixes[1] =  "עה) עי\' לעיל תשובה ס\"ד."
    manual_typos[2] =        "^\\."
    manual_typos_fixes[2] =  ""
    manual_typos[3] =        "----------------------------"
    manual_typos_fixes[3] =  ""
	manual_typos[4] =		 "ולכלים דאחור, שהם אח\"פ או תבה\"י שכבר שלט"
	manual_typos_fixes[4] =	 "ולכלים דאחור, שהם אח\"פ או תנה\"י שכבר שלט"
	manual_typos[5] =		 "ותבהי\"מ דגוף, נעשו לחיצוניות ואחורים דגוף"
	manual_typos_fixes[5] =	 "ותנהי\"מ דגוף, נעשו לחיצוניות ואחורים דגוף"
}
