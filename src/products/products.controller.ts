import { Controller, Get, Param, ParseIntPipe } from '@nestjs/common';
import { ProductsService } from './products.service';

@Controller('api/products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService) {}

  @Get()
  findAll() {
    return this.productsService.findAll();
  }

  @Get(':page')
  findByPage(@Param('page', ParseIntPipe) page: number) {
    return this.productsService.findByPage(page);
  }

  @Get('category/:category/:page')
  filterByCategory(
    @Param('category') category: string,
    @Param('page', ParseIntPipe) page: number,
  ) {
    return this.productsService.filterByCategory(category, page);
  }

  @Get('search/:search/:page')
  filterBySearch(
    @Param('search') search: string,
    @Param('page', ParseIntPipe) page: number,
  ) {
    return this.productsService.filterBySearch(search, page);
  }
}
