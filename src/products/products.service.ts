import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/prisma.service';

@Injectable()
export class ProductsService {
  constructor(private readonly prismaService: PrismaService) {}

  async findAll() {
    return this.prismaService.price.findMany({ include: { product: true } });
  }

  async filterByCategory(category: string) {
    const prices = await this.prismaService.price.findMany({
      include: { product: true },
      where: { category },
    });

    const newPrices = prices.map((pricesItem) => {
      if (pricesItem.product.name.search(category.concat(' ')) !== -1) {
        return pricesItem;
      }
      if (
        pricesItem.product.name.search(
          category
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .concat(' '),
        ) !== -1
      ) {
        return pricesItem;
      }
    });

    for (let i = 0; i < newPrices.length; i++) {
      if (newPrices[i] === null || newPrices[i] === undefined) {
        newPrices.splice(i, 1);
        i--;
      }
    }

    return newPrices;
  }
}
