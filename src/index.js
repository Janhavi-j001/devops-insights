const express = require('express');
const path = require('path');
const app = express();

// Use environment variable for port (for flexibility in Docker), fallback to 3000
const PORT = process.env.PORT || 3000;

// Serve static files from the /public directory
app.use(express.static(path.join(__dirname, 'public')));

// Start the server and bind to 0.0.0.0 so it works inside Docker
app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Blog website running at http://0.0.0.0:${PORT}`);
});
