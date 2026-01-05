# Bringing AI to Healthcare's Most Frustrating Problem

A healthcare technology company had built a robust electronic prior authorization platform. They needed AI to transform it from a data pipeline into an intelligent assistant. Working with POD Consulting, they added multi-agent AI capabilities that reduced PA processing from 15-20 minutes to 2-3 minutes—benefiting doctors, patients, and pharmaceutical manufacturers struggling with medication access barriers.

---

## Three Problems, One Solution

### The Doctor's Office: Drowning in Paperwork

Sarah runs a diabetes clinic treating 300+ patients monthly. When she prescribes a GLP-1 medication for diabetes or weight management, her staff faces a 30-question prior authorization form. They dig through EMR records for A1C levels, previous medications tried, patient weight history, and contraindications. Each PA consumes 15-20 minutes of clinical staff time—time not spent with patients.

For specialty medications, 40% of PAs get denied on first submission. The appeal process requires more documentation, phone calls to insurers, and weeks of delay. Sarah's practice handles thousands of PAs annually. The administrative burden is unsustainable.

**The core problem**: Clinical data exists in the EMR, but extracting it, interpreting payer requirements, and crafting compliant narratives requires expertise and time that practices don't have.

### The Pharmaceutical Manufacturer: Great Drugs, Impossible Access

A pharmaceutical company developed an innovative GLP-1 medication for weight management—a medication that changes lives. But insurance companies require extensive documentation: BMI calculations, previous weight loss attempts, comorbidity evidence, specific ICD-10 codes. Many doctors' offices lack the administrative capacity to navigate these requirements.

The manufacturer employs field reimbursement managers (FRMs) to help practices with PA submissions. It's expensive, doesn't scale, and still results in 40%+ denial rates when documentation doesn't precisely match payer criteria.

**The core problem**: Effective medications sit unused because the administrative barrier between prescription and patient is too high. Human FRMs can't serve every practice, and generic PA tools don't understand brand-specific payer requirements.

### The Patient: Waiting for Medicine They Need

James's doctor prescribed a GLP-1 medication for his Type 2 diabetes after metformin failed. The PA was denied—missing documentation of the metformin trial. His doctor's office submitted an appeal three weeks later. James waited 45 days for approval while his blood sugar remained uncontrolled.

83% of appeals eventually succeed, but only 10% of patients appeal denied PAs. Most give up, try different (often less effective) medications, or abandon treatment.

**The core problem**: Patients bear the cost of administrative inefficiency through delayed care, medication switches, and gaps in treatment—often for drugs their doctors have already determined they need.

---

## The Solution: AI Agents That Understand Medicine and Bureaucracy

The healthcare technology company already had the infrastructure: an electronic PA platform integrated with payers via NCPDP, capable of retrieving dynamic question sets and submitting responses. What they needed was intelligence.

POD Consulting architected and built a multi-agent AI system with two specialized agents:

**HCP Agent** (Healthcare Provider Agent): Serves all medications
- Reads clinical data from EMR systems and claims databases
- Answers PA questions with confidence scores (0-1 scale)
- Generates clinical narratives justifying prescriptions
- Flags uncertain answers for human review (maintains 95% accuracy)

**FRM Agent** (Field Reimbursement Manager Agent): Manufacturer-specific optimization
- Pre-submission: Provides brand-specific PA guidance (common denial reasons, required documentation, step therapy rules)
- Post-draft: Reviews HCP Agent's answers and corrects them using manufacturer knowledge bases (optimal ICD-10 codes, payer-specific criteria)
- Predicts denial likelihood before submission
- Generates appeal strategies when denials occur

The system operates in a two-phase workflow:

1. **Pre-guidance**: For manufacturer-sponsored drugs (GLP-1s, oncology medications), the FRM Agent queries the manufacturer's knowledge base to inject brand-specific criteria into the narrative generation process.

2. **Post-review**: After the HCP Agent drafts answers, the FRM Agent validates them against payer requirements and corrects common errors (e.g., selecting E66.01 for morbid obesity instead of generic obesity codes, confirming step therapy documentation).

For Sarah's GLP-1 prescription, the system:
- Extracted A1C trends from the EMR automatically
- Pulled metformin prescription history from claims data
- Generated a clinical narrative explaining inadequate glycemic control
- FRM Agent ensured the ICD-10 code matched the manufacturer's payer guidance
- Submitted the PA in under 3 minutes with 95% accuracy

---

## What Changed

### For Doctor's Offices

**Before**: 15-20 minutes per PA, staff burnout, delayed patient care
**After**: 2-3 minutes with AI assistance, 80%+ questions auto-answered

Sarah's clinic now processes PAs in real-time during appointments. The AI drafts answers, clinical staff validates uncertain fields (flagged by confidence scores), and submission happens the same day. Appeal handling—previously 4-6 hours of manual work—now takes 3-5 minutes with automated appeal generation.

### For Pharmaceutical Manufacturers

**Before**: Field reimbursement managers serving practices manually, limited reach, high cost
**After**: AI FRM Agents providing brand-specific optimization at scale

The manufacturer's FRM Agent serves every practice prescribing their GLP-1 medications, correcting ICD-10 codes and validating payer criteria before submission. Goal: Improve approval rates through better documentation. The model scales infinitely without adding human FRMs. Multiple pharmaceutical companies have deployed similar agents for their specialty medications.

### For Patients

**Before**: Weeks waiting for PA approvals, 40% denial rates, 90% abandon appeals
**After**: Same-day PA submissions, higher approval rates, automated appeals

James's GLP-1 PA was submitted correctly the first time—metformin trial documented, step therapy requirements met. Approved in 72 hours instead of 45 days. When a different patient's PA was denied for insufficient documentation, the system auto-generated an appeal with additional evidence and submitted it within the 60-day window.

---

## How It Works (Without the Implementation Details)

The existing platform handled the plumbing—payer integration, question set retrieval, submission workflows. POD Consulting added the intelligence layer.

The AI agents use Azure AI Search to query manufacturer knowledge bases containing PA guides, common denial patterns, and payer-specific requirements. When answering questions, the agents tag each answer with:

- **Confidence score** (0-1): Flags low-confidence answers for human review
- **Provenance**: Links to source EMR sections or claim records
- **Source attribution**: Agent vs. human (for compliance and continuous improvement)

For denials, the system maps payer-specific rejection codes to 27 standardized CMS denial reason codes, enabling analytics and appeal automation. Appeal deadlines (60 days standard, 72 hours expedited) are tracked automatically with escalation to supervisors as deadlines approach.

The architecture integrates AI orchestration with the existing EPA and case management microservices via event-driven messaging. When a denial occurs, the EPA service publishes an event; the case management service creates an appeal case; the AI agent generates the appeal request.

---

## The Results

**Operational**:
- PA processing: **15-20 minutes → 2-3 minutes** (85% reduction)
- Appeal processing: **4-6 hours → 3-5 minutes** (95% reduction)
- Form accuracy: **95%** (AI + human validation)
- Coverage: **80%+** of questions auto-answered

**Business**:
- Practices: Reduced staff burnout, faster patient care, zero missed appeal deadlines
- Manufacturers: Scalable FRM capabilities, higher prescription fill rates through improved documentation
- Patients: Faster medication access, higher appeal success rates
- Platform: CMS compliance achieved, new revenue stream from manufacturer partnerships

---

## Why It Worked

**1. AI Complemented Humans Instead of Replacing Them**

100% automation fails in healthcare. Clinical complexity requires judgment. The confidence scoring system (0-1 per answer) lets AI handle routine questions while flagging edge cases for expert review. This achieves both high accuracy (95%) and high automation (80%+).

**2. Manufacturer Knowledge Bases Drove Outcomes, Not Just Efficiency**

Generic PA automation saves time. Brand-specific optimization improves approval rates. The FRM Agent's two-phase model (pre-guidance + post-review) enabled manufacturers to embed their PA expertise at scale—something human FRMs couldn't achieve across thousands of practices.

**3. The Platform Was Already There**

The healthcare technology company had built the hard parts: payer integrations, NCPDP messaging, case management workflows. Adding AI didn't require rebuilding the foundation—it enhanced existing capabilities. The AI layer integrated via events and APIs, not wholesale replacement.

---

## What's Next

The initial deployment serves multiple pharmaceutical manufacturers across therapeutic areas including diabetes, weight management, and oncology.

Future capabilities:
- Predictive denial prevention (analyze patterns before submission)
- Patient self-service appeals (guided workflows for beneficiaries)
- Expanded therapeutic areas and additional manufacturer partnerships

The platform is in production, processing PAs for healthcare partners and pharmaceutical manufacturer clients.

---

*Case study authored January 2025. Represents AI capabilities added to an electronic prior authorization platform through collaboration with POD Consulting.*
