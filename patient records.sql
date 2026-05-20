CREATE TABLE patients(
patient_id VARCHAR PRIMARY KEY, 
age INT,
sex VARCHAR ,
bmi NUMERIC ,
systolic_bp INT,
diastolic_bp INT,
heart_rate INT,
temperature_f NUMERIC , 
smoking_status VARCHAR ,
alcohol_use VARCHAR ,
exercise_level VARCHAR ,
insurance_type VARCHAR ,
charlson_index INT,
dx_hypertension BOOLEAN,
dx_type2_diabetes BOOLEAN,
dx_hyperlipidemia BOOLEAN,
dx_obesity BOOLEAN,
dx_coronary_artery_disease BOOLEAN,
dx_heart_failure BOOLEAN,
dx_atrial_fibrillation BOOLEAN,
dx_chronic_kidney_disease BOOLEAN,
dx_copd BOOLEAN,
dx_asthma BOOLEAN,
dx_depression BOOLEAN,
dx_anxiety BOOLEAN,
dx_hypothyroidism BOOLEAN,
dx_osteoarthritis BOOLEAN,
dx_type1_diabetes BOOLEAN
)

SELECT * FROM patients

CREATE TABLE Diagnoses(
patient_id VARCHAR REFERENCES patients(patient_id),
visit_date  DATE,
visit_type VARCHAR (50),
Primary_diagnosis VARCHAR (50),
primary_icd10 VARCHAR(20),
secondary_diagnoses VARCHAR (50),
secondary_icd10s VARCHAR(20),
provider_specialty VARCHAR(50)
)

SELECT * FROM diagnoses

ALTER TABLE diagnoses
RENAME Primary_diagnosis  TO Primary_diagnoses;

CREATE TABLE medications(
patient_id VARCHAR REFERENCES patients(patient_id),
medication VARCHAR(50),
dose NUMERIC,
unit VARCHAR(50),
frequency VARCHAR,
indication VARCHAR (50),
start_date DATE,
duration_days INT,
is_generic BOOLEAN,
adherence_pct NUMERIC
)

SELECT * FROM medications

CREATE TABLE outcomes(
patient_id VARCHAR REFERENCES patients(patient_id),
admission_date DATE, 
discharge_date DATE,
length_of_stay_days INT,
icu_admission BOOLEAN,
icu_days INT, 
in_hospital_death BOOLEAN,
discharge_disposition VARCHAR ,
readmitted_30d BOOLEAN,
days_to_readmission NUMERIC,
primary_drg INT,
total_charges_usd NUMERIC 
)

SELECT * FROM outcomes

CREATE TABLE lab_results(
patient_id VARCHAR REFERENCES patients(patient_id),
test_date DATE,
test_name VARCHAR,
value NUMERIC, 
unit VARCHAR,
reference_low NUMERIC,
reference_high NUMERIC, 
flags VARCHAR,
is_abnormal BOOLEAN,
delta_from_normal NUMERIC
)

Select * from lab_results

-- Total users
CREATE VIEW total_users AS

SELECT COUNT(*) AS total_users
FROM patients

SELECT * FROM total_users;

--how many female and male 
SELECT sex, COUNT(*) AS Total_gender
FROM patients
GROUP BY sex;

-- Check min/max/avg for all key numeric columns
SELECT
    MIN(age)                     AS min_age,
    MAX(age)                     AS max_age,
    ROUND(AVG(age), 1)           AS avg_age,
    MIN(bmi)                     AS min_bmi,
    MAX(bmi)                     AS max_bmi,
    ROUND(AVG(bmi), 2)           AS avg_bmi,
    MIN(heart_rate)         AS min_heart_rate,
    MAX(heart_rate)         AS max_heart_rate,
    ROUND(AVG(heart_rate), 1) AS avg_heart_rate,
	MIN(systolic_bp)         AS min_systolic_bp,
    MAX(systolic_bp)         AS max_systolic_bp,
	ROUND(AVG(systolic_bp)) AS avg_systolic_bp,
	MIN(diastolic_bp)         AS min_diastolic_bp,
    MAX(diastolic_bp)         AS max_diastolic_bp,
	ROUND(AVG(diastolic_bp)) AS avg_diastolic_bp,
    MIN(temperature_f)             AS min_temperature_f,
    MAX(temperature_f)             AS max_temperature_f	
FROM patients

----LIST THE DIAGNOSES IN THE TABLE
--SELECT primary_diagnoses, secondary_diagnoses,COUNT(*) AS total_cases
--FROM diagnoses
--GROUP BY primary_diagnoses, secondary_diagnoses
---ORDER BY total_cases DESC;

CREATE VIEW total_diagnoses AS
SELECT 
    primary_diagnoses,
    COUNT(*) AS total_diagnoses
FROM diagnoses
GROUP BY primary_diagnoses
ORDER BY total_diagnoses DESC;

----check for null values in patients
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE patient_id IS NULL) AS missing_patient_id,
    COUNT(*) FILTER (WHERE age IS NULL) AS missing_age,
    COUNT(*) FILTER (WHERE sex IS NULL) AS missing_sex,
    COUNT(*) FILTER (WHERE bmi IS NULL) AS missing_bmi,
    COUNT(*) FILTER (WHERE systolic_bp IS NULL) AS missing_systolic_bp,
    COUNT(*) FILTER (WHERE diastolic_bp IS NULL) AS missing_diastolic_bp,
    COUNT(*) FILTER (WHERE heart_rate IS NULL) AS missing_heart_rate,
    COUNT(*) FILTER (WHERE temperature_f IS NULL) AS missing_temperature,
    COUNT(*) FILTER (WHERE smoking_status IS NULL) AS missing_smoking_status,
    COUNT(*) FILTER (WHERE alcohol_use IS NULL) AS missing_alcohol_use,
    COUNT(*) FILTER (WHERE exercise_level IS NULL) AS missing_exercise_level,
    COUNT(*) FILTER (WHERE insurance_type IS NULL) AS missing_insurance_type,
    COUNT(*) FILTER (WHERE charlson_index IS NULL) AS missing_charlson_index,
    COUNT(*) FILTER (WHERE dx_hypertension IS NULL) AS missing_dx_hypertension,
    COUNT(*) FILTER (WHERE dx_type2_diabetes IS NULL) AS missing_dx_type2_diabetes,
    COUNT(*) FILTER (WHERE dx_hyperlipidemia IS NULL) AS missing_dx_hyperlipidemia,
    COUNT(*) FILTER (WHERE dx_obesity IS NULL) AS missing_dx_obesity,
    COUNT(*) FILTER (WHERE dx_coronary_artery_disease IS NULL) AS missing_dx_cad,
    COUNT(*) FILTER (WHERE dx_heart_failure IS NULL) AS missing_dx_heart_failure,
    COUNT(*) FILTER (WHERE dx_atrial_fibrillation IS NULL) AS missing_dx_afib,
    COUNT(*) FILTER (WHERE dx_chronic_kidney_disease IS NULL) AS missing_dx_ckd,
    COUNT(*) FILTER (WHERE dx_copd IS NULL) AS missing_dx_copd,
    COUNT(*) FILTER (WHERE dx_asthma IS NULL) AS missing_dx_asthma,
    COUNT(*) FILTER (WHERE dx_depression IS NULL) AS missing_dx_depression,
    COUNT(*) FILTER (WHERE dx_anxiety IS NULL) AS missing_dx_anxiety,
    COUNT(*) FILTER (WHERE dx_hypothyroidism IS NULL) AS missing_dx_hypothyroidism,
    COUNT(*) FILTER (WHERE dx_osteoarthritis IS NULL) AS missing_dx_osteoarthritis,
    COUNT(*) FILTER (WHERE dx_type1_diabetes IS NULL) AS missing_dx_type1_diabetes
FROM patients;

----check for null values in diagnoses
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE patient_id IS NULL) AS missing_patient_id,
    COUNT(*) FILTER (WHERE visit_date IS NULL) AS missing_visit_date,
    COUNT(*) FILTER (WHERE visit_type IS NULL) AS missing_visit_type,
    COUNT(*) FILTER (WHERE Primary_diagnoses IS NULL) AS missing_primary_diagnosis,
    COUNT(*) FILTER (WHERE primary_icd10 IS NULL) AS missing_primary_icd10,
    COUNT(*) FILTER (WHERE secondary_diagnoses IS NULL) AS missing_secondary_diagnoses,
    COUNT(*) FILTER (WHERE secondary_icd10s IS NULL) AS missing_secondary_icd10s,
    COUNT(*) FILTER (WHERE provider_specialty IS NULL) AS missing_provider_specialty
FROM diagnoses;

----Check for null values medications
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE patient_id IS NULL) AS missing_patient_id,
    COUNT(*) FILTER (WHERE medication IS NULL) AS missing_medication,
    COUNT(*) FILTER (WHERE dose IS NULL) AS missing_dose,
    COUNT(*) FILTER (WHERE unit IS NULL) AS missing_unit,
    COUNT(*) FILTER (WHERE frequency IS NULL) AS missing_frequency,
    COUNT(*) FILTER (WHERE indication IS NULL) AS missing_indication,
    COUNT(*) FILTER (WHERE start_date IS NULL) AS missing_start_date,
    COUNT(*) FILTER (WHERE duration_days IS NULL) AS missing_duration_days,
    COUNT(*) FILTER (WHERE is_generic IS NULL) AS missing_is_generic,
    COUNT(*) FILTER (WHERE adherence_pct IS NULL) AS missing_adherence_pct
FROM medications;

----check for miss values in outcomes
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE patient_id IS NULL) AS missing_patient_id,
    COUNT(*) FILTER (WHERE admission_date IS NULL) AS missing_admission_date,
    COUNT(*) FILTER (WHERE discharge_date IS NULL) AS missing_discharge_date,
    COUNT(*) FILTER (WHERE length_of_stay_days IS NULL) AS missing_length_of_stay_days,
    COUNT(*) FILTER (WHERE icu_admission IS NULL) AS missing_icu_admission,
    COUNT(*) FILTER (WHERE icu_days IS NULL) AS missing_icu_days,
    COUNT(*) FILTER (WHERE in_hospital_death IS NULL) AS missing_in_hospital_death,
    COUNT(*) FILTER (WHERE discharge_disposition IS NULL) AS missing_discharge_disposition,
    COUNT(*) FILTER (WHERE readmitted_30d IS NULL) AS missing_readmitted_30d,
    COUNT(*) FILTER (WHERE days_to_readmission IS NULL) AS missing_days_to_readmission,
    COUNT(*) FILTER (WHERE primary_drg IS NULL) AS missing_primary_drg,
    COUNT(*) FILTER (WHERE total_charges_usd IS NULL) AS missing_total_charges_usd
FROM outcomes;

---check null values lab_results
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE patient_id IS NULL) AS missing_patient_id,
    COUNT(*) FILTER (WHERE test_date IS NULL) AS missing_test_date,
    COUNT(*) FILTER (WHERE test_name IS NULL) AS missing_test_name,
    COUNT(*) FILTER (WHERE value IS NULL) AS missing_value,
    COUNT(*) FILTER (WHERE unit IS NULL) AS missing_unit,
    COUNT(*) FILTER (WHERE reference_low IS NULL) AS missing_reference_low,
    COUNT(*) FILTER (WHERE reference_high IS NULL) AS missing_reference_high,
    COUNT(*) FILTER (WHERE flags IS NULL) AS missing_flags,
    COUNT(*) FILTER (WHERE is_abnormal IS NULL) AS missing_is_abnormal,
    COUNT(*) FILTER (WHERE delta_from_normal IS NULL) AS missing_delta_from_normal
FROM lab_results;

--check for duplicate user in patients table
SELECT patient_id,
COUNT(*) AS duplicate_Id FROM patients
GROUP BY patient_id
HAVING COUNT(*) > 1;


--- replace missing null for secondary diagnoses and seconday_icd10

UPDATE diagnoses
SET secondary_diagnoses = 'None'
WHERE secondary_diagnoses IS NULL;

UPDATE diagnoses
SET secondary_icd10s = 'None'
WHERE secondary_icd10s IS NULL;

-----REPLACE THE MISSING VALUES OF days_of_readmission

---SELECT ROUND(AVG(days_to_readmission), 1) AS avg_days_to_readmission
---FROM outcomes
---WHERE days_to_readmission IS NOT NULL;  --- Might affect my analysis

UPDATE outcomes
SET days_to_readmission = 0
WHERE days_to_readmission IS NULL;

SELECT days_to_readmission FROM outcomes


























































