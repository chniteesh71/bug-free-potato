# bug-free-potato
Workflow for Node application.
Node-app/
├─ .github/workflows/ci_image-building.yaml
├─ package.json
├─ package-lock.json
├─ app.js             # Express app (exported for testing)
├─ index.js           # Starts the server
├─ routes/
│   └─ hello.js       # Example route
├─ tests/
│   └─ app.test.js    # Realistic unit/integration tests
├─ Dockerfile
├─ .eslintrc.json     # ESLint config
├─ .gitignore
├─ public/index.html
└─ README.md

Test locally::

Change the Directory to your app:
cd path\to\Node-app
npm install

Start the app:
node index.js

Note: index.js is the entrypoint to your application. app.js has source code

Then open your browser and go to:
http://localhost:3000
http://localhost:3000/hello
curl http://localhost:3000/hello

Run the tests:
npm test

Build the Dockerfile::
docker build -t node-app-local .
docker run -p 3000:3000 node-app-local
