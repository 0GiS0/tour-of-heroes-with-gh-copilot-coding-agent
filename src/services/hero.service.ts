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

// Define interface for hero creation result
export interface CreateHeroResult {
  success: boolean;
  hero?: Hero;
  error?: string;
}

// Define interface for hero deletion result
export interface DeleteHeroResult {
  success: boolean;
  message?: string;
  error?: string;
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

  /**
   * Create a new hero in the database
   * @param hero Hero data to create
   * @returns Promise resolving to create result with success flag and hero or error
   */
  async createHero(hero: Omit<Hero, 'id'>): Promise<CreateHeroResult> {
    try {
      // Check if a hero with the same name already exists
      const existingHeroByName = await HeroModel.findOne({ name: hero.name });
      if (existingHeroByName) {
        return {
          success: false,
          error: `A hero with the name "${hero.name}" already exists`,
        };
      }

      // Check if any hero has the same set of powers
      const heroWithSamePowers = await HeroModel.findOne({
        powers: { $size: hero.powers.length, $all: hero.powers },
      });

      if (heroWithSamePowers) {
        return {
          success: false,
          error: `A hero with the same powers already exists (${heroWithSamePowers.name})`,
        };
      }

      // Create the new hero
      const newHero = new HeroModel({
        name: hero.name,
        alterEgo: hero.alterEgo,
        powers: hero.powers,
        team: hero.team,
      });

      await newHero.save();

      return {
        success: true,
        hero: newHero,
      };
    } catch (error) {
      console.error('Error creating hero:', error);
      return {
        success: false,
        error: 'An unexpected error occurred while creating the hero',
      };
    }
  }

  /**
   * Delete a hero from the database
   * @param id Hero id to delete
   * @param confirm Confirmation flag to ensure deletion is intentional
   * @returns Promise resolving to delete result with success flag and message or error
   */
  async deleteHero(id: number, confirm: boolean): Promise<DeleteHeroResult> {
    try {
      // Check if confirmation is provided
      if (!confirm) {
        return {
          success: false,
          error: 'Confirmation is required to delete a hero',
        };
      }

      // Check if hero exists
      const hero = await HeroModel.findOne({ id });
      if (!hero) {
        return {
          success: false,
          error: `Hero with ID ${id} not found`,
        };
      }

      // Delete the hero
      await HeroModel.deleteOne({ id });

      // Log the deletion for audit purposes
      console.log(`Hero deleted: ${hero.name} (ID: ${id}) at ${new Date().toISOString()}`);

      return {
        success: true,
        message: `Hero ${hero.name} has been deleted`,
      };
    } catch (error) {
      console.error(`Error deleting hero with id ${id}:`, error);
      return {
        success: false,
        error: 'An unexpected error occurred while deleting the hero',
      };
    }
  }
}
