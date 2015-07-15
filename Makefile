HTM2PDF = ../../../utils/wkhtmltox-0.12.2.3_mingw-w64-cross-win64/bin/wkhtmltopdf
HTM2PDF_PARAMS = \
	--print-media-type \
	--page-width 46mm --page-height 92mm  \
	--margin-top 1mm --margin-bottom 1mm --margin-left 0.25mm --margin-right 0.25mm \
	--dpi 300 \
	--disable-smart-shrinking
	#--zoom 1.045 

TXT_DIR  = src-txt
HTM_DIR  = out-html
PDF_DIR  = out-pdf

TES01_SM_TXT   = $(TXT_DIR)/heb_o_bs-tes-01_luah-sheelot-le-pirush-milot.txt
TES01_SI_TXT   = $(TXT_DIR)/heb_o_bs-tes-01_luah-sheelot-le-inyanim.txt
TES01_TM_TXT   = $(TXT_DIR)/heb_o_bs-tes-01_luah-tshuvot-le-pirush-milot.txt
TES01_TI_TXT   = $(TXT_DIR)/heb_o_bs-tes-01_luah-tshuvot-le-inyanim.txt
TES01_TXT      = $(TXT_DIR)/tes01.txt
TES01_ST_TXT   = $(TXT_DIR)/tes01-shehelot-tshuvot.txt
TES01_ST_HTM   = $(HTM_DIR)/tes01-shehelot-tshuvot.html
TES01_ST_PDF   = $(PDF_DIR)/tes01-shehelot-tshuvot.pdf

TES16_OP_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_or-pnimi.txt
TES16_SM_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-sheelot-le-pirush-milot.txt
TES16_SI_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-sheelot-le-inyanim.txt
TES16_TM_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-tshuvot-le-pirush-milot.txt
TES16_TI_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-tshuvot-le-inyanim.txt
TES16_TXT      = $(TXT_DIR)/tes16.txt
TES16_ST_TXT   = $(TXT_DIR)/tes16-shehelot-tshuvot.txt
TES16_ST_HTM   = $(HTM_DIR)/tes16-shehelot-tshuvot.html
TES16_ST_PDF   = $(PDF_DIR)/tes16-shehelot-tshuvot.pdf

TES_ST_TXT = $(TES01_ST_TXT) $(TES16_ST_TXT)
TES_ST_HTM = $(TES01_ST_HTM) $(TES16_ST_HTM)
TES_ST_PDF = $(TES01_ST_PDF) $(TES16_ST_PDF)

$(TES01_ST_TXT): $(TES01_SM_TXT) $(TES01_SI_TXT) $(TES01_TM_TXT) $(TES01_TI_TXT)
	rm -f $(TES01_ST_TXT)
	cat $(TES01_SM_TXT) >> $(TES01_ST_TXT)
	cat $(TES01_SI_TXT) >> $(TES01_ST_TXT)
	cat $(TES01_TM_TXT) >> $(TES01_ST_TXT)
	cat $(TES01_TI_TXT) >> $(TES01_ST_TXT)

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

$(TES01_ST_HTM): $(TES01_ST_TXT)
	mkdir -p $(HTM_DIR)
	cat hypertes01st.awk hyperteslib.awk > tmp.awk
	awk -f tmp.awk $(TES01_ST_TXT) > $(TES01_ST_HTM)


$(TES16_ST_HTM): $(TES16_ST_TXT)
	mkdir -p $(HTM_DIR)
	cat hypertes16st.awk hyperteslib.awk > tmp.awk
	awk -f tmp.awk $(TES16_ST_TXT) > $(TES16_ST_HTM)

$(TES01_ST_PDF): $(TES01_ST_HTM)
	$(HTM2PDF) $(HTM2PDF_PARAMS) $(TES01_ST_HTM) $(TES01_ST_PDF)

$(TES16_ST_PDF): $(TES16_ST_HTM)
	$(HTM2PDF) $(HTM2PDF_PARAMS) $(TES16_ST_HTM) $(TES16_ST_PDF)

all: $(TES_ST_PDF)

clean-pdf:
	rm -f $(TES_ST_PDF)
clean:
	rm -f $(TES_ST_TXT) $(TES_ST_HTM) $(TES_ST_PDF)
