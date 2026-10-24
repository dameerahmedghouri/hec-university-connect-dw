CREATE TABLE stg.stg_grade_scale (
    grade_code    VARCHAR(10),
    min_marks     INT,
    max_marks     INT,
    grade_points  DECIMAL(4,2),
    result_status VARCHAR(10)
);


CREATE TABLE stg.stg_fact_exam_result (
    result_id      VARCHAR(20),
    student_id     VARCHAR(30),
    course_code    VARCHAR(20),
    program_code   VARCHAR(20),
    faculty_id     VARCHAR(30),
    uni_code       VARCHAR(10),
    date_key       INT,
    semester_code  VARCHAR(20),
    grade_code     VARCHAR(10),
    midterm_marks  DECIMAL(5,1),
    final_marks    DECIMAL(5,1),
    total_marks    DECIMAL(5,1),
    grade_points   DECIMAL(4,1),
    pass_flag      SMALLINT,
	assigment_marks SMALLINT
);





SELECT COUNT(*) FROM stg.stg_grade_scale;        -- 11
SELECT COUNT(*) FROM stg.stg_fact_exam_result;   -- 9444