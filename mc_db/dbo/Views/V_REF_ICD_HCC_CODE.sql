CREATE VIEW [dbo].[V_REF_ICD_HCC_CODE]
AS
SELECT        H.icd9_code AS icd_code, Replace(H.icd9_code, '.', '') AS icd_no_dot, i9.ICD9_description AS ICD_description, '9' AS ICD_type, HH.hcc_code, H.hcc_id, HH.community_ra_score, H.cms_hcc_model_year
FROM            pics..REF_ICD9_HCC_HIST H INNER JOIN
                         pics..REF_HCC_HIST HH ON H.hcc_id = HH.hcc_id INNER JOIN
                        pics..REF_ICD9 i9 ON i9.icd9_code = H.icd9_code
WHERE        HH.cms_hcc_model_year = 2014
UNION
SELECT        H.icd10_code AS icd_code, Replace(H.icd10_code, '.', '') AS icd_no_dot, i10.icd10_description AS ICD_description, '0' AS ICD_type, H.hcc_code, H.hcc_id, HH.community_ra_score, H.cms_hcc_model_year
FROM            pics..REF_ICD10_HCC_HIST H INNER JOIN
                         pics..REF_ICD10 i10 ON i10.icd10_code = H.icd10_code INNER JOIN
                         pics..REF_HCC_HIST HH ON H.hcc_id = HH.hcc_id
WHERE        H.cms_hcc_model_year = 2015