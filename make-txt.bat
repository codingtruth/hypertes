
@rem #CATDOC = ../../../utils/catdoc-0.94.2-win32/catdoc
@rem #SOFFICE = "/c/Program Files (x86)/OpenOffice 4/program/soffice"
@rem #SOFFICE = "/c/Program Files (x86)/LibreOffice 4/program/soffice"
@set SOFFICE=soffice
@rem #ICONV  = ../../../utils/win-iconv-master/win_iconv
@rem #DOC_DIR = /d/kv/github/codingtruth/hypertes/src-doc
@rem #DOC_DIR = "d:\kv\github\codingtruth\hypertes\src-doc"
@set DOC_DIR=src-doc
@rem #TXT_DIR = /d/kv/github/codingtruth/hypertes/src-txt
@rem #TXT_DIR = "d:\kv\github\codingtruth\hypertes\src-txt"
@set TXT_DIR=src-txt

@set TES16_OP_DOC=%DOC_DIR%\heb_o_bs-tes-16_or-pnimi.doc
@set TES16_SM_DOC=%DOC_DIR%\heb_o_bs-tes-16_luah-sheelot-le-pirush-milot.doc
@set TES16_SI_DOC=%DOC_DIR%\heb_o_bs-tes-16_luah-sheelot-le-inyanim.doc
@set TES16_TM_DOC=%DOC_DIR%\heb_o_bs-tes-16_luah-tshuvot-le-pirush-milot.doc
@set TES16_TI_DOC=%DOC_DIR%\heb_o_bs-tes-16_luah-tshuvot-le-inyanim.doc
@set TES16_ST_DOC=%TES16_SM_DOC% %TES16_SI_DOC% %TES16_TM_DOC% %TES16_TI_DOC%
@set TES16_DOC=%TES16_OP_DOC% %TES16_ST_DOC%

@rem set TES16_ST_ASCII   = $(TXT_DIR)/tes16-shehelot-tshuvot-ascii.txt
@rem set TES16_ST_UNICODE=%TXT_DIR%\tes16-shehelot-tshuvot-unicode.txt
@rem set TES16_SM_UNICODE=%DOC_DIR%\heb_o_bs-tes-16_luah-sheelot-le-pirush-milot.txt

soffice --headless --convert-to txt:"Text (encoded):UTF8,LF,,," --outdir %TXT_DIR% %TES16_DOC%
