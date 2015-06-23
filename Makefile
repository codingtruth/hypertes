HTML2PDF = ../../../utils/wkhtmltox-0.12.2.3_mingw-w64-cross-win64/bin/wkhtmltopdf
#HTML2PDF = ../../../utils/wkhtmltopdf_0_12_2_3_mingw64/bin/wkhtmltopdf
#HTML2PDF = ../../../utils/wkhtmltox-0.12.2.3_msvc2013-win64/bin/wkhtmltopdf
#HTML2PDF = ../../../utils/wkhtmltox-0.12.2.1_mingw-w64-cross-win32/bin/wkhtmltopdf

#CATDOC = ../../../utils/catdoc-0.94.2-win32/catdoc
#SOFFICE = "/c/Program Files (x86)/OpenOffice 4/program/soffice"
#SOFFICE = "/c/Program Files (x86)/LibreOffice 4/program/soffice"
#SOFFICE = soffice
#ICONV  = ../../../utils/win-iconv-master/win_iconv
#DOC_DIR = /d/kv/github/codingtruth/hypertes/src-doc
#DOC_DIR = "d:\kv\github\codingtruth\hypertes\src-doc"
#DOC_DIR = src-doc
#TXT_DIR = /d/kv/github/codingtruth/hypertes/src-txt
#TXT_DIR = "d:\kv\github\codingtruth\hypertes\src-txt"
TXT_DIR  = src-txt
HTML_DIR = out-html
PDF_DIR  = out-pdf

TES16_OP_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_or-pnimi.txt
TES16_SM_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-sheelot-le-pirush-milot.txt
TES16_SI_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-sheelot-le-inyanim.txt
TES16_TM_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-tshuvot-le-pirush-milot.txt
TES16_TI_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-tshuvot-le-inyanim.txt
#TES16_ST_DOC     = $(TES16_SM_DOC) $(TES16_SI_DOC) $(TES16_TM_DOC) $(TES16_TI_DOC)
#TES16_ST_ASCII   = $(TXT_DIR)/tes16-shehelot-tshuvot-ascii.txt
TES16_TXT     = $(TXT_DIR)/tes16.txt
TES16_ST_TXT  = $(TXT_DIR)/tes16-shehelot-tshuvot.txt
TES16_ST_HTML = $(HTML_DIR)/tes16-shehelot-tshuvot.html
TES16_ST_HTML_WEB = http://localhost:8000/tes16-shehelot-tshuvot.html
TES16_ST_PDF  = $(PDF_DIR)/tes16-shehelot-tshuvot.pdf
#TES16_SM_UNICODE = $(DOC_DIR)\heb_o_bs-tes-16_luah-sheelot-le-pirush-milot.txt

$(TES16_ST_TXT): $(TES16_SM_TXT) $(TES16_SI_TXT) $(TES16_TM_TXT) $(TES16_TI_TXT)
	rm -f $(TES16_ST_TXT)
	cat $(TES16_SM_TXT) >> $(TES16_ST_TXT)
	cat $(TES16_SI_TXT) >> $(TES16_ST_TXT)
	cat $(TES16_TM_TXT) >> $(TES16_ST_TXT)
	cat $(TES16_TI_TXT) >> $(TES16_ST_TXT)

$(TES16_TXT): $(TES16_OP_TXT) $(TES16_ST_TXT)
	rm -f $(TES16_TXT)
	cat $(TES16_OP_TXT) >> $(TES16_TXT)
	cat $(TES16_ST_TXT) >> $(TES16_TXT)

$(TES16_ST_HTML): $(TES16_ST_TXT)
	mkdir -p $(HTML_DIR)
	awk -f hypertes16.awk $(TES16_ST_TXT) > $(TES16_ST_HTML)

$(TES16_ST_PDF): $(TES16_ST_HTML)
	$(HTML2PDF) \
	--print-media-type \
	--page-width 46mm --page-height 92mm  \
	--margin-top 1mm --margin-bottom 1mm --margin-left 0.25mm --margin-right 0.25mm \
	--dpi 300 \
	--disable-smart-shrinking \
	$(TES16_ST_HTML) $(TES16_ST_PDF)
	#--zoom 1.045 \


all: $(TES16_TXT) $(TES16_ST_PDF)

clean-pdf:
	rm -f $(TES16_ST_PDF)
clean:
	rm -f $(TES16_ST_TXT) $(TES16_ST_HTML)
