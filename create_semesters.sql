CREATE TABLE semesters (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  year_id UUID NOT NULL REFERENCES academic_years(id) ON DELETE CASCADE,
  season TEXT NOT NULL CHECK (season IN ('autumn', 'spring', 'summer')),
  position INTEGER NOT NULL,
  UNIQUE (year_id, position)
);
