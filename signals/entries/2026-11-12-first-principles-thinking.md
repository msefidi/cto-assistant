# First-principles thinking when AI moves the constraints

- **Source:** Own exploration, prompted by [Hire for product craft](2026-11-12-craft-over-ai-pilled.md). References: Aristotle, *Physics* I.1 and *Metaphysics* V.1 (first principles as the first basis from which a thing is known); Elon Musk, interview with Kevin Rose, *Foundation*, 2012 (battery cost rebuilt from raw-material prices instead of market prices); G. K. Chesterton, *The Thing*, 1929 (the fence parable); Sackett et al., "Evidence based medicine: what it is and what it isn't", BMJ 1996; Taiichi Ohno, *Toyota Production System*, 1978 (five whys).
- **Type:** own thought
- **Captured:** 2026-11-12
- **Lenses:** me / leads / department
- **Themes:** Leadership in the AI age · AI-native product management · Skills and learning
- **Status:** captured

## Gist
First-principles thinking means breaking a problem down to what is known to be true, then reasoning up from there. The alternative is **reasoning by analogy**: "others do it this way" or "we've always done it this way". Analogy is cheap and usually good enough. First principles is expensive and pays off when the inputs have changed. Musk's battery example is the standard illustration: instead of accepting the market price of battery packs, price the raw materials and ask why the gap is so large.

Chesterton's fence is the counterweight. Before you remove a fence, find out why it was put up. That is Hemal Shah's **historian** skill from the Skip episode. The two skills work together: first principles asks *is this still true?*, and history asks *why did we believe it?*

## Why it matters now (my framing)
- Many FOMF processes, roles and tool choices are fences built for a constraint: building is slow, analysis needs an analyst, internal UIs are costly, specs must be complete because engineering time is scarce. AI is changing several of these constraints at once. Habits learned by analogy keep the old fence after the reason for it has gone.
- "What are other companies doing with AI?" is reasoning by analogy, and it leads to copying. A better question is: *what is the job, and what is now cheap or still expensive?*
- AI tools are very good at producing the typical answer. When everyone has the typical answer for free, the human edge is to question the premise and to stay close to the user.

## For FOMF: where we have already done it
- **Platform North Star:** the SaaS analogy says usage drives retention. Our data showed that usage and CME do not predict renewal (85% of renewals are automatic), so the question becomes *why do members actually pay?*
- **WebUps:** the assumption was that free WebUps bring new customers. They drive about 2–7% of new paying customers, and mostly existing customers attend.
- **Eviplex:** the v1 answer-quality issues led to a rewrite instead of further tuning. Evidence-based medicine is a first-principles discipline in itself: Sackett's definition is the explicit use of current best evidence plus clinical expertise plus patient values.
- **Security vendor:** "a Mandiant-grade assessment" turned into the question *which risks do we need covered?*, and we chose Blaze at a fraction of the cost.

## Failure modes
- **First-principles theatre:** rebuilding solved problems from scratch and ignoring hard-won knowledge (the fence).
- **Analysis paralysis:** using first principles on low-stakes, stable decisions where analogy is fine.
- **Ignoring real constraints:** for Eviplex, MDR, the EU AI Act, GDPR and § 203 are fundamental truths, not assumptions to question.

## Who could use this
- **Vahid:** product decisions on the Platform. Start each spec with "what do we know to be true about the user?" instead of "what does competitor X do?".
- **George, Simone:** which team processes (estimation, handovers, Retool-first) are fences whose reason has changed. This applies especially to the Productivity team, whose reason to exist assumed that internal tools are costly to build.
- **Viktor, Rahim:** engineering standards with coding agents. Which review and quality rules protect against a real risk, and which only protect against slow typing?
- **Department:** a shared habit of separating facts from assumptions in specs and decisions.
- **Mahyar:** commercial work on SYFAT and On-Demand Accredited. Price from the value to the customer (passing the specialist exam, earning CME points) rather than from competitor prices.

## Possible move
Add an **assumption ledger** to one spec template, such as the Platform or Eviplex Linear project template. It lists three or four key assumptions, each tagged *fact (source)*, *assumption* or *constraint that AI may have changed*. Pilot it with Vahid on the next Platform project, and use Claude as a sparring partner to surface hidden assumptions.
