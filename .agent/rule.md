## Antigravity Development Rules

### 1. Clean Code Architecture (Mandatory)

* All code **must follow Clean Code principles**.
* Use proper separation of concerns (presentation, domain, data).
* Ensure readability, scalability, and maintainability.
* Avoid tightly coupled logic.
* Follow SOLID principles where applicable.

---

### 2. Strict File Structure Compliance

* Follow the predefined project file structure **without exceptions**.
* Do not create arbitrary folders or misplace files.
* Each layer (e.g., `widgets`, `utils`, `theme`, `constants`) must be used according to its responsibility.
* Maintain consistent naming conventions.

---

### 3. Maximum Reuse of Existing Components

* Always utilize available project resources:

  * `@const`
  * `@widgets`
  * `@utils`
  * `@theme`
* Do not recreate components that already exist.
* Promote modularity and reusability.
* Keep UI consistent with the existing design system.

---

### 4. Comment Policy

* Do not write unnecessary comments.
* Only add comments when they are technically required.
* All comments must be written **in English**.
* Comments must explain *why*, not *what* (unless clarification is critical).

---

### 5. Strict Adherence to the Plan

* Do not deviate from the approved implementation plan.
* Do not introduce unplanned features or structural changes.
* If ambiguity arises, follow the defined architecture and constraints.

---

### 6. Responsive UI Requirement

* Every widget and UI implementation must be responsive.
* Ensure compatibility across different screen sizes and orientations.
* Follow the same responsiveness standards as existing project pages.
* Avoid hardcoded dimensions unless absolutely necessary.

---

If needed, I can also convert this into:

* A concise version
* A more strict enforcement-style version
* A Markdown documentation version
* A version formatted for internal team guidelines
