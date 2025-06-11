import { Router } from 'express';
import { HeroController } from '../controllers/hero.controller.js';

const router = Router();
const heroController = new HeroController();

// Define routes
router.get('/', (req, res, next) => heroController.getHeroes(req, res, next));
router.get('/:id', (req, res, next) => heroController.getHeroById(req, res, next));
router.post('/', (req, res, next) => heroController.createHero(req, res, next));
router.delete('/:id', (req, res, next) => heroController.deleteHero(req, res, next));

export default router;
