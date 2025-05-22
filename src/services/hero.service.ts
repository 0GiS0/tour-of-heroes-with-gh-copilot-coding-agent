import { Hero } from '../models/hero.model';

export class HeroService {
  // This is just a placeholder - actual implementation will be done in another issue
  getHeroes(): Promise<Hero[]> {
    return Promise.resolve([]);
  }

  getHeroById(id: number): Promise<Hero | null> {
    return Promise.resolve(null);
  }
}