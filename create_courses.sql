CREATE TABLE courses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  semester_id UUID NOT NULL REFERENCES semesters(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  credits NUMERIC NOT NULL CHECK (credits > 0 AND credits <= 30),
  target NUMERIC(4,2) CHECK (target IS NULL OR (target >= 1.00 AND target <= 10.00)),
  exam_must_pass BOOLEAN NOT NULL DEFAULT TRUE
);
