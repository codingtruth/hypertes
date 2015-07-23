#!/bin/awk -f

function tes_init()
{
	tes_n = "03"
	title_book = "תלמוד עשר הספירות"
    title_helek = "חלק שלישי אור ישר ואור חוזר"
    title_questions_words = "לוח השאלות לפירוש המלות"
    title_answers_words = "לוח התשובות לפירוש המלות"
	title_questions_inyanim = "לוח השאלות לענינים"
	title_answers_inyanim = "לוח התשובות לענינים"
	colontitle_regex = "תלמוד עשר הספירות"
	colontitle_regex1 = "חלק"

	manual_typos[1]       = "ח ל ק   ש נ י"
	manual_typos_fixes[1] = "חלק שני"
}
