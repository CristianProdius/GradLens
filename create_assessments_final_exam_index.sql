CREATE UNIQUE INDEX assessments_one_final_exam
  ON assessments (course_id)
  WHERE is_final_exam;
