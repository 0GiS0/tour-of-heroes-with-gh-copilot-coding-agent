import { Hero } from '../models/hero.model.js';
import { HeroModel } from '../models/hero.schema.js';

export class HeroService {
  /**
   * Get all heroes from the database
   * @returns Promise resolving to an array of heroes
   */
  async getHeroes(): Promise<Hero[]> {
    try {
      const heroes = await HeroModel.find().sort({ id: 1 });
      return heroes;
    } catch (error) {
      console.error('Error fetching heroes:', error);
      return [];
    }
  }

  /**
   * Get a hero by id from the database
   * @param id Hero id to find
   * @returns Promise resolving to the hero or null if not found
   */
  async getHeroById(id: number): Promise<Hero | null> {
    try {
      const hero = await HeroModel.findOne({ id });
      return hero;
    } catch (error) {
      console.error(`Error fetching hero with id ${id}:`, error);
      return null;
    }
  }
}
