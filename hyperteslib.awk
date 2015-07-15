#!/bin/awk -f

# this file must be included by main script with tes_init() function defined

BEGIN {
	dbg_enabled = 0

	tes_init()
	
    numbered_block_start_regex = "^[א-ת]+\)"
	
	PART_QUESTIONS_WORDS = 1
	PART_QUESTIONS_INYANIM = 2
	PART_ANSWERS_WORDS = 3
	PART_ANSWERS_INYANIM = 4

	incomplete_sentence = ""

	question_words_first_idx = 0
	question_words_last_idx = 0

	question_inyanim_first_idx = 0
	question_inyanim_last_idx = 0

	M_SENTENCES[1] = ""
	n_cur = 0
	part = 0
    s_prev = ""


	html_start()

	gematria_init()
}

{
    $0 = manual_typos_fix($0)

	line = fetch_clean_line($0)
	if (line == "")
		next

	if (recognize_title(line)) {
		next
	}

	line = skip_colontitles(line)
	
	complete_sentence(line)

	for (z=1; z<=2; z++) {
		if (M_SENTENCES[z] != "")
			process_line(M_SENTENCES[z])
	}
}

END {
    content_print()
	html_end()
}

function process_line(s)
{
    #printf "<p>|%s|</p>", s


	if (part == PART_QUESTIONS_WORDS) {
		process_question(s)
	} else if (part == PART_QUESTIONS_INYANIM) {
		process_question(s)
	} else if (part == PART_ANSWERS_WORDS) {
		process_answer_words(s)
	} else if (part == PART_ANSWERS_INYANIM) {
		process_answer_inyanim(s)
	}
}

function skip_colontitles(s)
{
	if (match(s, colontitle_regex)) {
		dbg_content_colontitles_removed = dbg_content_colontitles_removed "<p>" s "</p>"
		return ""
	} else if (match(s, colontitle_regex1)) {
		dbg_content_colontitles_not_removed = dbg_content_colontitles_not_removed "<p>" s "</p>"
	}
	return s
}
function fetch_clean_line(s)
{
    gsub(/[[:cntrl:]\t]+/, "", s)
    gsub(/^[[:blank:][:cntrl:]]+/, "", s)
    gsub(/[[:blank:][:cntrl:]]+$/, "", s)
	return s
}
function is_title(s)
{
	if (s == title_questions_words) {
		return 1
	}
	else if (s == title_questions_inyanim) {
		return 1
	}
	else if (s == title_answers_words) {
		return 1
	}
	else if (s == title_answers_inyanim) {
		return 1
	}
	return 0
}
function recognize_title(s)
{
	if (s == title_questions_words) {
		part = PART_QUESTIONS_WORDS
		n_cur = 0
		return 1
	}
	else if (s == title_questions_inyanim) {
		part = PART_QUESTIONS_INYANIM
		n_cur = 0
		return 1
	}
	else if (s == title_answers_words) {
		part = PART_ANSWERS_WORDS
		n_cur = 0
		return 1
	}
	else if (s == title_answers_inyanim) {
		part = PART_ANSWERS_INYANIM
		n_cur = 0
		return 1
	}
	return 0
}
function complete_sentence(s,	ss,i)
{
	M_SENTENCES[1] = ""
	M_SENTENCES[2] = ""
	i = 1

	if (is_title(s) == 1) {
		if (incomplete_sentence != "")
			M_SENTENCES[i++] = incomplete_sentence
		M_SENTENCES[i++] = s
		incomplete_sentence = ""
		return
	} else if (recognize_numbered_block_start(s) != 0) {
		if (incomplete_sentence != "") {
			M_SENTENCES[i++] = incomplete_sentence
			incomplete_sentence = ""
		}
	}

	if (match(s, /[\'\.\)]$/) != 0) {
        if (incomplete_sentence != "") {
            ss = incomplete_sentence " " s
            incomplete_sentence = ""
        } else {
            ss = s
        }
		M_SENTENCES[i++] = ss
	} else {
        if (incomplete_sentence != "") {
            incomplete_sentence = incomplete_sentence " " s
        } else {
            incomplete_sentence = s
        }
		ss = ""
	}
}
function process_question(s,	n)
{
	n = recognize_numbered_block_start(s)
	#printf "<p>%s : %d</p>", s, n
	if (n != 0) {
		content_questions_txt[n] = s

		if (part == PART_QUESTIONS_INYANIM) {
			if (question_inyanim_first_idx == 0)
				question_inyanim_first_idx = n
			if (question_inyanim_last_idx < n)
				question_inyanim_last_idx = n
		} else 	if (part == PART_QUESTIONS_WORDS) {
			if (question_words_first_idx == 0)
				question_words_first_idx = n
			if (question_words_last_idx < n)
				question_words_last_idx = n
		}
	}
}
function process_answer_words(s,	n)
{
	n = recognize_numbered_block_start(s)
	if (n != 0)	{
    # new complete sentence is the numbered block start
		n_cur = n
        # use s_prev as the block title
		content_answers_html[n] = sprintf( "<p id=tes" tes_n "ts%03d class=\"d1\"><a href=#tes" tes_n  "sh%03d><b>%s</b></a></p>", n, n, s_prev )
		s = format_explicit_references(s)
		content_answers_html[n] = content_answers_html[n] sprintf( "<p>%s</p>", s )
		s_prev = ""
	} else {
    # new complete sentence is not start of a numbered block
        # add s_prev to the current block
        if (n_cur != 0){
            if (s_prev != "") {
                content_answers_html[n_cur] = content_answers_html[n_cur] sprintf( "<p>%s</p>", s_prev )
            }
        }
        # update s_prev
        s_prev = format_explicit_references(s)
    }
}
function process_answer_inyanim(s,	n)
{
	n = recognize_numbered_block_start(s)
	if (n != 0)	{
		n_cur = n
		content_answers_html[n] = content_answers_html[n] sprintf( "<p id=tes" tes_n "ts%03d class=\"d1\"><a href=#tes" tes_n "sh%03d><b>%s</b></a></p>", n, n, remove_index_number(content_questions_txt[n]) )
		s = format_explicit_references(s)
		content_answers_html[n] = content_answers_html[n] sprintf( "<p>%s</p>", s )
	} else if (n_cur != 0){
		content_answers_html[n_cur] = content_answers_html[n_cur] sprintf( "<p>%s</p>", s = format_explicit_references(s) )
	}
}
function recognize_numbered_block_start(s,	n)
{
    #printf "<p><i>%s</i></p>", s
    
    RSTART = 0
    RLENGTH = 0

 	if (match(s, numbered_block_start_regex) != 0) 
    {
		n =  gematria(substr(s, RSTART, RLENGTH))
		#printf ": <b>%s = %d</b>", substr(s, RSTART, RLENGTH), n
	} else {
		n = 0
		#printf ": <u>|%s|:%d</u>", s, n
	}
	return n
}
function remove_index_number(s)
{
	sub(numbered_block_start_regex, "", s)
	return s
}
function content_init()
{
    content_questions_txt[1] = ""
    content_answers_html[1] = ""
	#content_answers_title_txt[1] = ""
    content_answers_referenced_by_i[1] = ""
	
	dbg_content_colontitles_removed = ""
	dbg_content_colontitles_not_removed = ""
}

function content_print(     i,j,jj)
{
	if (dbg_enabled == 1) {
		print "<p id=dbgtitle><a style=\"font-family:Miriam;font-size:14pt;font-color=red\" href=#dbgdata>DEBUG-DATA</a></p>"
	}

	print "<p style=\"text-align:center;font-family:Miriam;font-size:7pt\">" strftime("%b %d %Y %H:%M:%S %Z",systime()) "<br>" "Automatically generated file with hyperlinks" "  Original files: " "<a style=\"font-family:Miriam;font-size:7pt;text-decoration:underline;\" href=http://www.kab.co.il/heb/content/view/full/42323>http://www.kab.co.il/ heb/content/view/full/42323</a>" "  Tool used: <a style=\"font-family:Miriam;font-size:7pt;text-decoration:underline;\" href=https://github.com/codingtruth/hypertes>https://github.com/codingtruth/hypertes</a><p>"
	print "<hr>"
	printf "<h1>%s</h1>", title_book
    printf "<h1>%s</h1>", title_helek
	print "<hr>"

    printf "<p id=tes" tes_n "shwl><a style=\"font-family:Miriam;font-size:11pt\" href=#tes" tes_n "shw>%s</a></p>", title_questions_words
    printf "<p id=tes" tes_n "shil><a style=\"font-family:Miriam;font-size:11pt\" href=#tes" tes_n "shi>%s</a></p>", title_questions_inyanim
    printf "<p id=tes" tes_n "tswl><a style=\"font-family:Miriam;font-size:11pt\" href=#tes" tes_n "tsw>%s</a></p>", title_answers_words
    printf "<p id=tes" tes_n "tsil><a style=\"font-family:Miriam;font-size:11pt\" href=#tes" tes_n "tsi>%s</a></p>", title_answers_inyanim

	print "<hr>"

    printf "<h2 id=tes" tes_n "shw><a href=\"#tes" tes_n "shwl\">%s</a></h2>", title_questions_words

	#printf "<p>%d-%d</p>", question_words_first_idx, question_words_last_idx
    for (i = question_words_first_idx; i <= question_words_last_idx; i++) {
        printf "<p id=tes" tes_n "sh%03d class=\"d1\"><a href=#tes" tes_n "ts%03d>%s</a></p>", i, i, content_questions_txt[i] 
    }

    printf "<h2 id=tes" tes_n "shi><a href=#tes" tes_n "shil>%s</a></h2>", title_questions_inyanim

    for (i = question_inyanim_first_idx; i <= question_inyanim_last_idx; i++) {
        printf "<p id=tes" tes_n "sh%03d class=\"d1\"><a href=#tes" tes_n "ts%03d>%s</a></p>", i, i, content_questions_txt[i] 
    }

    printf "<h2 id=tes" tes_n "tsw><a href=#tes" tes_n "tswl>%s</a></h2>", title_answers_words

    for (i = question_words_first_idx; i <= question_words_last_idx; i++) {
        print content_answers_html[i]
        split(content_answers_referenced_by_i[i], jj, " ")
        for (j = 1; j <= length(jj); j++) {
            printf "<p id=tes" tes_n "sh%03d class=\"rb\"><a href=#tes" tes_n "ts%03d>%s</a></p>", 0+(jj[j]), 0+(jj[j]), content_questions_txt[jj[j]] 
            
        }
    }
    
    printf "<h2 id=tes" tes_n "tsi><a href=#tes" tes_n "tsil>%s</a></h2>", title_answers_inyanim

    for (i = question_inyanim_first_idx; i <= question_inyanim_last_idx; i++) {
        print content_answers_html[i]
        split(content_answers_referenced_by_i[i], jj, " ")
        for (j = 1; j <= length(jj); j++) {
            printf "<p id=tes" tes_n "sh%03d class=\"rb\"><a href=#tes" tes_n "ts%03d>%s</a></p>", 0+(jj[j]), 0+(jj[j]), content_questions_txt[jj[j]] 
            
        }
    }

	if (dbg_enabled == 1) {
		print "<p id=dbgdata><a style=\"font-family:Miriam;font-size:14pt;font-color=red\" href=#dbgtitle>DEBUG-DATA</a></p>"
		
		print "<h2>COLONTITLES REMOVED</h2>"
		print dbg_content_colontitles_removed
		print "<h2>COLONTITLES NOT REMOVED</h2>"
		print dbg_content_colontitles_not_removed
	}

}

function html_start()
{
  	printf "<!DOCTYPE html><html dir=RTL style=\"width: 100%; height: 100%;\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"
    printf "<style>"
    printf "h1 {font-size:18pt;font-family:times;text-align:center;}"
    printf "h2 {font-size:14pt;font-family:times;text-align:center;page-break-inside:avoid;}"
    printf "h3 {font-size:12pt;font-family:times;text-align:right;margin-top:21pt;page-break-after:avoid;}"
    printf "p {font-family:times; font-size:12pt; margin-top:4pt; margin-bottom:4pt; text-align:justify;}"
    printf "p.d1 {margin-top:14pt;margin-top:6pt; margin-bottom:4pt;}"
    printf "p.rb {font-size:10pt; text-indent: 12pt; margin-top:4pt;margin-bottom:6pt;}"
    printf "a {color:black; text-decoration:none;}"
    printf "a.r {color:black; font-size:12pt; font-family:Miriam; text-decoration:none;}"
    printf "</style>"
    printf "</head><body style=\"margin: 0; padding: 0;\">"
}

function html_end()
{
	printf "</body></html>"
}

function format_explicit_references(sss,     s,i,pos,len,a,qn,sr,srepl_orig,srepl_new, arr, arr_s, arr_s_i,g)
{
    sss_in  = sss
    sss_out = ""
    
    xlss = sprintf("(%s|%s|%s|%s|%s|%s)(([ ,]+([%s]+\"[%s]+))|([ ,]+[%s]+\'))+",
		"בתשובה",
		"ותשובה",
		"בתשיובה",
		"ותשיובה",
		"תשובה",
		"תשיובה",
        "א-ת",
        "א-ת",
        "א-ת" )
    
    #printf "<p><u>%s</u></p>", xlss
    
		pos1 = 1
		while (pos1 != 0) {

		    pos1 = match(sss_in, xlss, arr)

            if (pos1 > 0) {

                #printf "<p><u>%s</u></p>", arr[0]
                
                #printf "<p>%s<b><u>%s</u></b></p>", substr(sss_in, 1, pos1), arr[0]

                sss_out = sss_out substr(sss_in, 1, pos1 - 1)

                split(arr[0], arr_s, " ")

                g = gematria(arr_s[2])
                sss_snew = sprintf("<a style=\"font-family:Miriam;font-size:11pt\" href=#tes" tes_n "ts%03d>%s %s</a>", 
                    g, arr_s[1], arr_s[2])

                content_add_explicit_reference(n_cur, g)
                
                for (arr_s_i = 3; arr_s_i <= length(arr_s); arr_s_i++) {
                    g = gematria(arr_s[arr_s_i])
                    if (g != 0) {
                        sss_snew = sss_snew sprintf("<a style=\"font-family:Miriam;font-size:11pt\" href=#tes" tes_n "ts%03d> %s</a>", 
                            g , arr_s[arr_s_i])
                        content_add_explicit_reference(n_cur, g)
                    } else {
                        sss_snew = sss_snew " " arr_s[arr_s_i]
                    }
                }
                
                sss_out = sss_out sss_snew
                sss_in = substr(sss_in, pos1 + RLENGTH, length(sss_in) - pos1 - RLENGTH + 1)
            } else {
                sss_out = sss_out sss_in
            }

		}

    return sss_out
}
function content_add_explicit_reference(from_i, to_i,   rr, rr_s, i)
{
    rr = content_answers_referenced_by_i[to_i]
    split(rr, rr_s, " ")
    for (i = 1; i <= length(rr_s); i++)
        if (rr_s[i] == i)
            return
    rr = rr " " from_i
    content_answers_referenced_by_i[to_i] = rr
}
function gematria_init()
{
	ABC ="אבגדהוזחטיכלמנסעפצקרשת"
}

function gematria(ss,   s,g,n,l,i,c)
{
    is_vav_first = 0
	s = ss
	gsub(/[^א-ת]/, "", s)
	g = 0
	l = length(s)
	n_prev = 1000
	o_next = 1000
    
	for (i = 1; i <= l; i+=2) {
		c = substr(s, i, 2)
		n = (index(ABC, c) + 1) / 2
		if (n >= 10 && n <= 19) {
			n = (n - 9) * 10
		} else if (n >= 20) {
			n = (n - 18) * 100
		}
		if (n > 0) {

			g += n

            if (n == 6 && g == 6)
                is_vav_first = 1
			else if (n >= o_next && !((n == 6 || n == 7) && ((g - n) % 100 == 9)))
                return 0

			if (n >= 100)
				o_next = 100
			else if (n >= 10)
				o_next = 10
			else if (g != 6)
				o_next = 0
		}
	}
    if (is_vav_first == 1 && g > 6)
        g -= 6
	return g
}
function manual_typos_fix(s,    i)
{
    for (i in manual_typos) {
        sub(manual_typos[i], manual_typos_fixes[i], s)
    }
    return s
}
