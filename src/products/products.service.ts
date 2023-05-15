import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/prisma.service';

@Injectable()
export class ProductsService {
  constructor(private readonly prismaService: PrismaService) {}

  async findAll() {
    return this.prismaService.price.findMany({ include: { product: true } });
  }

  async filterByCategory(category: string) {
    return this.prismaService.price.findMany({
      include: { product: true },
      where: { category },
    });
  }
}
