import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller.js';
import { AppService } from './app.service.js';
import { databaseProvider } from './database/database.provider.js';

@Module({
  imports: [ConfigModule.forRoot({isGlobal: true})],
  controllers: [AppController],
  providers: [AppService , databaseProvider],
})
export class AppModule {}
