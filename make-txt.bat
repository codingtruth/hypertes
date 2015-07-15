
@set SOFFICE=soffice
@set DOC_DIR=src-doc
@set TXT_DIR=src-txt


@set TES01_OP_DOC=%DOC_DIR%\heb_o_bs-tes-01_or-pnimi.rtf
@set TES01_IP_DOC=%DOC_DIR%\heb_o_bs-tes-01_istaklut-pnimit.doc
@set TES01_SM_DOC=%DOC_DIR%\heb_o_bs-tes-01_luah-sheelot-le-pirush-milot.doc
@set TES01_SI_DOC=%DOC_DIR%\heb_o_bs-tes-01_luah-sheelot-le-inyanim.rtf
@set TES01_TM_DOC=%DOC_DIR%\heb_o_bs-tes-01_luah-tshuvot-le-pirush-milot.rtf
@set TES01_TI_DOC=%DOC_DIR%\heb_o_bs-tes-01_luah-tshuvot-le-inyanim.rtf
@set TES01_ST_DOC=%TES01_SM_DOC% %TES01_SI_DOC% %TES01_TM_DOC% %TES01_TI_DOC%
@set TES01_DOC=%TES01_OP_DOC% %TES01_IP_DOC% %TES01_ST_DOC%


@set TES16_OP_DOC=%DOC_DIR%\heb_o_bs-tes-16_or-pnimi.doc
@set TES16_SM_DOC=%DOC_DIR%\heb_o_bs-tes-16_luah-sheelot-le-pirush-milot.doc
@set TES16_SI_DOC=%DOC_DIR%\heb_o_bs-tes-16_luah-sheelot-le-inyanim.doc
@set TES16_TM_DOC=%DOC_DIR%\heb_o_bs-tes-16_luah-tshuvot-le-pirush-milot.doc
@set TES16_TI_DOC=%DOC_DIR%\heb_o_bs-tes-16_luah-tshuvot-le-inyanim.doc
@set TES16_ST_DOC=%TES16_SM_DOC% %TES16_SI_DOC% %TES16_TM_DOC% %TES16_TI_DOC%
@set TES16_DOC=%TES16_OP_DOC% %TES16_ST_DOC%


soffice --headless --convert-to txt:"Text (encoded):UTF8,LF,,," --outdir %TXT_DIR% %TES01_DOC%

soffice --headless --convert-to txt:"Text (encoded):UTF8,LF,,," --outdir %TXT_DIR% %TES16_DOC%
