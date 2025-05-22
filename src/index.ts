import express from 'express';
import config from './config';
import heroRoutes from './routes/hero.routes';
import { errorHandler } from './middlewares/error.middleware';

const app = express();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/api/heroes', heroRoutes);

// Error handler
app.use(errorHandler);

// Start server
app.listen(config.PORT, () => {
  console.log(`Server running on port ${config.PORT} in ${config.NODE_ENV} mode`);
});