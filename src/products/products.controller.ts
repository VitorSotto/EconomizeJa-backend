import { Controller, Get, Param } from '@nestjs/common';
import { ProductsService } from './products.service';

@Controller('api/products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService) {}

  @Get()
  findAll() {
    return this.productsService.findAll();
  }

  @Get(':category')
  filterByCategory(@Param('category') category: string) {
    return this.productsService.filterByCategory(category);
  }
}
