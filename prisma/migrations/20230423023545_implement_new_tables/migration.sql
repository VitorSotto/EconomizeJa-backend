/*
  Warnings:

  - You are about to drop the column `pass` on the `User` table. All the data in the column will be lost.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "cart" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    CONSTRAINT "cart_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "produtos" (
    "Id_produto" TEXT NOT NULL PRIMARY KEY,
    "Nome" TEXT NOT NULL,
    "Fornecedor" TEXT,
    "Mercado" TEXT NOT NULL,
    "Imagem" TEXT NOT NULL,
    "cartId" TEXT,
    CONSTRAINT "produtos_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "cart" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "precos" (
    "Id_preco" TEXT NOT NULL PRIMARY KEY,
    "Categoria" TEXT NOT NULL,
    "Preco" DECIMAL NOT NULL,
    "Data" DATETIME NOT NULL,
    "Id_produto" TEXT NOT NULL,
    CONSTRAINT "precos_Id_produto_fkey" FOREIGN KEY ("Id_produto") REFERENCES "produtos" ("Id_produto") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'USER',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" DATETIME NOT NULL
);
INSERT INTO "new_User" ("createdAt", "deletedAt", "email", "id", "name") SELECT "createdAt", "deletedAt", "email", "id", "name" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "precos_Id_produto_key" ON "precos"("Id_produto");
