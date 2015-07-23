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

TES02_SM_TXT   = $(TXT_DIR)/heb_o_bs-tes-02_luah-sheelot-le-pirush-milot.txt
TES02_SI_TXT   = $(TXT_DIR)/heb_o_bs-tes-02_luah-sheelot-le-inyanim.txt
TES02_TM_TXT   = $(TXT_DIR)/heb_o_bs-tes-02_luah-tshuvot-le-pirush-milot.txt
TES02_TI_TXT   = $(TXT_DIR)/heb_o_bs-tes-02_luah-tshuvot-le-inyanim.txt
TES02_TXT      = $(TXT_DIR)/tes02.txt
TES02_ST_TXT   = $(TXT_DIR)/tes02-shehelot-tshuvot.txt
TES02_ST_HTM   = $(HTM_DIR)/tes02-shehelot-tshuvot.html
TES02_ST_PDF   = $(PDF_DIR)/tes02-shehelot-tshuvot.pdf

TES03_SM_TXT   = $(TXT_DIR)/heb_o_bs-tes-03_luah-sheelot-le-pirush-milot.txt
TES03_SI_TXT   = $(TXT_DIR)/heb_o_bs-tes-03_luah-sheelot-le-inyanim.txt
TES03_TM_TXT   = $(TXT_DIR)/heb_o_bs-tes-03_luah-tshuvot-le-pirush-milot.txt
TES03_TI_TXT   = $(TXT_DIR)/heb_o_bs-tes-03_luah-tshuvot-le-inyanim.txt
TES03_TXT      = $(TXT_DIR)/tes03.txt
TES03_ST_TXT   = $(TXT_DIR)/tes03-shehelot-tshuvot.txt
TES03_ST_HTM   = $(HTM_DIR)/tes03-shehelot-tshuvot.html
TES03_ST_PDF   = $(PDF_DIR)/tes03-shehelot-tshuvot.pdf

TES16_OP_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_or-pnimi.txt
TES16_SM_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-sheelot-le-pirush-milot.txt
TES16_SI_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-sheelot-le-inyanim.txt
TES16_TM_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-tshuvot-le-pirush-milot.txt
TES16_TI_TXT   = $(TXT_DIR)/heb_o_bs-tes-16_luah-tshuvot-le-inyanim.txt
TES16_TXT      = $(TXT_DIR)/tes16.txt
TES16_ST_TXT   = $(TXT_DIR)/tes16-shehelot-tshuvot.txt
TES16_ST_HTM   = $(HTM_DIR)/tes16-shehelot-tshuvot.html
TES16_ST_PDF   = $(PDF_DIR)/tes16-shehelot-tshuvot.pdf

TES_ST_TXT = $(TES01_ST_TXT) $(TES02_ST_TXT) $(TES03_ST_TXT) $(TES16_ST_TXT)
TES_ST_HTM = $(TES01_ST_HTM) $(TES02_ST_HTM) $(TES03_ST_HTM) $(TES16_ST_HTM)
TES_ST_PDF = $(TES01_ST_PDF) $(TES02_ST_PDF) $(TES03_ST_PDF) $(TES16_ST_PDF)

$(TES01_ST_TXT): $(TES01_SM_TXT) $(TES01_SI_TXT) $(TES01_TM_TXT) $(TES01_TI_TXT)
	rm -f $(TES01_ST_TXT)
	cat $(TES01_SM_TXT) >> $(TES01_ST_TXT)
	cat $(TES01_SI_TXT) >> $(TES01_ST_TXT)
	cat $(TES01_TM_TXT) >> $(TES01_ST_TXT)
	cat $(TES01_TI_TXT) >> $(TES01_ST_TXT)

$(TES02_ST_TXT): $(TES02_SM_TXT) $(TES02_SI_TXT) $(TES02_TM_TXT) $(TES02_TI_TXT)
	rm -f $(TES02_ST_TXT)
	cat $(TES02_SM_TXT) >> $(TES02_ST_TXT)
	cat $(TES02_SI_TXT) >> $(TES02_ST_TXT)
	cat $(TES02_TM_TXT) >> $(TES02_ST_TXT)
	cat $(TES02_TI_TXT) >> $(TES02_ST_TXT)

$(TES03_ST_TXT): $(TES03_SM_TXT) $(TES03_SI_TXT) $(TES03_TM_TXT) $(TES03_TI_TXT)
	rm -f $(TES03_ST_TXT)
	cat $(TES03_SM_TXT) >> $(TES03_ST_TXT)
	cat $(TES03_SI_TXT) >> $(TES03_ST_TXT)
	cat $(TES03_TM_TXT) >> $(TES03_ST_TXT)
	cat $(TES03_TI_TXT) >> $(TES03_ST_TXT)

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

$(TES02_ST_HTM): $(TES02_ST_TXT)
	mkdir -p $(HTM_DIR)
	cat hypertes02st.awk hyperteslib.awk > tmp.awk
	awk -f tmp.awk $(TES02_ST_TXT) > $(TES02_ST_HTM)

$(TES03_ST_HTM): $(TES03_ST_TXT)
	mkdir -p $(HTM_DIR)
	cat hypertes03st.awk hyperteslib.awk > tmp.awk
	awk -f tmp.awk $(TES03_ST_TXT) > $(TES03_ST_HTM)

$(TES16_ST_HTM): $(TES16_ST_TXT)
	mkdir -p $(HTM_DIR)
	cat hypertes16st.awk hyperteslib.awk > tmp.awk
	awk -f tmp.awk $(TES16_ST_TXT) > $(TES16_ST_HTM)

$(TES01_ST_PDF): $(TES01_ST_HTM)
	$(HTM2PDF) $(HTM2PDF_PARAMS) $(TES01_ST_HTM) $(TES01_ST_PDF)

$(TES02_ST_PDF): $(TES02_ST_HTM)
	$(HTM2PDF) $(HTM2PDF_PARAMS) $(TES02_ST_HTM) $(TES02_ST_PDF)

$(TES03_ST_PDF): $(TES03_ST_HTM)
	$(HTM2PDF) $(HTM2PDF_PARAMS) $(TES03_ST_HTM) $(TES03_ST_PDF)

$(TES16_ST_PDF): $(TES16_ST_HTM)
	$(HTM2PDF) $(HTM2PDF_PARAMS) $(TES16_ST_HTM) $(TES16_ST_PDF)

#all: $(TES_ST_PDF)
all: $(TES03_ST_PDF)

clean-pdf:
	rm -f $(TES_ST_PDF)
clean:
	rm -f $(TES_ST_TXT) $(TES_ST_HTM) $(TES_ST_PDF)
