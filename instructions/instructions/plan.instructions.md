# Plan Phase Instructions

## Overview

The Plan phase creates detailed, actionable plans for implementation, including architecture choices and trade-offs.

## Purpose

- Architect solutions
- Choose technologies and patterns
- Identify trade-offs
- Outline implementation strategy

## Inputs

- Technical specifications
- Constitutional constraints

## Process

1. Evaluate architecture options: For larger Web API/Enterprise, use CQRS and MediatR; for others, Minimal API with Repository (EF Core) and Specification patterns; for quick turn, Azure Functions (secure, fast, reliable).
2. Select technologies and frameworks aligned with patterns.
3. Plan implementation sequence based on patterns.
4. Document trade-offs and decisions.

## Outputs

- Architecture plan
- Technology stack decisions
- Implementation roadmap

## Grok Integration

Use Grok for strategic planning and trade-off analysis. Temperature: 0.7 for creative options.

## Next Phase

Proceed to Tasks when plan is approved.
