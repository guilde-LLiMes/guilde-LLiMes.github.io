---
title: "X-Driven Development Styles: A Reference Guide"
layout: post
date: 2026-02-24
author: kirby
tags: [methodology, reference, software-development]
---

A collected list of "Driven Development" styles documented in software development literature and blogs. Sources: [Wikipedia](https://en.wikipedia.org/wiki/List_of_software_development_philosophies)

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

| Name                               | Typical acronym | Main driver/focus                    |
|------------------------------------|-----------------|--------------------------------------|
| Test-Driven Development            | TDD             | Automated tests first                |
| Behavior-Driven Development        | BDD             | Observable behavior & examples       |
| Feature-Driven Development         | FDD             | Small, client-valued features        |
| Domain-Driven Design/Development   | DDD             | Domain model & ubiquitous language   |
| Data-Driven Development            | DDD             | Real-world data and metrics          |
| Event-Driven Development           | EDD             | Events and asynchronous messaging    |
| Acceptance Test-Driven Development | ATDD            | Acceptance criteria/tests            |
| Continuous Test-Driven Development | CTDD            | Continuous TDD practice              |
| Spec/Specification-Driven Dev      | SDD             | Detailed specs & examples            |
| Design-Driven Development          | D3              | Up-front and ongoing design          |
| User-Driven Development            | UDD             | User feedback and involvement        |
| Value-Driven Development           | VDD             | Business value and outcomes          |
| Configuration-Driven Development   | CDD             | Config/metadata                      |
| Readme-Driven Development          | RDD             | README/spec as contract              |
| Bug-Driven Development             | BgDD            | Fixing reported bugs                 |
| Active-Admin-Driven Development    | AADD            | Admin tooling constraints            |

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

