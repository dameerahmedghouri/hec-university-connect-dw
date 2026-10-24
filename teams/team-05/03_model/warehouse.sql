    
CREATE TABLE dw.dim_grade (
    grade_code    VARCHAR(10) PRIMARY KEY,
    min_marks     INT,
    max_marks     INT,
    grade_points  DECIMAL(4,2) NOT NULL CHECK (grade_points BETWEEN 0 AND 4),
    result_status VARCHAR(10)  NOT NULL CHECK (result_status IN ('PASS','FAIL'))
);

INSERT INTO dw.dim_grade (grade_code, min_marks, max_marks, grade_points, result_status)
SELECT grade_code, min_marks, max_marks, grade_points, result_status
FROM stg.stg_grade_scale;

select * from dw.dim_grade






CREATE TABLE dw.fact_exam_result (
    result_id        VARCHAR(20) PRIMARY KEY,
    student_id       VARCHAR(30) NOT NULL,
    course_code      VARCHAR(20) NOT NULL,
    program_code     VARCHAR(20) NOT NULL,
    faculty_id       VARCHAR(30) NOT NULL,
    uni_code         VARCHAR(10) NOT NULL,
    date_key         INT         NOT NULL,
    semester_code    VARCHAR(20) NOT NULL,
    grade_code       VARCHAR(10) NOT NULL REFERENCES dw.dim_grade (grade_code),
    midterm_marks    DECIMAL(5,2) CHECK (midterm_marks    BETWEEN 0 AND 30),
    final_marks      DECIMAL(5,2) CHECK (final_marks      BETWEEN 0 AND 50),
    total_marks      DECIMAL(5,2) CHECK (total_marks      BETWEEN 0 AND 100),
    grade_points     DECIMAL(4,2) CHECK (grade_points     BETWEEN 0 AND 4),
    pass_flag        SMALLINT     CHECK (pass_flag IN (0,1)),
    assignment_marks DECIMAL(5,2) CHECK (assignment_marks BETWEEN 0 AND 20),
    CONSTRAINT uq_exam_grain UNIQUE (student_id, course_code, semester_code)
);
INSERT INTO dw.fact_exam_result
SELECT * FROM stg.stg_fact_exam_result;


-- SELECT 'dim_grade' AS tbl, COUNT(*) FROM dw.dim_grade               -- 11
-- UNION ALL
-- SELECT 'fact_exam_result', COUNT(*) FROM dw.fact_exam_result;      



SELECT 'T1 result_id unique' AS test, COUNT(*) - COUNT(DISTINCT result_id) AS bad_rows FROM dw.fact_exam_result
UNION ALL SELECT 'T2 grain unique', COUNT(*) FROM (
    SELECT 1 FROM dw.fact_exam_result GROUP BY student_id, course_code, semester_code HAVING COUNT(*) > 1) x
UNION ALL SELECT 'T3 grade_code orphan', COUNT(*) FROM dw.fact_exam_result f
    WHERE NOT EXISTS (SELECT 1 FROM dw.dim_grade d WHERE d.grade_code = f.grade_code)
UNION ALL SELECT 'T4 marks range', COUNT(*) FROM dw.fact_exam_result
    WHERE midterm_marks > 30 OR final_marks > 50 OR total_marks > 100
UNION ALL SELECT 'T5 student_id format', COUNT(*) FROM dw.fact_exam_result
    WHERE student_id !~ '^[A-Z]+-[0-9]{2}-[0-9]{5}$' OR split_part(student_id,'-',1) <> uni_code
UNION ALL SELECT 'T6 NULL keys', COUNT(*) FROM dw.fact_exam_result
    WHERE student_id IS NULL OR course_code IS NULL OR program_code IS NULL OR faculty_id IS NULL
       OR uni_code IS NULL OR date_key IS NULL OR semester_code IS NULL OR grade_code IS NULL;















