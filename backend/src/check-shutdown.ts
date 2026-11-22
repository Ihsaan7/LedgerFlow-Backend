import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module.js';

async function main(): Promise<void> {
  const app = await NestFactory.createApplicationContext(AppModule);
  await app.close();
}

void main();