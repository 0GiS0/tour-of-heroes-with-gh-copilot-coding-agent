import { Request, Response, NextFunction } from 'express';
import { HeroService } from '../services/hero.service.js';

export class HeroController {
  private heroService: HeroService;

  constructor() {
    this.heroService = new HeroService();
  }

  // This is just a placeholder - actual implementation will be done in another issue
  async getHeroes(_req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const heroes = await this.heroService.getHeroes();
      res.status(200).json(heroes);
    } catch (error) {
      next(error);
    }
  }

  async getHeroById(req: Request, res: Response, _next: NextFunction): Promise<void> {
    try {
      const id = Number(req.params.id);
      const hero = await this.heroService.getHeroById(id);

      if (!hero) {
        res.status(404).json({ error: 'Hero not found' });
        return;
      }

      res.status(200).json(hero);
    } catch {
      res.status(500).json({ error: 'Internal Server Error' });
    }
  }
}
