# GradLens Schema Delete Rules

## Delete cascades

| Delete | Also deletes |
|---|---|
| User | Sessions, academic years, semesters, courses, scenarios, and dependent records |
| Academic year | Semesters and dependent records under that year |
| Semester | Courses, scenarios, and dependent records for that semester |
| Course | Assessments and dependent records for that course |
| Scenario | Scenario scores |

## Retake delete refusal

A course may be referenced by another course attempt through `retake_of_course_id`.

Deleting a course must be refused when another attempt points to that course as its retake target. The database uses `ON DELETE SET NULL` for `retake_of_course_id`, but the service must refuse the delete when an active retake link exists.

Retake links must also remain within the same user's courses.
