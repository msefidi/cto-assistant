# Blaze mutual NDA: review (27 Oct 2026)

Source: `Blaze Information Security GmbH mutual NDA.docx` (Blaze template, English, 2-year term, Berlin courts). The client party is blank.

**Verdict:** The terms are standard and fair. The template is written for general business talks, though, not for a pentest. During the assessment Blaze will see production systems, credentials and vulnerabilities, and that isn't covered well yet. Ask for the changes below before signing. None of them should be controversial.

## Must change

1. **No purpose or use limit.** The NDA only restricts *disclosure* to third parties. It says nothing about how Blaze may *use* our information. Add: use only to evaluate and perform the security assessment.
2. **Marking requirement.** Information is confidential only if it is marked or we flag it. In a pentest most of what Blaze sees is never marked (systems, data, configs, findings). Add: everything received or observed in connection with the assessment is confidential, marked or not.
3. **3-year protection is too short.** Vulnerabilities, credentials and personal data shouldn't become free to share after 3 years. Ask for no time limit for these, and for trade secrets as long as they stay secret. Otherwise 5 years.
4. **Who owns the reports.** Under clause 4, information stays the property of the party that disclosed it. Blaze discloses the report to us, so the report could count as *Blaze's* confidential information. We would then need their approval to share it with Eviplex GmbH, auditors (ISO), customers (e.g. Swiss hospitals) or advisors. Add: findings and reports about our systems are our confidential information, and we may share them with affiliates, auditors, advisors and customers under confidentiality.
5. **Subcontractors and agents.** Disclosure to "agents" is allowed, and they only need to be "informed". Add: need-to-know only, bound in writing to equal terms, Blaze is liable for them, subcontractors only with our consent. Also ask in the AVV where the testers are located (EU or not).
6. **Parties and affiliates.** Fill in the exact FOMF legal entity. Also cover information from affiliates, in particular Eviplex GmbH (controller for Eviplex, see open point 4 in `vendor-comparison-2026-10.md`).

## Nice to have

- **Legal-disclosure exception** (clause 6, last bullet): as written, information "disclosed pursuant to" a court order stops being confidential altogether. Narrow it to "only to the extent required, with prior notice where lawful". Clause 3 already requires notice.
- **"Exemplary damages"** is a US concept (punitive damages) and doesn't exist in German law. Delete it.
- **"Laws of Berlin, Germany"** should read "laws of the Federal Republic of Germany". Berlin as the place of jurisdiction is fine.
- **Return or destruction:** add written confirmation. Blaze's offer says data is destroyed 30 days after the retest. Reference that.
- **Precedence:** the "entire agreement" clause shouldn't let a later MSA/SOW weaken confidentiality. Say the stricter rule applies.

## Out of scope for the NDA

Personal data (production testing, read-only data-lake access) is handled in the **AVV under Art. 28 GDPR**. We already asked Blaze for this.

## Timing

The internal ingress findings (`vendor-comparison-2026-10.md`, "Internal only") should only go to Blaze after the NDA is signed.

---

## Reply to Caroline (English)

Context: Caroline sent the NDA on 8 Oct 2026 (thread "Ihre Anfrage für einen Pentest bei Blaze Information Security", cc Jan and Andreas). She asked for our company details so she can complete the draft and send it via DocuSign. Julio Fort (co-founder) signs for Blaze. She also confirmed that the testers are an in-house team based in Europe, and that Blaze will send a DPA after the meeting.

**Subject:** Re: Ihre Anfrage für einen Pentest bei Blaze Information Security

Hi Caroline,

apologies, I missed your NDA email earlier in this thread. We'd like to sign it before we go further. Our details:

- FomF GmbH (Forum für medizinische Fortbildung), Am Untertor 4, 65719 Hofheim, Germany, HRB 78202
- Signatory: [name, position]

Since you'll have access to production systems, credentials and vulnerability details during the project, we'd ask for a few small changes:

1. **Purpose:** Confidential information may only be used to evaluate and perform the security assessment. At the moment the NDA only limits disclosure, not use.
2. **No marking needed:** Everything you receive or observe in connection with the assessment (credentials, architecture, configurations, data, vulnerabilities) is confidential, whether or not it is marked.
3. **Duration:** For vulnerabilities, credentials and personal data, protection without time limit; otherwise 5 years instead of 3.
4. **Reports:** Findings and reports about our systems are our confidential information. We may share them, under confidentiality, with our affiliates (including Eviplex GmbH), auditors, advisors and customers.
5. **Subcontractors:** Disclosure only to people who need the information for the project and who are bound in writing to equivalent terms. Blaze is liable for them, and subcontractors only with our prior consent.
6. **Minor points:** Disclosure required by law only to the extent required and with prior notice to us. Please delete "exemplary damages", change "laws of Berlin" to "laws of the Federal Republic of Germany", and confirm return or destruction in writing.

Happy to sign via DocuSign as soon as these are in. Personal data we'll cover separately in the DPA, as you suggested.

Best regards,
Mahyar
