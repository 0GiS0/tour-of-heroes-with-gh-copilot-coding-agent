import express from 'express';
import config from './config/index.js';
import heroRoutes from './routes/hero.routes.js';
import { errorHandler } from './middlewares/error.middleware.js';

const app = express();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/api/heroes', heroRoutes);

// Error handler
app.use(errorHandler);

// Start server
app.listen(Number(config.PORT), () => {
  console.log(`Server running on port ${config.PORT} in ${config.NODE_ENV} mode`);
});
