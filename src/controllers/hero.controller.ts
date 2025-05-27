import { Request, Response, NextFunction } from 'express';
import { HeroService, HeroFilterOptions } from '../services/hero.service.js';

export class HeroController {
  private heroService: HeroService;

  constructor() {
    this.heroService = new HeroService();
  }

  /**
   * Get heroes with optional filtering and pagination
   * @route GET /api/heroes
   * @query {string} name - Filter heroes by name (optional)
   * @query {string} powers - Filter heroes by powers (optional)
   * @query {string} team - Filter heroes by team (optional)
   * @query {number} page - Page number for pagination (default: 1)
   * @query {number} limit - Number of heroes per page (default: 10)
   * @returns {Object} Paginated list of heroes
   */
  async getHeroes(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      // Extract filter and pagination options from query parameters
      const filterOptions: HeroFilterOptions = {
        name: req.query.name as string,
        powers: req.query.powers as string,
        team: req.query.team as string,
        page: req.query.page ? Number(req.query.page) : undefined,
        limit: req.query.limit ? Number(req.query.limit) : undefined,
      };

      // Remove undefined values
      Object.keys(filterOptions).forEach((key) => {
        if (filterOptions[key as keyof HeroFilterOptions] === undefined) {
          delete filterOptions[key as keyof HeroFilterOptions];
        }
      });

      const result = await this.heroService.getHeroes(filterOptions);

      res.status(200).json({
        data: result.heroes,
        metadata: {
          totalHeroes: result.totalHeroes,
          page: result.page,
          limit: result.limit,
          totalPages: result.totalPages,
        },
      });
    } catch (error) {
      next(error);
    }
  }

  /**
   * Get a hero by ID
   * @route GET /api/heroes/:id
   * @param {number} id - Hero ID
   * @returns {Object} Hero details or 404 if not found
   */
  async getHeroById(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const id = Number(req.params.id);

      if (isNaN(id)) {
        res.status(400).json({ error: 'Invalid hero ID. ID must be a number.' });
        return;
      }

      const hero = await this.heroService.getHeroById(id);

      if (!hero) {
        res.status(404).json({ error: 'Hero not found' });
        return;
      }

      res.status(200).json({
        data: hero,
      });
    } catch (error) {
      next(error);
    }
  }
}
