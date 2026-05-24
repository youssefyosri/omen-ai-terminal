# Omen: AI Terminal & Localization

[![Watch the Omen Demo](https://github.com/user-attachments/assets/7c124570-b16d-46f2-87f3-ef2d603bff08)](https://www.youtube.com/shorts/rrr39HPyEhA)

## Overview
Omen is a high-performance, brutalist AI terminal built to demonstrate seamless third-party LLM integration and enterprise-grade localization. Startups need to reach global markets quickly, and this architecture proves that a single codebase can handle complex multi-language scaling without sacrificing performance.

## Technical Execution
* **Dynamic RTL Flipping:** Engineered flawless, real-time state transitions from English to Arabic (العربية), proving deep expertise in Right-to-Left UI layout and multi-script font rendering.
* **Custom Parsing:** Implemented a real-time Markdown renderer to cleanly format asynchronous technical outputs on the fly.
* **State Persistence:** Utilized Riverpod and SharedPreferences to persist local interactions instantly, creating a zero-latency history ledger. 

## Tech Stack
* **Frontend:** Flutter
* **State Management:** Riverpod
* **AI Integration:** Gemini API
* **Local Storage:** SharedPreferences

---

### Local Development Setup
> **Security Note:** To protect billing quotas and third-party access, environment variables containing API keys have been intentionally excluded from this public repository.
>
> To run this project locally:
> 1. Clone the repository.
> 2. Create a `.env.dev` file in the root directory.
> 3. Add your Google AI Studio key: `GEMINI_API_KEY=your_api_key_here`
> 4. Run `flutter run`.
