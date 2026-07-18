# Nöbetçi Eczane+

## Project

A mobile app that answers: *"Which pharmacy near me is open right now?"* In Türkiye, only designated "nöbetçi" (on-duty) pharmacies stay open at night, on Sundays, and on public holidays. This project builds an end-to-end product — mobile app, backend, hosting — to solve that problem for Istanbul, as an 8-week summer learning project focused on AI-assisted development with Claude Code.

Core capabilities (final scope defined in `docs/PRD.md`):
- Nearest on-duty pharmacies by location (list + map)
- Pharmacy detail with tap-to-call and directions
- Search by district
- Saved home district with optional evening notification
- Sensible offline behavior

## Tech Stack

| Layer | Technology |
|---|---|
| Mobile app | Flutter (latest stable) |
| Backend | Spring Boot 3 (Java 21) |
| Build tool | Maven |
| ORM | Spring Data JPA |
| API style | REST |
| Database | MySQL (local via Docker) |
| Data source | Public on-duty pharmacy data for Istanbul (TBD — see data-source research notes) |
| Version control | Git + GitHub (issues, project board, PRs) |
| CI/CD | GitHub Actions |
| Hosting | Railway or Fly.io (hobby tier) with managed MySQL |
| Notifications | Firebase Cloud Messaging |
| API testing | Postman or Bruno |

## Folder Structure

- `backend/` — Spring Boot service (data ingestion, storage, API)
- `mobile/` — Flutter app
- `docs/` — PRD, technical plan, architecture, roadmap, research notes

## Phases

0. **Foundations & Planning** (current) — repo, workflow, PRD, technical plan, data-source research
1. **Backend Core** — scheduled ingestion, normalization, MySQL storage, nearest/by-district REST API
2. **Mobile App Core** — nearby list, map, detail screen, district search
3. **Notifications & Preferences** — saved home district, evening notification
4. **CI/CD & Hosting** — automated build/test, cloud deploy, secrets management, real test users
5. **Polish & Portfolio** — tester feedback, README rewrite, lessons-learned note, demo video

Each phase ends with a deliverable merged to `main` via a reviewed pull request.

## Golden Rules

- Never merge code you cannot explain line by line.
- For the hardest parts, write your own attempt first, then compare with Claude Code's version.
- Use Claude Code to *review* code at least as often as to *write* it.

## Ground Rules

- Use only publicly published data; respect each source's terms; fetch politely (once a day is enough).
- Show an in-app disclaimer: data is informational — verify by phone in emergencies.
- Collect no personal data beyond what notifications strictly require; document this in a short privacy note.
