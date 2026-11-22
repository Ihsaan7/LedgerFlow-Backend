import { Inject, Injectable, Logger, OnModuleInit } from '@nestjs/common';
import { Pool } from 'pg';
import { DATABASE_POOL } from './database.provider.js';

@Injectable()
export class DatabaseCheckService implements OnModuleInit {
  private readonly logger = new Logger(DatabaseCheckService.name);

  constructor(@Inject(DATABASE_POOL) private readonly pool: Pool) {}

  async onModuleInit(): Promise<void> {
    const result = await this.pool.query('SELECT current_database() AS name');
    this.logger.log(`Connected to database: ${result.rows[0].name}`);
  }
}