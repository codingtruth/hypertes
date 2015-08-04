#!/bin/awk -f

function tes_init()
{
	tes_n = "02"
	title_book = "תלמוד עשר הספירות"
    title_helek = "חלק שני עגולים ויושר"
    title_questions_words = "לוח השאלות לפירוש המלות"
    title_answers_words = "לוח התשובות לפירוש המלות"
	title_questions_inyanim = "לוח השאלות לענינים"
	title_answers_inyanim = "לוח התשובות לענינים"
	colontitle_regex = "תלמוד עשר הספירות"
	colontitle_regex1 = "חלק"

	manual_typos[1]       = "ח ל ק   ש נ י"
	manual_typos_fixes[1] = "חלק שני"
	
	manual_typos[2]       = "בפ) כמה סבות קדמו למסך."
	manual_typos_fixes[2] = "פב) כמה סבות קדמו למסך."
	
	manual_typos[3]       = "זג) מהו ההבדל בין הארה ישרה"
	manual_typos_fixes[3] = "צג) מהו ההבדל בין הארה ישרה"
	
	manual_typos[4]       = "זד) במה העגולים מעולים מהיושר."
	manual_typos_fixes[4] = "צד) במה העגולים מעולים מהיושר."
	
	manual_typos[5]       = "עשר ספירות דעולם אדם קדמון מכונו\nת \n"
	manual_typos_fixes[5] = "עשר ספירות דעולם אדם קדמון מכונות \n"
	
}
