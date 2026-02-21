# Git Workflow & Branch Strategy

This repository follows a structured branching model to maintain stability and scalability.

---

## Branch Types

### main
- Always stable
- Production-ready code only
- Tagged releases (v0.x)
- No direct commits allowed

### develop
- Integration branch
- All features merged here first
- May contain ongoing development

### feature/*
- Used for developing new modules or enhancements
- Created from `develop`
- Merged back into `develop`

Example:
feature/dio-driver  
feature/stm32f4-support  
feature/startup-layer  

### bugfix/*
- Used for fixing issues
- Created from `develop`
- Merged back into `develop`

---

## Workflow

feature → develop → release → main

1. Create feature branch from develop
2. Implement and commit changes
3. Merge into develop
4. Once develop stable, create release branch
4. Merge release into main
5. Tag release

---

## Commit Message Format

Use conventional style:

feature: add dio driver  
fix: correct clock configuration  
docs: update architecture documentation  
chore: update gitignore  

Avoid vague messages like:
update  
changes  
fix  

---

## Rules

- Do not commit directly to main
- Keep commits small and logical
- Test before merging to develop
- Tag milestone releases