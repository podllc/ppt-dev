# Content Inventory & Reorganization Plan

## Current Files

### Reference Material (NOT for website - background/planning docs)

1. **airlift-offering.md**
   - Source: Extracted from Airlift.Mar.2024.pptm PowerPoint
   - Purpose: Reference material showing original Airlift offering structure
   - Contains: Full PowerPoint extraction with maturity models, case studies, detailed processes
   - **Recommendation**: KEEP as reference, move to `/reference/` folder

2. **ai-development-approach.md**
   - Source: Initial draft of AI-driven development content
   - Purpose: Deep dive on using AI for development (early version)
   - Contains: Multi-repo development patterns, progressive adoption, technical details
   - **Recommendation**: ARCHIVE - content merged into website versions
   - **Status**: REDUNDANT with website-content/airlift-ai-transformation.md

3. **ai-section-overview.md**
   - Source: Initial draft of AI product capabilities
   - Purpose: Deep dive on building AI into products (early version)
   - Contains: AI philosophy, testing, human-in-loop, maturity models
   - **Recommendation**: ARCHIVE - content merged into website versions
   - **Status**: REDUNDANT with website-content/ai-thought-leadership.md

4. **airlift-ai-integration.md**
   - Source: Planning document for how AI integrates with Airlift
   - Purpose: Detailed integration strategy and progressive adoption levels
   - Contains: Very detailed technical explanation of 4-level progression, all 5 disciplines
   - **Recommendation**: KEEP as reference, move to `/reference/` folder
   - **Note**: Too detailed for website, but valuable for internal planning

### Website Content (READY for podconsulting.com)

5. **website-content/airlift-overview.md**
   - Purpose: Main Airlift landing page
   - Audience: Clients exploring Airlift offering
   - Tone: POD conversational
   - Contains: Embedded vs Project-based, four disciplines overview, three-project progression
   - **Status**: READY - Primary Airlift page

6. **website-content/airlift-traditional.md**
   - Purpose: Deep dive on Traditional Airlift (UI/UX, DevOps, Process, Architecture)
   - Audience: Clients interested in modernization without AI focus
   - Tone: POD conversational
   - Contains: Four disciplines detailed, maturity models, case studies, three-project progression
   - **Status**: READY - Airlift sub-page

7. **website-content/airlift-ai-transformation.md**
   - Purpose: Airlift for AI Transformation offering page
   - Audience: Clients interested in AI adoption
   - Tone: POD conversational
   - Contains: Progressive adoption (4 levels), AI in products + development, three-project progression
   - **Status**: READY - Airlift sub-page

8. **website-content/ai-thought-leadership.md**
   - Purpose: AI philosophy and approach (thought leadership)
   - Audience: Prospects evaluating POD's AI expertise
   - Tone: POD conversational
   - Contains: AI position, narrowly tailored agents, testing approach, when to say no
   - **Status**: READY - AI section page

### Case Study (Anonymized, ready for website)

9. **epa-ai-automation-case-study.md**
   - Purpose: Healthcare AI automation case study
   - Audience: Prospects wanting proof of AI capabilities
   - Tone: POD conversational
   - Contains: Three stakeholder perspectives (doctors, manufacturers, patients), anonymized
   - **Status**: READY - Case study page

---

## Issues Identified

### 1. Duplication
- `ai-development-approach.md` duplicates `website-content/airlift-ai-transformation.md` (development AI portions)
- `ai-section-overview.md` duplicates `website-content/ai-thought-leadership.md`
- `airlift-ai-integration.md` is more detailed version of `website-content/airlift-ai-transformation.md`

### 2. Reference vs Website Confusion
- `airlift-offering.md` is PowerPoint extraction, not website-ready copy
- `airlift-ai-integration.md` is too detailed/technical for website (planning doc)

### 3. Missing Clear Website Structure
Need clear hierarchy for podconsulting.com:
```
Services
├── Systems Integration (existing)
├── Airlift
│   ├── Overview (airlift-overview.md)
│   ├── Traditional Airlift (airlift-traditional.md)
│   └── Airlift for AI Transformation (airlift-ai-transformation.md)
└── Artificial Intelligence
    └── AI Thought Leadership (ai-thought-leadership.md)

Case Studies
└── AI-Powered Prior Authorization (epa-ai-automation-case-study.md)
```

---

## Reorganization Plan

### Step 1: Create folder structure
```
case-study/
├── reference/                    # Internal reference docs
│   ├── airlift-offering.md      # PowerPoint extraction
│   └── airlift-ai-integration.md # Detailed integration planning
├── archive/                      # Superseded drafts
│   ├── ai-development-approach.md
│   └── ai-section-overview.md
└── website/                      # Website-ready content
    ├── services/
    │   ├── airlift-overview.md
    │   ├── airlift-traditional.md
    │   └── airlift-ai-transformation.md
    ├── ai/
    │   └── ai-thought-leadership.md
    └── case-studies/
        └── epa-ai-automation.md
```

### Step 2: Move files appropriately
- **Reference**: airlift-offering.md, airlift-ai-integration.md
- **Archive**: ai-development-approach.md, ai-section-overview.md
- **Website**: Everything in website-content/ folder

### Step 3: Create index/README for each folder
Explain what's in each folder and purpose

---

## Website Content Summary (Final)

### Services > Airlift Section (3 pages)

**1. Airlift Overview** (`airlift-overview.md`)
- What is Airlift
- Embedded vs Project-based models
- Four disciplines (brief)
- Three-project progression
- When Airlift works

**2. Traditional Airlift** (`airlift-traditional.md`)
- Deep dive on four disciplines (UI/UX, DevOps, Process, Architecture)
- Maturity models
- Case studies (financial services, life sciences, resource management)
- Technologies

**3. Airlift for AI Transformation** (`airlift-ai-transformation.md`)
- AI adoption challenge
- Progressive adoption (Levels 1-4)
- AI in products + AI in development
- Five disciplines enhanced for AI
- Healthcare automation case study

### AI Section (1 page)

**Artificial Intelligence** (`ai-thought-leadership.md`)
- POD's AI philosophy
- Narrowly tailored agents
- Augmentation vs replacement
- Human-in-the-loop
- Testing non-deterministic systems
- When to say no
- Brief case study reference

### Case Studies Section (1 page)

**AI-Powered Prior Authorization** (`epa-ai-automation.md`)
- Three stakeholder perspectives
- Technical approach (high-level)
- Results
- Why it worked

---

## Recommended Actions

1. **Create new folder structure** (reference/, archive/, website/)
2. **Move files** to appropriate folders
3. **Delete website-content/ folder** (flatten to website/)
4. **Create README in each folder** explaining purpose
5. **Update any internal links** in documents
6. **Create master index** showing website page hierarchy

---

## Questions to Answer

1. Do we need both `airlift-ai-integration.md` and `website-content/airlift-ai-transformation.md`?
   - **Answer**: Keep both - one is detailed reference (integration), one is website-ready (transformation)

2. Should case study be in its own section or embedded in AI thought leadership?
   - **Answer**: Separate case study page with link from AI thought leadership

3. Is the three-project progression clear across all Airlift pages?
   - **Answer**: Yes - consistently explained in overview, traditional, and AI transformation pages

4. Do we have the right balance of technical depth vs. accessibility?
   - **Answer**: Website content matches POD tone, reference docs have needed detail
