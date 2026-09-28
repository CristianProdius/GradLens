import express from 'express';

const databaseUrl = process.env.DATABASE_URL;

if (!databaseUrl) {
  console.error('DATABASE_URL is not set');
  process.exit(1);
}

const app = express();

const PORT = Number(process.env.PORT) || 3000;

app.use(express.json());

app.get('/api/health', (_req, res) => {
  res.status(200).json({
    status: 'ok',
  });
});

app.listen(PORT, () => {
  console.log(`API running on port ${PORT}`);
});