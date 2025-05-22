import { Router } from 'express';
import { HeroController } from '../controllers/hero.controller';

const router = Router();
const heroController = new HeroController();

// Define routes - these are just placeholders, actual implementation will be done in another issue
router.get('/', (req, res, next) => heroController.getHeroes(req, res, next));
router.get('/:id', (req, res, next) => heroController.getHeroById(req, res, next));

export default router;
