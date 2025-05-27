import mongoose, { Schema, Document } from 'mongoose';
import { Hero } from './hero.model.js';

// Interface for Hero document
export interface HeroDocument extends Omit<Hero, '_id'>, Document {}

// Schema definition for Hero
const heroSchema = new Schema<HeroDocument>({
  name: { type: String, required: true },
  alterEgo: { type: String },
  powers: { type: [String], required: true },
  team: { type: String },
});

// Create and export the Hero model
export const HeroModel = mongoose.model<HeroDocument>('Hero', heroSchema);
