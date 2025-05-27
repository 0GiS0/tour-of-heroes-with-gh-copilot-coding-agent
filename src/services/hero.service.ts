import { Hero } from '../models/hero.model.js';
import { HeroModel } from '../models/hero.schema.js';

// Define interface for filter options
export interface HeroFilterOptions {
  name?: string;
  powers?: string;
  team?: string;
  page?: number;
  limit?: number;
}

// Define interface for paginated results
export interface PaginatedHeroes {
  heroes: Hero[];
  totalHeroes: number;
  page: number;
  limit: number;
  totalPages: number;
}

export class HeroService {
  /**
   * Get heroes from the database with filtering and pagination
   * @param filterOptions Options for filtering and pagination
   * @returns Promise resolving to paginated heroes
   */
  async getHeroes(filterOptions: HeroFilterOptions = {}): Promise<PaginatedHeroes> {
    try {
      const { name, powers, team, page = 1, limit = 10 } = filterOptions;

      // Build query based on filter options
      const query: Record<string, RegExp | object> = {};

      if (name) {
        query.name = { $regex: name, $options: 'i' }; // Case-insensitive search
      }

      if (powers) {
        query.powers = { $regex: powers, $options: 'i' };
      }

      if (team) {
        query.team = { $regex: team, $options: 'i' };
      }

      // Calculate pagination values
      const skip = (page - 1) * limit;

      // Execute query with pagination
      const heroes = await HeroModel.find(query).sort({ id: 1 }).skip(skip).limit(limit);

      // Get total count for pagination metadata
      const totalHeroes = await HeroModel.countDocuments(query);
      const totalPages = Math.ceil(totalHeroes / limit);

      return {
        heroes,
        totalHeroes,
        page,
        limit,
        totalPages,
      };
    } catch (error) {
      console.error('Error fetching heroes:', error);
      // Return empty result set with pagination info
      return {
        heroes: [],
        totalHeroes: 0,
        page: 1,
        limit: 10,
        totalPages: 0,
      };
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
