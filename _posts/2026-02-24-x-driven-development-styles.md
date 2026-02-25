---
title: "X-Driven Development Styles: A Reference Guide"
layout: post
date: 2026-02-24
author: kirby
tags: [methodology, reference, software-development]
---

# “Driven Development” styles

A collected list of "Driven Development" styles documented in software development literature and blogs.

## Methodology and limits

To keep this list objective, each style is included only when at least one of the following is true:

- It appears in a canonical source (foundational book, standards/governance body, or well-established engineering reference).
- It is a clearly named and repeated practitioner pattern with recognizable workflow impact.
- It is a satirical/anti-pattern label that teams use as a warning signal (explicitly marked as such).

Evidence labels in this post:

- **High**: canonical/foundational source(s) exist.
- **Medium**: credible practitioner sources and repeated industry use.
- **Low**: niche term, mostly informal usage, or mostly satirical usage.

Practicality score (0-100) is directional and based on five equal factors:

- Learning curve/cognitive overhead
- Tooling and ecosystem support
- Measurable ROI potential
- Team-size fit
- Domain-fit breadth

Popularity note: unlike languages/frameworks, there is no single authoritative adoption dataset for most "X-driven" labels. Popularity here is relative, using available proxies.

Category assignment rules in this post:

- **Widely accepted, production-grade**: generally proactive practices with broad applicability and practical score typically in the upper range.
- **Common but contextual or niche**: useful approaches with narrower fit, higher tradeoffs, or weaker/less-unified evidence.
- **Mostly tongue-in-cheek / soft practices**: anti-pattern labels or mostly satirical terms used as cautionary language.

Score interpretation:

- **80-100**: strong default candidate in many teams.
- **60-79**: useful in the right context; validate fit before standardizing.
- **0-59**: usually situational or cautionary, not a general default.

## Core "Driven Development" styles

- **Test-Driven Development (TDD)** – Write failing tests first, then write just enough code to make them pass, refactor, and repeat. [en.wikipedia](https://en.wikipedia.org/wiki/Test-driven_development)
- **Behavior-Driven Development (BDD)** – Extension of TDD that focuses tests and conversations around observable behaviors and ubiquitous language (Given–When–Then, etc.). [timspark](https://timspark.com/blog/software-development-methods-overview/)
- **Feature-Driven Development (FDD)** – Model the domain, build a feature list, then plan and build by small, client-valued features. [slideshare](https://www.slideshare.net/slideshow/x-drivendevelopment-methodologies/81153656)
- **Domain-Driven Design / Development (DDD)** – Model the software around the core domain and ubiquitous language, with entities, value objects, aggregates, bounded contexts. [en.wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)
- **Data-Driven Development (DDD)** – Use real-world data and metrics to drive design decisions and product evolution. [mstone](https://mstone.ai/glossary/data-driven-development/)
- **Event-Driven Development (EDD)** – Structure systems around events and reactions, often with asynchronous messaging and event buses. [timspark](https://timspark.com/blog/software-development-methods-overview/)

## Other documented "X-Driven" approaches

From lists of software development philosophies and xDD overviews: [en.wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)

- **Acceptance Test-Driven Development (ATDD)** – Drive implementation from executable acceptance tests defined with stakeholders. [en.wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)
- **Continuous Test-Driven Development (CTDD)** – Emphasis on uninterrupted TDD cycles during development. [en.wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)
- **Specification by Example / Spec-Driven Development (SDD)** – Use concrete examples/specs as a single source of truth to drive implementation and tests. [ministryoftesting](https://www.ministryoftesting.com/software-testing-glossary/spec-driven-development-sdd)
- **Design-Driven Development (D3)** – Focus on design and modeling activities as primary drivers of implementation. [en.wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)
- **User-Driven Development (UDD) / User-Centered Design (UCD)** – Engage users continuously so their feedback and usage drive design and implementation choices. [timspark](https://timspark.com/blog/software-development-methods-overview/)
- **Value-Driven Development / Design (VDD)** – Optimize for delivered business value; backlog and architecture decisions are driven by value considerations. [en.wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)
- **Configuration-Driven Development (CDD)** – Make behavior driven largely by configuration and metadata rather than hard-coded logic. [en.wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)
- **Readme-Driven Development (RDD)** – Write the README/spec first to define API and behavior, then implement to satisfy that contract. [en.wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)
- **Bug-Driven Development (BgDD)** – Humorous/critical term where work is driven mainly by bug reports instead of planned design. [en.wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)
- **Active-Admin-Driven Development (AADD)** – Coined tongue-in-cheek for back-office CRUD admin frameworks that shape the domain model around admin tooling. [en.wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)

## Smaller or niche "Driven Development" terms

Various blogs, talks, and glossaries mention additional xDD labels, often semi-jokingly or as local practices:

- **Example-Driven Development** – Close to spec-by-example/BDD, using examples as primary requirement artifacts. [ministryoftesting](https://www.ministryoftesting.com/software-testing-glossary/spec-driven-development-sdd)
- **User Story-Driven Development** – Agile practice where implementation strictly follows user stories as the main driver (often folded into BDD/ATDD). [timspark](https://timspark.com/blog/software-development-methods-overview/)

## Quick reference table

| Name                               | Typical acronym            | First codified (approx.) | Main driver/focus                    | Evidence | Score confidence | Practicality (0-100) |
|------------------------------------|----------------------------|--------------------------|--------------------------------------|----------|------------------|----------------------|
| Test-Driven Development            | TDD                        | 2000-2002                | Automated tests first                | High     | High             | 86                   |
| Behavior-Driven Development        | BDD                        | 2003-2006                | Observable behavior and examples     | High     | High             | 82                   |
| Feature-Driven Development         | FDD                        | 1997-1999                | Small, client-valued features        | Medium   | Medium           | 60                   |
| Domain-Driven Design/Development   | DDD                        | 2003                     | Domain model and ubiquitous language | High     | High             | 78                   |
| Data-Driven Development            | DDD (acronym collision)    | 2007-2009                | Real-world data and metrics          | Medium   | Medium           | 76                   |
| Event-Driven Development           | EDD                        | ~2002                    | Events and asynchronous messaging    | Medium   | Medium           | 70                   |
| Acceptance Test-Driven Development | ATDD                       | 2003-2004                | Acceptance criteria and tests        | High     | High             | 74                   |
| Continuous Test-Driven Development | CTDD                       | ~2013                    | Continuous TDD practice              | Medium   | Medium           | 66                   |
| Spec/Specification-Driven Dev      | SDD                        | 2004+                    | Detailed specs and examples          | Medium   | Medium           | 74                   |
| Design-Driven Development          | D3                         | 2005-2008                | Up-front and ongoing design          | Low      | Low              | 55                   |
| User-Driven Development            | UDD                        | 2000s                    | User feedback and involvement        | Medium   | Medium           | 68                   |
| Value-Driven Development           | VDD                        | 2000s                    | Business value and outcomes          | Medium   | Medium           | 67                   |
| Configuration-Driven Development   | CDD                        | 2017-2021                | Config and metadata                  | Medium   | Medium           | 62                   |
| Readme-Driven Development          | RDD                        | 2010                     | README/spec as contract              | Medium   | Medium           | 72                   |
| Bug-Driven Development             | BgDD                       | 2000s (documented)       | Work dominated by bug reports        | Low      | High             | 25                   |
| Active-Admin-Driven Development    | AADD                       | 2010s                    | Admin tooling constraints            | Low      | Low              | 40                   |

Satirical/anti-pattern entries in this table are included as cautionary labels, not as recommended primary methods.

Here’s a concise map of the "Driven Development" styles by **seriousness** and **where they sit in the delivery flow**.

## 1. Widely accepted, production-grade

**Requirements / discovery**

- **DDD – Domain-Driven Design/Development**: Shapes models, language, and boundaries early and continuously around the core domain.  
- **User-/Value-Driven Development (UDD/VDD)**: Backlog and scope are steered by user needs and business value, revisited throughout the lifecycle.

**Specification / testing**

- **TDD – Test-Driven Development**: Micro-level cycle (red–green–refactor) guiding design and implementation.  
- **BDD – Behavior-Driven Development**: Collaborative, behavior-focused specs (Given–When–Then) that drive both tests and conversations.  
- **ATDD / Spec-Driven / Spec-by-Example (ATDD/SDD)**: Acceptance tests and concrete examples agreed with stakeholders drive what gets built.

**Architecture / runtime**

- **Event-Driven Development (EDD)**: System boundaries and interactions modeled as events and reactions.  
- **Data-Driven Development (data DDD)**: Product and design decisions iteratively tuned using observed data and metrics.

## 2. Common but more contextual or niche

- **FDD – Feature-Driven Development**: Process built around delivering small, client-valued features; fits teams wanting structured agile.  
- **Configuration-Driven Development (CDD)**: Heavy use of configuration/metadata to define behavior, common in platforms and SaaS products.  
- **Readme-Driven Development (RDD)**: Write the README/API contract first, then implement to fit it; popular in OSS and API work.

## 3. Mostly tongue-in-cheek / soft practices

- **Bug-Driven Development (BgDD)**: Work dictated by bug queue rather than roadmap.  
- **Active-Admin-Driven Development (AADD)** and similar: Domain ends up shaped by the chosen admin / scaffolding tool rather than the other way around.  
- **"Story-Driven", "Example-Driven", etc.**: Usually just local labels for flavors of BDD/ATDD rather than distinct methods.
