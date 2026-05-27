# Omen: AI Terminal & Localization

[![Watch the Omen Demo](https://github.com/user-attachments/assets/7c124570-b16d-46f2-87f3-ef2d603bff08)](https://www.youtube.com/shorts/rrr39HPyEhA)

## Overview
Omen is a high-performance, brutalist AI terminal built to demonstrate seamless third-party LLM integration, custom streaming state mechanics, and enterprise-grade localization. Startups need to reach global markets quickly—this architecture proves that a single codebase can handle real-time token streaming and complex multi-language scaling without sacrificing performance.

## Technical Execution
* **Real-Time Token Streaming:** Replaced standard blocking REST calls with a native Server-Sent Events (SSE) stream via the official Google AI SDK, reducing initial Time-to-First-Token (TTFT) to milliseconds.
* **Custom Terminal Throttle:** Implemented a controlled 5ms frame-by-frame character spooling mechanism inside the Riverpod state layer. This decoupling guarantees a smooth, cinematic mechanical typewriter effect even under massive network payload dumps.
* **Dynamic RTL Flipping:** Engineered flawless, real-time state transitions from English to Arabic (العربية) at the provider level, proving deep expertise in Right-to-Left UI layout and multi-script font rendering.
* **State Persistence:** Utilized Riverpod and SharedPreferences to persist local terminal interactions cleanly. The history ledger automatically populates asynchronously only after a stream generation fully completes.
* **Custom Markdown Rendering:** Built an on-the-fly markdown parsing layer to cleanly structure complex technical outputs and code fragments directly within the monospace terminal UI.

## Tech Stack
* **Frontend:** Flutter
* **State Management:** Riverpod
* **AI Integration:** Gemini 2.5 Flash SDK
* **Local Storage:** SharedPreferences

---

### Local Development Setup
> **Security Note:** To protect billing quotas and third-party access, environment variables containing API keys have been intentionally excluded from this public repository.
>
> To run this project locally:
> 1. Clone the repository.
> 2. Create a `.env.dev` file in the root directory.
> 3. Add your Google AI Studio key: `GEMINI_API_KEY=your_api_key_here`
> 4. Run `flutter pub get` and then `flutter run`.
