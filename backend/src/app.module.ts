import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller.js';
import { AppService } from './app.service.js';
import { databaseProvider } from './database/database.provider.js';
import { DatabaseCheckService } from './database/database-check.service.js';
import { DatabaseShutdownService } from './database/database-shutdown.service.js';

@Module({
  imports: [ConfigModule.forRoot({isGlobal: true})],
  controllers: [AppController],
  providers: [
    AppService,
    databaseProvider,
    DatabaseCheckService,
    DatabaseShutdownService,
  ],
})
export class AppModule {}
