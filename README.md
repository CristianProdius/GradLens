# GradLens

GradLens is a web app for one university student. They record courses, component weights, and marks on the 1.00 to 10.00 scale. The app shows the credit-weighted average, whether the course is passed, and the mark still needed on work that is not graded yet.

A student at FCIM already has those numbers on the course sheet and on returned work. A spreadsheet treats a blank exam as zero. ELSE (the faculty Moodle) shows what a professor entered. Neither one lets the student ask, in private, "if the exam is a 9, what happens to this course and to the semester?"

GradLens is that private copy. It is not the university's official record.

This is the year-2 internship project for Fundamentals of Application Development (Bazele dezvoltării aplicațiilor) at Technical University of Moldova, FCIM, Software Engineering. The app has to be working by the end of week 7.

## What a student can do

- Register and see only their own years, semesters, courses, and marks.
- Split a course into components (labs, a test, an exam) whose weights sum to 100.
- Start from a preset of 60% current work and 40% exam, then edit it to match the course sheet.
- Enter a mark, leave a component pending, or mark it absent.
- See the current mark from graded work only.
- Save a what-if scenario without changing the recorded mark.
- See the mark required on the remaining weight to hit a target.
- See semester and cumulative averages weighted by ECTS credits.
- Keep a passed attempt in the official average until a retake has its own final mark.

The interface is Romanian. Code, API error codes, and the docs stay in English.

## Rules that are easy to get wrong

These are closed. Do not reopen them in a pull request.

- Marks are 1.00 to 10.00. The pass line is 5.00.
- A pending exam is left out of the current mark. It is not stored or averaged as zero.
- A projection exists only when every component has either a recorded mark or a hypothetical mark.
- Hypothetical marks live in their own table. Saving a scenario must not update recorded scores.
- Weights must sum to 100.00 before a course is used in an official average.
- If the course says the exam must be passed, an exam under 5.00 fails the course even when the weighted mark is higher. The weighted number is still shown.
- Semester and cumulative averages are weighted by credits. Do not average the semester averages together.
- Credits for a retake count once.
- Averages are computed when they are read. Do not add a cached mark column.
- All mark math uses decimal arithmetic, rounded half-up to two decimals. Do not use JavaScript numbers for marks.
- The math lives in one shared package, imported by the API and the web app. Do not copy a formula into a React component.
- Every row is scoped to the logged-in user. Another user's id returns 404, and the body does not include their course title.
- The 60/40 preset is a starting point. It is not a rule that every subject at UTM uses that split.

Worked example, which the tests must match:

| Situation | Result |
| --- | --- |
| Labs 8.00 at 30%, test 7.00 at 30%, exam still open | Current mark 7.50 |
| Same course, target 8.00 | The exam must be 8.75 |
| Same course, hypothetical exam 9.00 | Projection 8.10, recorded mark still 7.50 |
| 5 credits at 8.00, 4 credits at 6.50, 6 credits in progress at 7.50 | Official semester average 7.33, in-progress average 7.40 |

## What this project is not

Do not build these unless the spec is changed first:

- A teacher gradebook, a class roster, or a parent view
- Sync with ELSE or Moodle
- A timetable, attendance, or notifications
- Email verification, password-reset email, or OAuth
- An Android or iOS app
- A second grading scale (4.0 or letters only)
- Dropping the lowest component

## Stack

| Piece | Choice |
| --- | --- |
| Web | React, TypeScript, Vite, React Router |
| API | Node.js, TypeScript, Express |
| Math | `packages/grade-math` with `decimal.js` |
| Database | PostgreSQL 16, Prisma |
| Auth | Email and password, bcrypt cost 12, server session, httpOnly cookie |
| Demo | `docker compose up` on the presentation machine |

The web app and the API are separate so the report can show a frontend, a backend, and a database. The browser talks to one origin. nginx proxies `/api`, so the session cookie stays first-party.

Target layout, once [GL-001](https://github.com/CristianProdius/GradLens/issues/8) and the following setup tasks are done:

```
apps/web/                 React UI
apps/api/                 Express API and Prisma
packages/grade-math/      Pure mark calculations and their tests
docs/GRADLENS_SPEC.md     Product and implementation spec
docker-compose.yml
```

None of that application code exists yet. The repository currently holds this README and the spec.

## Where to read

- [docs/GRADLENS_SPEC.md](docs/GRADLENS_SPEC.md) is the source of truth: decisions, formulas, SQL, API, screens, and tests.
- If a course sheet disagrees with the 60/40 preset or the ECTS letter bands, the student edits the course. The bands are seed data. Do not hard-code a second formula in the UI.

## Where to work

The build is 250 tasks, [GL-001](https://github.com/CristianProdius/GradLens/issues/8) through [GL-250](https://github.com/CristianProdius/GradLens/issues/257). Each issue has a done checklist. Do them in GL order inside a phase.

Seven week trackers group the tasks. Filter out `type:epic` when you want only the coding tasks.

| Week | Tracker | Done when |
| --- | --- | --- |
| 1 Foundation | [#1](https://github.com/CristianProdius/GradLens/issues/1) | Two users can register, and one cannot see the other's data. |
| 2 Domain records | [#2](https://github.com/CristianProdius/GradLens/issues/2) | A semester with three courses and credits. |
| 3 Assessments | [#3](https://github.com/CristianProdius/GradLens/issues/3) | Save is blocked at weight 90. A pending exam can be stored. |
| 4 Grade math | [#4](https://github.com/CristianProdius/GradLens/issues/4) | 7.50, 7.33, and 7.40 match a calculator. |
| 5 Scenarios and retakes | [#5](https://github.com/CristianProdius/GradLens/issues/5) | A hypothetical exam moves the projection. The recorded 7.50 stays. |
| 6 Polish | [#6](https://github.com/CristianProdius/GradLens/issues/6) | The demo account opens with the fixture loaded. |
| 7 Defense | [#7](https://github.com/CristianProdius/GradLens/issues/7) | The presentation script runs from a cold `docker compose up`. |

Labels: `phase:week-1` through `phase:week-7`, `type:feature`, `type:test`, `type:docs`, `type:chore`, `type:security`, plus `area:*` and `priority:p0` or `priority:p1`. A `priority:p0` issue is required for that week's demo.

Start at GL-001. There is no install or run command until that setup work lands. Week 7 writes the cold-start steps into this file.
