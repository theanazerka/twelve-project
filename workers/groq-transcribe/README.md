# Groq transcription proxy

This is a thin Cloudflare Worker for old iOS clients whose TLS stack cannot
reliably connect to `api.groq.com`. It does not persist API keys: the client
sends its own key in `X-Groq-Key`, and the Worker forwards the multipart body
to Groq.

```sh
npx wrangler login
npx wrangler deploy
```

Put the resulting `https://...workers.dev` URL into the client constant
`TGIOS6GroqTranscriptionURL` in `TGGenericModernConversationCompanion.mm`.
