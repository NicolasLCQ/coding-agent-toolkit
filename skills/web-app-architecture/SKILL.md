---
name: web-app-architecture
description: Define the default architecture for web applications with a frontend and a backend when creating them or defining their structure.
---

# Web Application Architecture

For a web application with a frontend and a backend, use the following two directories at the project root by default:

```text
/client/ # contains the UI (frontend)
/server/ # contains the API (backend)
```

Place user interface code in `client/` and API code in `server/`.

This convention does not prescribe a framework, language, or additional internal structure.

Respect any different architecture explicitly requested by the user or required by the project instructions. In an existing project, do not move files solely to apply this convention unless reorganization is requested.
