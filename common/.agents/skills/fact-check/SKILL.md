---
name: fact-check
description: "Fact-check text against authoritative sources. Use when the user asks to fact-check, verify claims, check citations or sources, or review a document, article, answer, or draft for accuracy. Checks factual accuracy, internal contradictions, citation support, misleading simplifications, and missing conditions. Reports unsupported claims as unverified and gives corrected wording with citations."
---

# Fact Check

## Scope and permissions

Check the text that the user identifies: pasted text, a file, a URL, or a previous answer in the conversation. If the target is not clear, ask which text to check.

The check is read-only. Do not edit the target unless the user asks for the corrections to be applied.

Check factual claims only. Do not check opinions, recommendations, predictions, or matters of style, unless they contain a factual claim. Report a factual premise inside an opinion as its own claim.

## Evidence rules

- Your own memory is not evidence. Use it only to find sources. Every verdict other than unverified must cite a source that you opened in this session.
- Read the relevant passage in the source. A search result title or snippet is not enough to confirm a claim.
- Never invent a source, URL, quotation, page number, or publication detail. If you cannot find a source, the claim is unverified.
- Do not guess. If the evidence is incomplete, conflicting, or inaccessible, mark the claim as unverified and state what is missing.
- If web access or file access is not available, say so at the start. Mark every claim that needs external evidence as unverified.

### Source priority

Prefer sources in this order:

1. Primary sources: official documentation, specifications, standards, legislation, court records, original datasets, peer-reviewed papers, and official statements from the organization concerned.
2. Authoritative secondary sources: systematic reviews, reference works, and recognized expert bodies.
3. Reputable reporting that names its sources.

Use other sources, such as blogs, forums, and aggregators, only to find a better source. Do not rely on them for a verdict unless no better source exists. If you must rely on one, state that the source is weak.

When sources disagree, report the disagreement. Give more weight to primary and more recent sources, and state the reason for your verdict.

For facts that change over time, such as software versions, prices, statistics, office holders, and laws, record the date or version that the source applies to.

## Workflow

### 1. Extract the claims

1. Read the full target text.
2. List each check-worthy factual claim. Split compound sentences into separate claims.
3. Include implied claims, numbers, dates, names, quotations, comparisons, causal claims, and claims about what a source says.
4. Record the citation attached to each claim, if one exists.

For a long text, check every claim that the conclusions depend on. Tell the user which claims you did not check, and why.

### 2. Check internal consistency

1. Compare the claims with each other.
2. Find contradictions in numbers, dates, names, definitions, and conclusions.
3. Find conclusions that the text's own evidence does not support.

Report each contradiction with the locations of both statements.

### 3. Verify each claim

1. Find the best available source, using the source priority above.
2. Open the source and read the passage that relates to the claim.
3. Compare the claim to the source for meaning, numbers, units, dates, scope, and conditions.
4. Check for a misleading simplification: the claim can be literally true but omit a condition, exception, limitation, or uncertainty that changes its meaning.

### 4. Check each citation

For each claim that has a citation:

1. Confirm that the cited source exists and is accessible.
2. Confirm that the cited source states or directly supports the claim. A source on the same topic is not support.
3. Check for overstatement: rounded or changed numbers, a stronger conclusion than the source makes, a changed scope or population, or a removed condition.
4. If the citation is a secondary source, find the primary source when practical. Check that the secondary source reports it correctly.

A claim can be true and still have a bad citation. Report the claim verdict and the citation status separately.

### 5. Assign verdicts

Give each claim one verdict:

- **Supported:** an authoritative source confirms the claim, including its conditions.
- **Misleading:** the claim is partly correct, or correct but missing a condition or context that changes its meaning.
- **Incorrect:** an authoritative source contradicts the claim.
- **Unverified:** you cannot find sufficient evidence to confirm or contradict the claim.

Give each citation one status: **supports**, **partly supports**, **does not support**, **inaccessible**, or **none**.

### 6. Write the corrections

For each claim that is not supported, or that has a bad citation:

1. Write corrected wording that is accurate and keeps the original purpose of the sentence.
2. Add the missing conditions, scope, or uncertainty.
3. Cite the source that supports the corrected wording.
4. If no correction can be verified, recommend that the author removes the claim or marks it as unverified.

Change only what the evidence requires. Do not rewrite for style.

## Report

Use this structure:

1. **Summary:** the number of claims checked, the count for each verdict, and the most important problems. State any limits on the check, such as no web access or claims that were not checked.
2. **Internal contradictions:** each contradiction with its locations, or "None found."
3. **Findings:** one entry for each claim, in the order of the target text:
   - The original claim, quoted.
   - Verdict and citation status.
   - Evidence: what the source says, with a short quotation where it helps, and the reference number.
   - Corrected wording, when needed.
4. **References:** a numbered list of every source used. Include the title, author or publisher, date or version, and URL or other locator. Include the date you accessed it for web sources that can change.

Put supported claims in a short list if the target contains many of them. Give full detail for misleading, incorrect, and unverified claims.

Stop after the report. Apply the corrections only if the user asks.
