import { Router } from 'express';
import { HeroController } from '../controllers/hero.controller';

const router = Router();
const heroController = new HeroController();

// Define routes - these are just placeholders, actual implementation will be done in another issue
router.get('/', (req, res) => heroController.getHeroes(req, res));
router.get('/:id', (req, res) => heroController.getHeroById(req, res));

export default router;