const express = require('express');
const path = require('path');
const app = express();
const PORT = 3000;

// Serve files from /public
app.use(express.static(path.join(__dirname, 'public')));

app.listen(PORT, () => {
  console.log(`✅ Blog website running at http://localhost:${PORT}`);
});
