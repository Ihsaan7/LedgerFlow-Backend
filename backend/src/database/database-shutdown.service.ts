import {
  Inject,
  Injectable,
  Logger,
  OnApplicationShutdown,
} from '@nestjs/common';
import { Pool } from 'pg';
import { DATABASE_POOL } from './database.provider.js';

@Injectable()
export class DatabaseShutdownService implements OnApplicationShutdown {
  private readonly logger = new Logger(DatabaseShutdownService.name);

  constructor(@Inject(DATABASE_POOL) private readonly pool: Pool) {}

  async onApplicationShutdown(): Promise<void> {
    await this.pool.end();
    this.logger.log('Database pool closed');
  }
}