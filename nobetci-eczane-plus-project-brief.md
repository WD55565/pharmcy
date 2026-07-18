# Nöbetçi Eczane+ — Summer Project Brief

**Audience:** Software engineering student (end of 2nd year), Aydın University, Istanbul
**Duration:** ~8 weeks (summer term)
**Goal:** Design, build, ship, and host a complete mobile application end-to-end while learning AI-assisted development with Claude Code, Git, and modern engineering practices.

> **How to read this brief:** It tells you *what* to achieve and *why* — not *how*. Discovering the "how" (with research, documentation, and Claude Code as your assistant) is the core of the exercise. If a phase feels underspecified, that is intentional.

---

## 1. The Problem

In Türkiye, only designated "nöbetçi" (on-duty) pharmacies stay open at night, on Sundays, and on public holidays — a different set every day, per district. People still find them through paper lists taped to pharmacy doors or hard-to-navigate municipality and chamber-of-pharmacists websites. In an urgent situation — a sick child at 2 AM — this is a real, unsolved pain point.

## 2. The Product

**Nöbetçi Eczane+** — a mobile app that instantly answers one question: *"Which pharmacy near me is open right now?"*

Core capabilities:

- Show the nearest on-duty pharmacies based on the user's location, as a list and on a map
- Pharmacy details with tap-to-call and one-tap directions
- Search by district for looking up other areas
- A saved home district with an optional evening notification announcing that district's on-duty pharmacy
- A sensible offline behavior — the app is needed most exactly when conditions are worst

You define the exact scope yourself in a short product requirements document (PRD) at the start. Deciding what *not* to build is part of the job.

## 3. Learning Objectives

By the end you should be able to:

1. Use **Claude Code** as a daily development partner — for planning, generating, reviewing, testing, and debugging code — while remaining the engineer who owns every decision.
2. Work with **Git and GitHub** professionally: branches, meaningful commits, pull requests, and issue/board-based task tracking.
3. Build and operate a **backend service** that ingests real-world public data on a schedule, stores it, and serves it through a clean API.
4. Build a **cross-platform mobile app** with location, maps, and push notifications.
5. Set up **CI/CD** and run your system on a real cloud host, reachable from anyone's phone.
6. Document and present a project so that a stranger (or interviewer) can understand and run it.

## 4. Tech Stack

| Layer | Technology |
|---|---|
| Mobile app | React Native + Expo (TypeScript) |
| Backend | Spring Boot 3 (Java 17+) |
| Database | PostgreSQL (run locally via Docker) |
| Data source | Publicly published on-duty pharmacy data for Istanbul — finding and evaluating sources is your first research task |
| Version control | Git + GitHub (issues, project board, pull requests) |
| CI/CD | GitHub Actions |
| Hosting | Railway or Fly.io (hobby tier) with managed PostgreSQL |
| Notifications | Expo Push Notifications |
| API testing | Postman or Bruno |
| AI assistant | Claude Code |

Everything beyond this table — libraries, patterns, project structure, deployment details — is yours to research, decide, and justify.

## 5. Claude Code Setup

Claude Code requires a paid Claude plan (Pro or above) or Anthropic API billing; the free plan does not include it.

1. Install using the native installer — follow the official setup guide: **https://code.claude.com/docs/en/setup**
2. Verify with `claude --version`, then run `claude` in a project folder and authenticate via the browser prompt. `claude doctor` diagnoses problems.
3. In your repository, run `/init` so Claude Code generates a `CLAUDE.md` — the project context file it loads every session. Keep it current as the project evolves.
4. Learn to work in this loop: **plan first** (use Plan Mode), implement in small steps, ask Claude Code to review your changes, commit often.

**Golden rules:**
- Never merge code you cannot explain line by line.
- For the hardest parts of this project, write your own attempt first, then compare with Claude Code's version — the comparison is where the learning happens.
- Use Claude Code to *review* your code at least as often as to *write* it.

## 6. Phases

Each phase ends with a **deliverable merged to `main` through a reviewed pull request**. Do not move on until the current deliverable is done.

### Phase 0 — Foundations & Planning (Week 1)
Set up the repository, workflow, and plan before writing any feature code. Establish a professional Git workflow (protected main, feature branches, PRs, an issue board). Write a short PRD. Research and evaluate the available public data sources for Istanbul's on-duty pharmacies and choose a primary and a fallback. Turn your PRD into a technical plan document that Claude Code can follow in later sessions.

**Deliverable:** Repository containing PRD, technical plan, `CLAUDE.md`, data-source research notes, and a populated task board.

### Phase 1 — Backend Core (Weeks 2–3)
Build a Spring Boot service that fetches the day's on-duty pharmacy data on a schedule, normalizes the messy real-world input, stores it in PostgreSQL, and exposes it through an API supporting "nearest to me" and "by district" queries. Expect and design for imperfect data. Include tests where bugs are most likely to live, and think about why you shouldn't hit the database or the source on every request.

**Deliverable:** A locally runnable API serving real, current on-duty data, with a passing test suite.

### Phase 2 — Mobile App Core (Weeks 4–5)
Build the Expo app: nearby pharmacy list, map view, detail screen with call and directions, district search. Handle location permissions respectfully, and treat loading, error, empty, and offline states as first-class features. Test on a real phone from day one.

**Deliverable:** A demo video: open app → see tonight's real on-duty pharmacies nearby → navigate to one.

### Phase 3 — Notifications & Preferences (Week 6)
Let users save a home district and receive an evening notification with that district's on-duty pharmacy. This requires both app-side and backend-side work — figure out what each side must own.

**Deliverable:** A real notification arriving on your phone every evening with correct data.

### Phase 4 — CI/CD & Hosting (Week 7)
Move from "works on my laptop" to "runs on the internet." Automate build and tests on every pull request, deploy the backend and database to a cloud platform, keep every secret out of Git, verify your scheduled jobs behave correctly in the cloud (mind timezones), and distribute the app to real test users.

**Deliverable:** Public API URL, the app installed on at least two other people's phones, and green CI on the repository.

### Phase 5 — Polish & Portfolio (Week 8)
Act on tester feedback. Rewrite the README so a stranger could understand and run the project: problem, screenshots, architecture diagram, setup, and the trade-offs behind your decisions. Write a short "lessons learned" note — including where Claude Code helped, where it misled you, and how you caught it. Record a short demo video.

**Deliverable:** A repository you would confidently link at the top of your CV.

## 7. Working Rhythm

- **Weekly:** plan the week from your board; end with a few journal notes on what shipped, what blocked you, what you learned.
- **Daily:** one focused session ≈ one feature branch ≈ one pull request, reviewed (with Claude Code's help) before merging.

## 8. Ground Rules

- Use only publicly published data; respect each source's terms and fetch politely (once a day is enough).
- Show an in-app disclaimer: the data is informational — verify by phone in emergencies.
- Collect no personal data beyond what notifications strictly require, and say so in a short privacy note.

---

*Finishing Phase 4 with quality beats rushing to Phase 5. When you are stuck, research first, ask Claude Code second, and always understand the answer before using it.*
