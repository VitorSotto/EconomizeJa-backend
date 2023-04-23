/*
  Warnings:

  - You are about to drop the column `cartId` on the `Products` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "_CartToProducts" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_CartToProducts_A_fkey" FOREIGN KEY ("A") REFERENCES "Cart" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CartToProducts_B_fkey" FOREIGN KEY ("B") REFERENCES "Products" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Products" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "supplier" TEXT,
    "market" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "priceId" TEXT NOT NULL,
    CONSTRAINT "Products_priceId_fkey" FOREIGN KEY ("priceId") REFERENCES "Prices" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Products" ("id", "image", "market", "name", "priceId", "supplier") SELECT "id", "image", "market", "name", "priceId", "supplier" FROM "Products";
DROP TABLE "Products";
ALTER TABLE "new_Products" RENAME TO "Products";
CREATE UNIQUE INDEX "Products_priceId_key" ON "Products"("priceId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_CartToProducts_AB_unique" ON "_CartToProducts"("A", "B");

-- CreateIndex
CREATE INDEX "_CartToProducts_B_index" ON "_CartToProducts"("B");
