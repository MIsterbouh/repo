const express = require('express');
const client = require('prom-client');

const app = express();
const port = 3000;

// Prometheus metrics
const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics({ timeout: 5000 });

app.get('/', (req, res) => {
  res.send('Hello Kactus! This is the Internal Application.');
});

app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
});

app.listen(port, () => {
  console.log(`Internal App listening on port ${port}`);
});
