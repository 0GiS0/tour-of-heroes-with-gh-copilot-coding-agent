import { connectDatabase } from './config/database.js';
import { HeroModel } from './models/hero.schema.js';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/**
 * Seed the database with initial hero data
 */
async function seedDatabase() {
  try {
    // Connect to the database
    await connectDatabase();

    // Check if we already have heroes in the database
    const count = await HeroModel.countDocuments();
    if (count > 0) {
      console.log('Database already has heroes, skipping seed');
      process.exit(0);
    }

    // Read heroes data from the JSON file
    const dataPath = path.join(__dirname, 'data', 'heroes_data.json');
    const heroesData = JSON.parse(fs.readFileSync(dataPath, 'utf-8'));

    // Insert the heroes into the database
    await HeroModel.insertMany(heroesData);
    console.log(`Successfully seeded ${heroesData.length} heroes into the database`);
    process.exit(0);
  } catch (error) {
    console.error('Error seeding database:', error);
    process.exit(1);
  }
}

// Run the seed function
seedDatabase();
