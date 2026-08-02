const GROQ_URL = "https://api.groq.com/openai/v1/audio/transcriptions";

export default {
  async fetch(request) {
    if (request.method === "OPTIONS") {
      return new Response(null, {
        status: 204,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          "Access-Control-Allow-Headers": "content-type, x-groq-key"
        }
      });
    }

    if (request.method !== "POST")
      return new Response("Method Not Allowed", { status: 405 });

    const key = request.headers.get("X-Groq-Key");
    if (!key || !key.trim())
      return new Response(JSON.stringify({ error: "Missing X-Groq-Key" }), {
        status: 401,
        headers: { "content-type": "application/json" }
      });

    const contentType = request.headers.get("content-type") || "";
    if (!contentType.toLowerCase().startsWith("multipart/form-data"))
      return new Response(JSON.stringify({ error: "Expected multipart/form-data" }), {
        status: 415,
        headers: { "content-type": "application/json" }
      });

    const upstream = await fetch(GROQ_URL, {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${key.trim()}`,
        "Content-Type": contentType
      },
      body: request.body
    });

    const response = new Response(upstream.body, upstream);
    response.headers.set("Access-Control-Allow-Origin", "*");
    return response;
  }
};
