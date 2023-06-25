import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/prisma.service';

@Injectable()
export class ProductsService {
  constructor(private readonly prismaService: PrismaService) {}

  async findAll() {
    return this.prismaService.price.findMany({ include: { product: true } });
  }

  async findByPage(page: number) {
    const pageSize = 12;
    const skip = (page - 1) * pageSize;
    const take = pageSize;

    const totalCount = await this.prismaService.price.count();
    const totalPages = Math.ceil(totalCount / pageSize);

    const products = await this.prismaService.price.findMany({
      skip,
      take,
      orderBy: {
        price: 'asc',
      },
      include: {
        product: true,
      },
    });

    return {
      data: products,
      page,
      pageSize,
      totalCount,
      totalPages,
    };
  }

  async filterByCategory(category: string, page: number) {
    const pageSize = 12;
    const skip = (page - 1) * pageSize;
    const take = 10;

    const totalCount = await this.prismaService.price.count({
      where: {
        category,
      },
    });
    const totalPages = Math.ceil(totalCount / pageSize);

    const prices = await this.prismaService.price.findMany({
      skip,
      take,
      orderBy: {
        price: 'asc',
      },
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

    return {
      data: newPrices,
      page,
      pageSize,
      totalCount,
      totalPages,
    };
  }
}
