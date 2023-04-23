/*
  Warnings:

  - Added the required column `priceId` to the `Products` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Prices" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "category" TEXT NOT NULL,
    "price" DECIMAL NOT NULL,
    "updatedAt" DATETIME NOT NULL,
    "productId" TEXT NOT NULL
);
INSERT INTO "new_Prices" ("category", "id", "price", "productId", "updatedAt") SELECT "category", "id", "price", "productId", "updatedAt" FROM "Prices";
DROP TABLE "Prices";
ALTER TABLE "new_Prices" RENAME TO "Prices";
CREATE UNIQUE INDEX "Prices_productId_key" ON "Prices"("productId");
CREATE TABLE "new_Products" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "supplier" TEXT,
    "market" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "priceId" TEXT NOT NULL,
    "cartId" TEXT,
    CONSTRAINT "Products_priceId_fkey" FOREIGN KEY ("priceId") REFERENCES "Prices" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Products_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "Cart" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Products" ("cartId", "id", "image", "market", "name", "supplier") SELECT "cartId", "id", "image", "market", "name", "supplier" FROM "Products";
DROP TABLE "Products";
ALTER TABLE "new_Products" RENAME TO "Products";
CREATE UNIQUE INDEX "Products_priceId_key" ON "Products"("priceId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
