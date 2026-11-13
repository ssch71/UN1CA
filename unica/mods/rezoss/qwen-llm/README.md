# Rezoss AI API app

This module builds the ROM's small settings app and trusted API bridge for the existing ROM text-generation flow.

## Setup

1. Open **AI backend settings** from UN1CA Extra Settings.
2. Choose OpenAI, Gemini, OpenRouter, or a custom endpoint; enter the provider's model name and API key.
3. Save the settings. The API key is encrypted with Android Keystore and is not included in the ROM build.

The app sends non-streaming OpenAI Chat Completions requests. The built-in presets use these endpoints:

- OpenAI: `https://api.openai.com/v1/chat/completions`
- Gemini's OpenAI-compatible endpoint: `https://generativelanguage.googleapis.com/v1beta/openai/chat/completions`
- OpenRouter: `https://openrouter.ai/api/v1/chat/completions`

Custom endpoints must accept a Bearer API key and OpenAI-style `chat/completions` requests, then return text in `choices[0].message.content`. This covers other providers that implement that protocol. There is no single protocol for every vendor: APIs that only expose a different native format need a matching adapter.

## On-device mode

**ROM default (offline)** runs Gemma 4 E2B through LiteRT inside AIOS. Nothing is sent to a provider in this mode. Import `gemma-4-E2B-it.litertlm` once with **Gemma model setup**, then pick the **Gemma accelerator** (GPU or CPU). Qwen3 and its model APKs have been removed; the `io.mesalabs.rezoss.qwen` package name is kept only for API/bridge compatibility.

## Data flow

The ROM keeps its existing screen-text extraction, prompt adaptation, and reply/summary formats. The inference backend sends the resulting text to the configured endpoint and validates the response before returning it to the existing system caller. The API key stays inside the Rezoss AI app process; the AIOS bridge can request a completion but cannot read the saved key. Prompts, responses, and API keys are not written to logs.

Because generation uses a remote API, extracted screen text is sent to the endpoint selected by the user. The app requires HTTPS and does not follow redirects.

## Build

The ROM build runs `system-stub/build.sh` after sourcing the UN1CA `buildenv.sh`. The app is signed with the ROM platform certificate and embeds no model weights.
